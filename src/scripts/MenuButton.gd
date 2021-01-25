extends MenuButton

var obj_icon = load("res://assets/menu_cube.svg")

var menu

signal obj_selected (obj_name)

func list_files_in_directory(dir:Directory):
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

func _on_item_pressed(id):
	emit_signal("obj_selected", menu.get_item_text(id))
	

