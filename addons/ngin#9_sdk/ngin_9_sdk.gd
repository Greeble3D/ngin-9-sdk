@tool
extends EditorPlugin

var ngin_exporter:NGINExporter = null

func _enable_plugin() -> void:
	# Add autoloads here.
	pass


func _disable_plugin() -> void:
	# Remove autoloads here.
	pass


func _enter_tree() -> void:
	# Initialization of the plugin goes here.
	ngin_exporter = NGINExporter.new()
	add_export_plugin(ngin_exporter)
	
	# Find the user's selected root.
	var dock:FileSystemDock = get_editor_interface().get_file_system_dock()
	dock.selection_changed.connect(_on_filesystem_selection_changed)

func _on_filesystem_selection_changed() -> void:
	var selected:PackedStringArray = get_editor_interface().get_selected_paths()
	ngin_exporter.selected_paths = selected
	ngin_exporter.current_selected_directory = get_editor_interface().get_current_directory()

func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	pass
