extends Control

var point_a := false
var point_b := false
var point_c := false

var horizontal := true
var vertical := false
var angle := false
var free := false

var cursor_pos

var pool:PoolVector2Array

var Color_rouge = "#F06F65"
var Color_vert = "#2EF238"
var Color_jaune = "#DBAF1F"
var Color_bleu = "#1F78DB"
var Color_violet = "#F323F9"

var Color_cotation = Color_rouge

var cross_color = "#585150 "

var valeur_mesure

onready var A = $A
onready var B = $B
onready var C = $C

onready var Mesure = $Mesure
onready var camera = $"../../Viewport/Spatial/CameraGimbal/InnerGimbal/Camera"
var c1 
var c2

var label_hauteur = 100
var label_largeur = 100

var middle_point = Vector2(0,0)

func _ready():
	pool.append(Vector2(-100,0))
	pool.append(Vector2(100,0))
	pool.append(Vector2(-50,50))
	A.rect_position = pool[0] - A.rect_size/2
	B.rect_position = pool[1] - B.rect_size/2
	C.rect_position = pool[2] - C.rect_size/2


func _physics_process(_delta):
	if visible :
		if horizontal or vertical or free:
			c1 = camera.project_ray_origin(pool[0])
			c2 = camera.project_ray_origin(pool[1])


func _process(_delta):

	if visible :
		
#		var distance = pool[0].distance_to(pool[1])

		cursor_pos = get_viewport().get_mouse_position() - rect_global_position

		if horizontal or vertical or free :
			valeur_mesure = stepify((500 * c1.distance_to(c2)),0.1)
			
			middle_point = pool[0] - (pool[0]-pool[1])/2
		else :
			middle_point = Vector2((pool[0].x+pool[1].x+pool[2].x)/3,(pool[0].y+pool[1].y+ pool[2].y)/3)

		if horizontal :

			if point_a :
				pool[0]= cursor_pos
				A.rect_position = pool[0] - A.rect_size/2
				pool[1].y = pool[0].y
				B.rect_position.y = A.rect_position.y
				update()
			if point_b :
				pool[1]= cursor_pos
				B.rect_position = pool[1] - B.rect_size/2
				pool[0].y = pool[1].y
				A.rect_position.y = B.rect_position.y
				update()
		elif vertical :

			if point_a :
				pool[0]= cursor_pos
				A.rect_position = pool[0] - A.rect_size/2
				pool[1].x = pool[0].x
				B.rect_position.x = A.rect_position.x
				update()
			if point_b :
				pool[1]= cursor_pos
				B.rect_position = pool[1] - B.rect_size/2
				pool[0].x = pool[1].x
				A.rect_position.x = B.rect_position.x
				update()
		elif free:
			
			if point_a :
				pool[0]= cursor_pos
				A.rect_position = pool[0] - A.rect_size/2
				update()
			if point_b :
				pool[1]= cursor_pos
				B.rect_position = pool[1] - B.rect_size/2
				update()
		elif angle :
			
			if point_a :
				pool[0]= cursor_pos
				A.rect_position = pool[0] - A.rect_size/2
				update()
			if point_b :
				pool[1]= cursor_pos
				B.rect_position = pool[1] - B.rect_size/2
				update()
			if point_c :
				pool[2]= cursor_pos
				C.rect_position = pool[2] - C.rect_size/2
				update()
			
			var v1 = (pool[0]-pool[1]).normalized()
			var v2 = (pool[2]-pool[1]).normalized()
			var alpha = v1.angle_to(v2)
			
			valeur_mesure = stepify(abs(rad2deg(alpha)),0.1)


		Mesure.rect_size =Vector2(label_largeur,label_hauteur)
		Mesure.rect_position = middle_point + Vector2(-Mesure.rect_size.x/2,-Mesure.rect_size.y/2)
		Mesure.text= str(valeur_mesure)


func _on_A_button_down():
	point_a = true
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _on_A_button_up():
	point_a = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_B_button_down():
	point_b = true
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _on_B_button_up():
	point_b = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
func _on_C_button_down():
	point_c = true
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _on_C_button_up():
	point_c = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)



func _on_Horizontal_toggled(button_pressed):
	horizontal = button_pressed
	
	if horizontal:
		pool[0] = Vector2(-100,0)
		pool[1] = Vector2(100,0)
		
		A.rect_position = pool[0] - A.rect_size/2
		
		B.rect_position = pool[1] - B.rect_size/2
		
		C.visible = !button_pressed
		
		Color_cotation = Color_rouge
		
		update()

func _on_Vertical_toggled(button_pressed):
	vertical = button_pressed
	if vertical:
		pool[0]=(Vector2(0,-100))
		pool[1]=(Vector2(0,100))
		
		A.rect_position = pool[0] - A.rect_size/2
		B.rect_position = pool[1] - B.rect_size/2
		C.visible =!button_pressed
		Color_cotation=Color_vert
		update()

func _on_Libre_toggled(button_pressed):
	free = button_pressed
	if free:
		pool[0]=(Vector2(-100,100))
		pool[1]=(Vector2(+100,-100))
		
		A.rect_position = pool[0] - A.rect_size/2
		B.rect_position = pool[1] - B.rect_size/2
		C.visible =!button_pressed
		Color_cotation=Color_violet
		update()

func _on_Angle_toggled(button_pressed):
	angle = button_pressed
	
	if angle:
		C.visible = button_pressed
		
		pool[0] = Vector2(80,-100)
		pool[1] = Vector2(0,0)
		pool[2] = Vector2(100,80)

		A.rect_position = pool[0] - A.rect_size/2
		B.rect_position = pool[1] - B.rect_size/2
		C.rect_position = pool[2] - C.rect_size/2
		
		Color_cotation = Color_bleu
		
		update()
		
func _draw():
	
	draw_arc(pool[0], 15, 0, 2*PI, 16, Color_cotation, 2, true)
	draw_arc(pool[1], 15, 0, 2*PI, 16, Color_cotation, 2, true)
	
	var v1 = (pool[0]-pool[1]).normalized()
	
	var v2 = (pool[2]-pool[1]).normalized()
	
	if angle:
		draw_arc(pool[2], 15, 0, 2*PI, 16, Color_cotation, 2, true)
		
		var angle_depart = Vector2(1,0).angle_to(v1)
	
		var angle_arrive = Vector2(1,0).angle_to(v2)
	
		draw_arc(pool[1], 30, angle_depart, angle_arrive, 16, Color_cotation, 2, true)

		draw_polyline (pool, Color_cotation, 2, true)
		draw_line(pool[2]+Vector2(0,30), pool[2]+Vector2(0,5), cross_color, 1, true)
		draw_line(pool[2]+Vector2(0,-30), pool[2]+Vector2(0,-5), cross_color, 1, true)
		draw_line(pool[2]+Vector2(30,0), pool[2]+Vector2(5,0), cross_color, 1, true)
		draw_line(pool[2]+Vector2(-30,0), pool[2]+Vector2(-5,0), cross_color, 1, true)
	else:
		draw_line(pool[0], pool[1], Color_cotation, 2, true)
	
	draw_line(pool[0]+Vector2(0,30), pool[0]+Vector2(0,5), cross_color, 1, true)
	draw_line(pool[0]+Vector2(0,-30), pool[0]+Vector2(0,-5), cross_color, 1, true)
	draw_line(pool[0]+Vector2(30,0), pool[0]+Vector2(5,0), cross_color, 1, true)
	draw_line(pool[0]+Vector2(-30,0), pool[0]+Vector2(-5,0), cross_color, 1, true)
	
	draw_line(pool[1]+Vector2(0,30), pool[1]+Vector2(0,5), cross_color, 1, true)
	draw_line(pool[1]+Vector2(0,-30), pool[1]+Vector2(0,-5), cross_color, 1, true)
	draw_line(pool[1]+Vector2(30,0), pool[1]+Vector2(5,0), cross_color, 1, true)
	draw_line(pool[1]+Vector2(-30,0), pool[1]+Vector2(-5,0), cross_color, 1, true)
