extends Node

## Handles window/scene loading
##
## When a new window/scene needs to be opened, it goes through this script.

enum {
	MODULE_PROJECT_MANAGER
}

func _ready() -> void:
	print("Window manager starting up ...")
	load_modules()
	
	# On startup we need the project manager to popup
	show_window_module(MODULE_PROJECT_MANAGER)


func load_modules() -> void:
	# TODO: Go into user://Modules and go through every subfolder and
	# load all modules into the project
	# ProjectSettings.load_resource_pack(module_path)
	pass


func show_window_module(module: int) -> void:
	match module:
		MODULE_PROJECT_MANAGER:
			pass
		_: 
			printerr("Invalid module!")
			return



func load_window_module(module_type: TYPE, module_name: String = "default") -> void:
	print("Loading module '%s' of type '%s' ..." % [module_name, module_type])
	var module_path := "res://modules/" if module_name == "default" else "user://Modules/"
	var scene_path := module_path
	match module_type:
		TYPE.PROJECT_MANAGER:
			module_path += "ProjectManager/"
			scene_path += "ProjectManager/project_manager.tscn"
		_: 
			printerr("Could not find module_type '%s'" % module_type)
			return
	module_path += "%s.pck" % module_name
	
	var success = ProjectSettings.load_resource_pack(module_path)
	if !success:
		printerr("Could not load pck file!")
		return
	var module_window = load(scene_path)
	
	Globals.main.add_child(module_window.instantiate())


func open_window_inscreen(window_name: String) -> void:
	print("Opening inscreen window '%s' ..." % window_name)
	
	var new_window := load("res://scenes/%%/%%.tscn".replace("%%", window_name))
	Globals.main.add_child(new_window.instantiate())