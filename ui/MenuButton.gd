extends MenuButton


var object_list
var obj_icon = load("res://cube.svg") 
var menu

signal obj_selected (obj_name)

# Called when the node enters the scene tree for the first time.
func _ready():
	menu = self.get_popup()

	object_list = list_files_in_directory("res://objects/")
	
	for object in object_list :
		menu.add_icon_item(obj_icon, object)
	
	menu.connect("id_pressed",  self, "_on_item_pressed")


func list_files_in_directory(path):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin(true)

	var file = dir.get_next()
	while file != '' :
		if file.ends_with(".obj"):
			files += [file]
		file = dir.get_next()

	return files


func _on_item_pressed(id):
	emit_signal("obj_selected", menu.get_item_text(id))
	

