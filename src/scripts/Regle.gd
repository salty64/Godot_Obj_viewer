extends Control


var a := false
var b := false
var c := false
var h := false
var v := false
var o := false
var l := false
var cursor_pos

var pool:PoolVector2Array

var Color_rouge = "#F06F65"
var Color_vert = "#2EF238"
var Color_jaune = "#DBAF1F"
var Color_bleu = "#1F78DB"
var Color_violet = "#F323F9"

var Color_cotation 

var valeur_mesure

onready var A = $A
onready var B = $B
onready var C = $C

onready var Mesure = $Mesure
onready var camera = $"../../CameraGimbal/InnerGimbal/Camera"
var c1 
var c2

var label_hauteur = 100
var label_largeur = 100


func _ready():
	pool.append(Vector2(-100,0))
	pool.append(Vector2(100,0))
	pool.append(Vector2(-50,50))
	A.rect_position = pool[0] - A.rect_size/2
	B.rect_position = pool[1] - B.rect_size/2
	C.rect_position = pool[2] - C.rect_size/2


func _physics_process(_delta):
	if visible :
		if h or v :
			c1 = camera.project_ray_origin(pool[0])
			c2 = camera.project_ray_origin(pool[1])
			

func _process(_delta):

	if visible :
		var distance = pool[0].distance_to(pool[1])
		if h or v :
			valeur_mesure = stepify((1000 * c1.distance_to(c2)),0.1)

		cursor_pos = get_viewport().get_mouse_position() - rect_global_position

		if h :
			Mesure.rect_size =Vector2(distance,label_hauteur)
			Mesure.rect_position = pool[0] - Vector2(0,label_hauteur/2)
			if a :
				pool[0]= cursor_pos
				A.rect_position = pool[0] - A.rect_size/2
				pool[1].y = pool[0].y
				B.rect_position.y = A.rect_position.y
				update()
			if b :
				pool[1]= cursor_pos
				B.rect_position = pool[1] - B.rect_size/2
				pool[0].y = pool[1].y
				A.rect_position.y = B.rect_position.y
				update()
		elif v :
			Mesure.rect_size =Vector2(label_largeur,distance)
			Mesure.rect_position = pool[0] - Vector2(label_largeur/2,0)
			if a :
				pool[0]= cursor_pos
				A.rect_position = pool[0] - A.rect_size/2
				pool[1].x = pool[0].x
				B.rect_position.x = A.rect_position.x
				update()
			if b :
				pool[1]= cursor_pos
				B.rect_position = pool[1] - B.rect_size/2
				pool[0].x = pool[1].x
				A.rect_position.x = B.rect_position.x
				update()
		elif l:
			Mesure.rect_size =Vector2(distance,label_hauteur)
			Mesure.rect_position = pool[0] - Vector2(0,label_hauteur/2)
			if a :
				pool[0]= cursor_pos
				A.rect_position = pool[0] - A.rect_size/2
				update()
			if b :
				pool[1]= cursor_pos
				B.rect_position = pool[1] - B.rect_size/2
				update()
		elif o :
			if a :
				pool[0]= cursor_pos
				A.rect_position = pool[0] - A.rect_size/2
				update()
			if b :
				pool[1]= cursor_pos
				B.rect_position = pool[1] - B.rect_size/2
				update()
			if c :
				pool[2]= cursor_pos
				C.rect_position = pool[2] - C.rect_size/2
				update()
			
			var v1 = (pool[0]-pool[1]).normalized()
			var v2 = (pool[2]-pool[1]).normalized()
			var alpha = v1.angle_to(v2)
			
			valeur_mesure = stepify(abs(rad2deg(alpha)),0.1)
			
			Mesure.rect_size =Vector2(label_largeur,label_hauteur)
			Mesure.rect_position = pool[1] - Vector2(0,label_hauteur)

		Mesure.text= str(valeur_mesure)


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
	
func _on_C_button_down():
	c = true
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _on_C_button_up():
	c = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)



func _on_Horizontal_toggled(button_pressed):
	h = button_pressed
	if h :
		pool[0]=(Vector2(-100,0))
		pool[1]=(Vector2(100,0))
		
		A.rect_position = pool[0] - A.rect_size/2
		B.rect_position = pool[1] - B.rect_size/2
		C.visible =!button_pressed
		Color_cotation=Color_rouge
		update()

func _on_Vertical_toggled(button_pressed):
	v = button_pressed
	if v:
		pool[0]=(Vector2(0,-100))
		pool[1]=(Vector2(0,100))
		
		A.rect_position = pool[0] - A.rect_size/2
		B.rect_position = pool[1] - B.rect_size/2
		C.visible =!button_pressed
		Color_cotation=Color_vert
		update()

func _on_Libre_toggled(button_pressed):
	l = button_pressed
	if l:
		pool[0]=(Vector2(-100,100))
		pool[1]=(Vector2(+100,-100))
		
		A.rect_position = pool[0] - A.rect_size/2
		B.rect_position = pool[1] - B.rect_size/2
		C.visible =!button_pressed
		Color_cotation=Color_violet
		update()

func _on_Angle_toggled(button_pressed):
	
	o = button_pressed
	if o:
		C.visible =button_pressed
		pool[0]=(Vector2(80,-100))
		pool[1]=(Vector2(0,0))
		if pool.size() != 3 :
			pool.append(Vector2(100,80))

		A.rect_position = pool[0] - A.rect_size/2
		B.rect_position = pool[1] - B.rect_size/2
		C.rect_position = pool[2] - C.rect_size/2
		Color_cotation=Color_bleu
		update()
		
func _draw():
	draw_arc(pool[0], 15, 0, 2*PI, 16,Color_cotation,2,true)
	draw_arc(pool[1], 15, 0, 2*PI, 16,Color_cotation,2,true)
	if !o:
		if pool.size() == 3 :
			pool.remove(2)
	else :
		draw_arc(pool[2], 15, 0, 2*PI, 16,Color_cotation,2,true)
		var v1 = (pool[0]-pool[1]).normalized()
		var v2 = (pool[2]-pool[1]).normalized()
		var angle_depart = Vector2(1,0).angle_to(v1)
		var angle_arrive = Vector2(1,0).angle_to(v2)
#		if v1.angle_to(v2) < 0 :
#			angle_depart = Vector2(1,0).angle_to(v1)
#			angle_arrive = Vector2(1,0).angle_to(v2)
		
		draw_arc(pool[1], 50, angle_depart,angle_arrive , 16,Color_cotation,2,true)
	draw_polyline ( pool, Color_cotation,2,true)

	






