extends MenuButton

var obj_icon = load("res://assets/menu_cube.svg")

const dirPath = "res://objects/"

const extension = ".obj"

const files = ["res://objects/Articulation Fourche.obj","res://objects/Articulation.obj","res://objects/Bride.obj","res://objects/Connecteur.obj","res://objects/Guide.obj","res://objects/Socle.obj"]

var menu

signal obj_selected (obj_name)

func _ready():
	menu = self.get_popup()
	
	for file in files:
		var name = file.get_file().get_basename()
		
		menu.add_icon_item(obj_icon, name)
		
	menu.connect("id_pressed",  self, "_on_item_pressed")

func _on_item_pressed(id):
	emit_signal("obj_selected", dirPath + menu.get_item_text(id) + extension)
