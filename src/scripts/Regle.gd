extends Control


var a := false 
var b := false
var o := false
var h := false
var v := false
var cursor_pos 

var A : Vector2
var B : Vector2



# Called when the node enters the scene tree for the first time.
func _ready():
	#Boxstyle.set_border_color("#6680ff")
	pass



func _process(_delta):
	
	
	var A_pos:Vector2 = $A.rect_global_position
	var B_pos:Vector2 = $B.rect_global_position
	
	var distance = A_pos.distance_to(B_pos)
	
	cursor_pos = get_viewport().get_mouse_position()

	
	if h :
		$Distance.rect_size.x=distance
		$Distance.rect_size.y=64
		$Distance.rect_global_position=$A.rect_global_position +Vector2(16,-16)
		
		
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
	elif v :
		$Distance.rect_size.x=20
		$Distance.rect_size.y=distance
		$Distance.rect_global_position=$A.rect_global_position +Vector2(20,16)
		
		
		if a :
			$A.rect_global_position = cursor_pos
			$Line.set_point_position(0,A_pos-rect_global_position-Vector2(-16,-32))
			$Line.set_point_position(1,Vector2(A_pos.x,B_pos.y)-rect_global_position-Vector2(-16,0))
			$B.rect_global_position.x=A_pos.x
		if b :
			$B.rect_global_position = cursor_pos
			$Line.set_point_position(0,Vector2(B_pos.x,A_pos.y)-rect_global_position-Vector2(-16,-32))
			$Line.set_point_position(1,B_pos-rect_global_position-Vector2(-16,0))
			$A.rect_global_position.x=B_pos.x
		
	$Distance.text= str(distance)
	
	
	
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




func Arrow(A:Vector2,B:Vector2):
	$Line.set_point_position(0,A)
	$Line.set_point_position(1,B)
	update()
	if h:
		
		pass
	if v:
		pass	

func _on_Horizontal_toggled(button_pressed):
	printt("h",button_pressed)
	h = button_pressed
#	if h :
#		$Line.set_point_position(0,Vector2(-100,0))
#		$Line.set_point_position(1,Vector2(100,0))
#		$A.rect_position= Vector2(-100,0)+Vector2(-32,-16)
#		$B.rect_position= Vector2(100,0)+Vector2(0,-16)

func _on_Vertical_toggled(button_pressed):
	printt("v",button_pressed)
	v = button_pressed
#	if v:
#		$Line.set_point_position(0,Vector2(0,100))
#		$Line.set_point_position(1,Vector2(0,-100))
#		$A.rect_position= Vector2(0,-100)+Vector2(-16,-32)
#		$B.rect_position= Vector2(0,100)+Vector2(-16,0)


func _on_Angle_toggled(button_pressed):
	printt("o",button_pressed)
	o = button_pressed

func _draw():
	draw_circle(A,10,"#AAACCC")
	draw_circle(B,10,"#AAACCC")
	
	
