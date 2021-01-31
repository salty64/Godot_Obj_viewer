extends MenuButton

var obj_icon = load("res://assets/menu_cube.svg")

var dirPath = OS.get_executable_path().get_base_dir()+"/objects/"

var menu

signal obj_selected (obj_name)

var dir = Directory.new()

func list_files_in_directory():
	menu = self.get_popup()
	
	if dir.list_dir_begin(true) == OK:
		var file = dir.get_next()
	
		while file != '' :
			if file.ends_with(".obj"):
				menu.add_icon_item(obj_icon, file)
			file = dir.get_next()
		
		dir.list_dir_end()
			
		menu.connect("id_pressed",  self, "_on_item_pressed")
		
		return
		
	print("Failed to open stream list")

func _ready():
	if dir.dir_exists(dirPath) and dir.open(dirPath) == OK:
		list_files_in_directory()
	else:
		print("Failed to open directory : " + dirPath)

func _on_item_pressed(id):
	emit_signal("obj_selected", dirPath + menu.get_item_text(id))
