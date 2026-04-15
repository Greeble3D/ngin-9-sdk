extends EditorExportPlugin
class_name NGINExporter

## Paths selected in the export preset (used as roots for mod discovery)
var selected_paths:PackedStringArray = []

## Last resolved directory from selection (used as fallback search root)
var current_selected_directory:String = ""

## Full list of files included in the export preset
var files_to_export:PackedStringArray = []

## All discovered mod.cfg paths from selected locations
var mod_configs:PackedStringArray = []

## Text-based assets referenced by mod configs (cfg, txt, lua, etc.)
var text_assets:PackedStringArray = []

func _export_begin(features: PackedStringArray, is_debug: bool, path: String, flags: int) -> void:
	files_to_export.clear()
	mod_configs.clear()
	text_assets.clear()
	var export_preset:EditorExportPreset = get_export_preset()
	files_to_export = export_preset.get_files_to_export().duplicate()
	collect_mod_configs()
	collect_text_assets()
	add_text_assets()
	

## Adds all collected text-based assets to the export package.
##
## Iterates over `text_assets`, reads each file as raw bytes,
## and injects it into the export using `add_file()`, preserving original paths.
##
## Intended for assets referenced in mod.cfg files (e.g. .cfg, .txt, .lua),
## ensuring inclusion even if not part of the default export set.
##
## Behavior:
## - Skips missing or unreadable files and logs errors via `push_error()`
## - Reads full file contents into memory before adding to export
## - Does not modify file paths or contents
##
## Notes:
## - Assumes `text_assets` contains valid, deduplicated file paths
## - May conflict with default export if the same paths are already included
func add_text_assets() -> void:
	for text_asset:String in text_assets:
		if not FileAccess.file_exists(text_asset):
			push_error("Missing text asset: " + text_asset)
			continue

		var file:FileAccess = FileAccess.open(text_asset, FileAccess.READ)
		if file == null:
			push_error("Failed to open: " + text_asset)
			continue

		var bytes:PackedByteArray = file.get_buffer(file.get_length())
		file.close()

		add_file(text_asset, bytes, false)
	var now := Time.get_datetime_string_from_system(false, true)
	print_rich("[color=green]Mod(s) successfully exported. %s[/color]" % now)

## Collects text asset paths referenced by all discovered mod configs.
##
## Reads each mod.cfg and extracts entries from [assets] -> files,
## resolving them relative to the config directory.
##
## Behavior:
## - Skips missing files
## - Avoids duplicate entries in `text_assets`
##
## Notes:
## - Expects `mod_configs` to be populated beforehand
## - Does not validate config structure beyond basic access
func collect_text_assets() -> void:
	for mod_config_path:String in mod_configs:
		var mod_config:ConfigFile = ConfigFile.new()
		mod_config.load(mod_config_path)
		var files:Array = mod_config.get_value("assets", "files", [])
		for file:String in files:
			var text_file:String = mod_config_path.get_base_dir().path_join(file)
			if FileAccess.file_exists(text_file):
				if !text_assets.has(text_file):
					text_assets.append(text_file)
			
## Collects all mod.cfg paths from the currently selected export paths.
##
## Iterates through `selected_paths`, recursively searching for mod.cfg files
## and appending results to `mod_configs`.
##
## Behavior:
## - Aggregates results across all selected paths
## - Logs selected paths for debugging visibility
## - Aborts export if no mod.cfg files are found
##
## Notes:
## - May include duplicate paths if search roots overlap
## - Expects `selected_paths` to be populated before calling
func collect_mod_configs() -> void:
	print("Searching for mod.cfg files in selected folders:")
	for selected_path:String in selected_paths:
		print(" - %s"%selected_path)
	for selected_path:String in selected_paths:
		mod_configs += find_mod_configs_in_selected_path(selected_path)
	if mod_configs.is_empty():
		abort_export_with_no_mod_config()
		return
	else:
		print("Mod configs found:")
		for mod_config:String in mod_configs:
			print(" - %s"%mod_config)

## Finds all mod.cfg files within a given selected path.
##
## Resolves the input path to a valid directory (using its base directory if a file is provided),
## then performs a recursive search for mod.cfg files.
##
## Behavior:
## - Returns an empty array if the path is invalid or empty
## - Falls back to the parent directory if a file path is given
## - Logs an error if no valid directory can be resolved
##
## Notes:
## - Uses `_search_mod_cfg_recursive()` to perform the directory traversal
## - Returned paths are absolute and not deduplicated
func find_mod_configs_in_selected_path(selected_path:String) -> PackedStringArray:
	var found:PackedStringArray = []

	if selected_path.is_empty():
		return found

	var root_path:String = selected_path

	# If a file was passed in, search from its directory instead.
	if not DirAccess.dir_exists_absolute(root_path):
		root_path = selected_path.get_base_dir()

	if not DirAccess.dir_exists_absolute(root_path):
		push_error("search_find_mod_configs_in_selected_path(): Invalid directory: " + selected_path)
		return found

	_search_mod_cfg_recursive(root_path, found)
	return found

## Recursively searches a directory for mod.cfg files.
##
## Traverses the given directory and all subdirectories,
## appending full paths of any "mod.cfg" files found to `out`.
##
## Behavior:
## - Skips "." and ".." directory entries
## - Recurses into subdirectories
## - Appends matching file paths directly to the provided array
## - Logs an error if a directory cannot be opened
##
## Notes:
## - `out` is modified in-place (no return value)
## - Does not deduplicate results
func _search_mod_cfg_recursive(directory_path:String, out:PackedStringArray) -> void:
	var dir:DirAccess = DirAccess.open(directory_path)
	if dir == null:
		push_error("Could not open directory: " + directory_path)
		return

	dir.list_dir_begin()
	var file_name:String = dir.get_next()

	while not file_name.is_empty():
		if file_name != "." and file_name != "..":
			var full_path:String = directory_path.path_join(file_name)

			if dir.current_is_dir():
				_search_mod_cfg_recursive(full_path, out)
			elif file_name == "mod.cfg":
				out.append(full_path)

		file_name = dir.get_next()

	dir.list_dir_end()

func _get_name() -> String:
	return "NGINExporter"

func abort_export_with_no_mod_config() -> void:
	var message:String = _get_no_mod_config_error_message()
	print(message)
	push_error("No mod.cfg files detected. See above message.")

func _get_no_mod_config_error_message() -> String:
	return """
NGIN#9 Export Aborted

No mod configuration (mod.cfg) could be resolved from the current selection.

Please select a folder in the FileSystem dock that contains a mod.cfg file.

The exporter relies on mod.cfg to determine:
- which assets belong to the mod
- which text files to include (cfg, txt, md, lua)
- how the mod manifest is structured

If you have not yet created a mod.cfg, you can generate it from within the game/client.

For more information, see:
res://guides/exporting_mods.md
"""
