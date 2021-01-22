extends Control


var a := false 
var b := false
var h := false
var cursor_pos 


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(_delta):
	
	
	var A_pos:Vector2 = $A.rect_global_position
	var B_pos:Vector2 = $B.rect_global_position
	
	var distance = A_pos.distance_to(B_pos)
	
	cursor_pos = get_viewport().get_mouse_position()
	
	if h :
		if a :
			$A.rect_global_position = cursor_pos
			$Line.set_point_position(0,A_pos-rect_global_position-Vector2(-32,-16))
			$Line.set_point_position(1,Vector2(B_pos.x,A_pos.y)-rect_global_position-Vector2(0,-16))
			$B.rect_global_position.y=A_pos.y
		if b :
			$B.rect_global_position = cursor_pos
			$Line.set_point_position(0,Vector2(A_pos.x,B_pos.y)-rect_global_position-Vector2(-32,-16))
			$Line.set_point_position(1,B_pos-rect_global_position-Vector2(0,-16))
			$A.rect_global_position.y=B_pos.y
			
	$Distance.text= str(distance)
	$Distance.rect_size.x=distance
	$Distance.rect_global_position=$A.rect_global_position
	
func _on_A_button_down():
	a = true
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _on_A_button_up():
	a = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_B_button_down():
	b = true
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _on_B_button_up():
	b = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_Horizontal_toggled(button_pressed):
	printt("h",button_pressed)
	h = button_pressed
