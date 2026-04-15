# Exporting Mods for NGIN#9

NGIN-9 aims to keep the mod creation process as simple and structured as possible.

This guide outlines the basic workflow and requirements for exporting mods.

Modding is often a tedious and complex process. We provide docs here for the core stuff.

---

## Workflow Overview

Mod development in NGIN-9 is split into two distinct work areas:

### Godot Work Area
- Create and organize mod content
- Build scenes, assets, and structures
- Prepare content for export

### Game Work Area (NGIN-9 Client)
- Generate configuration files (`.cfg`)
- Create and manage `mod.cfg`
- Upload and manage Workshop content

This separation ensures a clear division of responsibility:

> Godot handles content creation and export  
> The game client handles configuration and manifest generation

---

## Mod Creation Workflow

1. Decide on a content directory that will contain your mod folders.  
   This can reside anywhere on your system (for example, your Desktop).

2. Assign this directory in the NGIN#9 client:  
   `Workshop → My Mods (Mod Directory)`

3. Using your file manager or the in-game browser, create a new folder for your mod within this directory.

4. Create your content in Godot.

5. Launch the NGIN#9 client.

6. Generate `mod.cfg` via:  
   `Workshop → SDK`

7. Configure your assets using `.cfg` files.  
   *(Refer to example content provided in the Godot SDK project.)*

8. Return to Godot and export the mod as a `.pck` file into your mod folder.

9. In the client, navigate to:  
   `Workshop → Create`

10. Apply the required metadata and configuration.

11. Publish or update your mod from this tab.
---

You now have a working Workshop entry that can be continuously developed, modified, and updated.

---

## The Role of `mod.cfg`

Due to limitations in the Godot export system, NGIN-9 requires a `mod.cfg` file to define the root of a mod and it's mod info.

### Requirements

- A `mod.cfg` must exist **above** the directories you intend to export
- All relevant `.cfg` files must be referenced by the `mod.cfg`
- The exporter uses this file to determine:
  - which assets belong to the mod
  - which configuration files to include

Without a valid `mod.cfg`, the exporter will not export the necessary config files, and things will not work in the game.

---

## Generating `mod.cfg`

`mod.cfg` is generated from within the NGIN-9 client: Workshop → SDK


This process:
- creates the required manifest structure
- ensures compatibility with the Workshop system
- aligns your Godot content with runtime expectations

---

## Important Notes

- Always ensure your mod has a valid `mod.cfg` before exporting
- Select the appropriate mod folder (or a child of it) in the Godot FileSystem dock prior to export
- If no valid mod root is detected, export will be aborted

Why do we do this? Simply whitelisting the files in a the Godot export filters causes ALL text files 
(cfg, lua, etc) in the project to be exported. So we instead manually select the folder 
with the generated manifest to organize this flow in our custom export process. 

Hence you must:
- Select desired folders to export in the editor (containing the mod.cfg files)
- Select those same folders in the export options of Godot select those same folders in:
	Project -> Export -> Resources (Export Selected Scenes (And Dependences)) 
   
We do this due to some limitations in the godot exports API.

---

## Summary

NGIN-9 enforces a structured workflow to maintain:

- modularity
- dependency clarity
- reliable exports

By separating content creation (Godot) from configuration (game client), the system remains predictable and scalable for both developers and modders.
