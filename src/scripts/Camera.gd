extends Spatial

signal zoom_value(value)

export (float, 0.0, 2.0) var rotation_speed = PI/2

# mouse properties

export (float, 0.001, 0.1) var mouse_sensitivity = 0.005



# zoom settings

export (float) var zoom_min = 0.1
export (float) var zoom_max = 0.8
export (float, 0.05, 1.0) var zoom_speed = 0.05

const zoom_home = 0.35
const camera_x_home = 30
const camera_y_home = 15
var zoom := 0.0


var camera_x
var camera_y

var mouse_speed
var mouse_have_move := false

var mouse_rotate_button = false

var position3D : Vector3
var doubleclik : bool = false


var A = false

var finalAngle

onready var innerGimbal = $InnerGimbal
onready var camera = $InnerGimbal/Camera
onready var raycast = $InnerGimbal/Camera/RayCast
onready var ig = $"../IG"
onready var tween = $Tween
onready var tween_zoom = $Tween_zoom
onready var timer = $Timer


func set_zoom(z:float):
	zoom = clamp(z, zoom_min, zoom_max)

	camera.size = zoom

	emit_signal("zoom_value", zoom)

func add_zoom(z:float):
	set_zoom(zoom+z)

func _ready():
	innerGimbal.rotation.x = deg2rad(camera_x_home)
	self.rotation.y = deg2rad(camera_y_home)
	set_zoom(zoom_home)

func draw_line(v:Vector3, v1:Vector3, c:Color):
	ig.set_color(c)
	ig.add_vertex(v)
	ig.add_vertex(v1)
	
func _unhandled_input(event):
	if (event is InputEventMouseButton && event.button_index == BUTTON_WHEEL_UP):
		add_zoom(-zoom_speed)
	if (event is InputEventMouseButton && event.button_index == BUTTON_WHEEL_DOWN):
		add_zoom(zoom_speed)
	
	if (event is InputEventMouseButton && event.button_index == BUTTON_RIGHT && event.pressed):
		mouse_rotate_button = true
	if (event is InputEventMouseButton && event.button_index == BUTTON_RIGHT && !event.pressed):
		mouse_rotate_button = false	

	if event is InputEventMouseMotion:
		mouse_speed = event.relative
		mouse_have_move = true
	
func _physics_process(_delta):
	if !tween.is_active() and !timer.is_stopped() and Input.is_action_just_released("mouse_right"):
		var position2D = get_viewport().get_mouse_position()

		position3D = camera.project_ray_origin(position2D)

		position3D = camera.to_local(position3D)

		raycast.translation = Vector3(position3D.x, position3D.y, 0)
		raycast.force_raycast_update()
		
		if raycast.is_colliding():
			var normale = raycast.get_collision_normal()
			
#			printt(raycast.transform.basis.z, normale)

			var dir = camera.global_transform.basis.z
			
			var col_point = raycast.get_collision_point()

			ig.clear()
			ig.begin(Mesh.PRIMITIVE_LINES)
			draw_line(Vector3.ZERO,dir*0.25,Color.red)
			draw_line(Vector3.ZERO,normale*0.25,Color.violet)
			draw_line(col_point, col_point+normale*0.25, Color.blue)
			ig.end()
	
			var normal_x = Vector2(normale.x, normale.z)

			var normal_y = Vector2(normal_x.length(), normale.y)

			var dir_x = Vector2(dir.x, dir.z)

			var dir_y = Vector2(dir_x.length(), dir.y)

			var angle_x = dir_x.angle_to(normal_x)

			if normal_x.length() > 0.01:
				finalAngle = rotation.y - angle_x
				tween.interpolate_property(self, "rotation:y", null, finalAngle, 0.7, Tween.TRANS_QUART, Tween.EASE_IN_OUT)

			var angle_y = dir_y.angle_to(normal_y)
			if innerGimbal.rotation.x >= -PI/2 and innerGimbal.rotation.x <= PI/2:
				angle_y = -angle_y
			
			finalAngle = innerGimbal.rotation.x + angle_y
			tween.interpolate_property(innerGimbal, "rotation:x", null, finalAngle, 0.7, Tween.TRANS_QUART, Tween.EASE_IN_OUT)
			
			tween.start()

func _process(_delta):
	if Input.is_action_just_pressed("mouse_right"):
		timer.start()
	
	if !tween.is_active() and timer.is_stopped() and mouse_have_move and Input.is_action_pressed("mouse_right"):
		self.rotate_object_local(Vector3.UP, mouse_speed.x * mouse_sensitivity)
	
		innerGimbal.rotate_object_local(Vector3.RIGHT, mouse_speed.y * mouse_sensitivity)
		
		mouse_have_move = false
	

	if Input.is_action_just_pressed("ui_home"):
		finalAngle = deg2rad(camera_y_home)
		tween.interpolate_property(self, "rotation:y", null, finalAngle, 0.7, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
		
		finalAngle = deg2rad(camera_x_home)
		tween.interpolate_property(innerGimbal, "rotation:x", null, finalAngle, 0.7, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
		
		tween.start()

	if Input.is_action_pressed("ui_left"):
		self.rotation.y = self.rotation.y + deg2rad(5)

	if Input.is_action_pressed("ui_right"):
		self.rotation.y = self.rotation.y - deg2rad(5)

	if Input.is_action_pressed("ui_up"):
		innerGimbal.rotation.x = innerGimbal.rotation.x + deg2rad(5)

	if Input.is_action_pressed("ui_down"):
		innerGimbal.rotation.x = innerGimbal.rotation.x - deg2rad(5)

func _on_Zoom_Moins_pressed():
	add_zoom(zoom_speed)

func _on_Zoom_Plus_pressed():
	add_zoom(-zoom_speed)

func _on_VSlider_value_changed(value:float):
	if !is_equal_approx(value, zoom) :
		set_zoom(value)
		
func _on_Zoom_Init_button_down():
	if !is_equal_approx(zoom, zoom_home) :
		tween_zoom.interpolate_property(camera, "size", null, zoom_home, 1, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
		tween_zoom.start()
	
		emit_signal("zoom_value", zoom_home)
