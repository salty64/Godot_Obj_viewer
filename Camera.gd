extends Spatial



export (float, 0.0, 2.0) var rotation_speed = PI/2

# mouse properties

export (float, 0.001, 0.1) var mouse_sensitivity = 0.005



# zoom settings

export (float) var zoom = 0.15

export (float) var zoom_min = 0.1
export (float) var zoom_max = 2
export (float, 0.05, 1.0) var zoom_speed = 0.05

const camera_x_home = 90
const camera_y_home = 0


var camera_x
var camera_y

var mouse_rotate_button = false

var position3D : Vector3
var doubleclik : bool = false


var A = false

onready var innerGimbal = $InnerGimbal
onready var camera = $InnerGimbal/Camera
onready var raycast = $InnerGimbal/Camera/RayCast
onready var ig = $"../IG"
onready var tween = $Tween

func _ready():
	innerGimbal.rotation.x = deg2rad(camera_x_home)
	self.rotation.y = deg2rad(camera_y_home)
	pass 


func draw_line(v:Vector3, v1:Vector3, c:Color):
	ig.set_color(c)
	ig.add_vertex(v)
	ig.add_vertex(v1)

func _unhandled_input(event):
	
	if (event is InputEventMouseButton && event.button_index == BUTTON_WHEEL_UP):
		zoom -= zoom_speed
	if (event is InputEventMouseButton && event.button_index == BUTTON_WHEEL_DOWN):
		zoom += zoom_speed
	
	# a faire que sur modif de zoom
	zoom = clamp(zoom, zoom_min, zoom_max)
	camera.size = zoom
	
	if (event is InputEventMouseButton && event.button_index == BUTTON_RIGHT && event.pressed):
		mouse_rotate_button = true
	if (event is InputEventMouseButton && event.button_index == BUTTON_RIGHT && !event.pressed):
		mouse_rotate_button = false
	

	if (mouse_rotate_button and event is InputEventMouseMotion):
		if event.relative.x != 0:
			self.rotate_object_local(Vector3.UP, event.relative.x * mouse_sensitivity)
	
		if event.relative.y != 0:
			innerGimbal.rotate_object_local(Vector3.RIGHT, event.relative.y * mouse_sensitivity)

	
func _physics_process(_delta):
	if Input.is_action_just_pressed("mouse_center"):
		var position2D = get_viewport().get_mouse_position()

		position3D = camera.project_ray_origin(position2D)

		position3D = camera.to_local(position3D)

		raycast.translation = Vector3(position3D.x, position3D.y, 0)
		raycast.force_raycast_update()
		
		if raycast.is_colliding():
			var normale = raycast.get_collision_normal()

			var origin_normale = raycast.get_collision_point()

			var dir = camera.global_transform.basis.z

			ig.clear()
			ig.begin(Mesh.PRIMITIVE_LINES)
			draw_line(Vector3.ZERO,dir*0.25,Color.red)
			draw_line(Vector3.ZERO,normale*0.25,Color.violet)
			ig.end()
	
			var normal_x = Vector2(normale.x, normale.z)

			var normal_y = Vector2(normal_x.length(), normale.y)

			var dir_x = Vector2(dir.x, dir.z)

			var dir_y = Vector2(dir_x.length(), dir.y)

			var angle_x = dir_x.angle_to(normal_x)

			if normal_x.length() > 0.01:
				var finalAngle = rotation.y - angle_x
				
				tween.interpolate_property(self, "rotation:y", null, finalAngle, 0.7, Tween.TRANS_QUART, Tween.EASE_IN_OUT)
#				rotate_y(-angle_x)

			var angle_y = dir_y.angle_to(normal_y)

			if innerGimbal.rotation.x >= -PI/2 and innerGimbal.rotation.x <= PI/2:
				angle_y = -angle_y

			printt (rad2deg(angle_x), camera.rotation_degrees)
			
			var finalAngle = innerGimbal.rotation.x+angle_y
			tween.interpolate_property(innerGimbal, "rotation:x", null, finalAngle, 0.7, Tween.TRANS_QUART, Tween.EASE_IN_OUT)
#			innerGimbal.rotate_x(angle_y)
			
			tween.start()
			
#			var rotSpeed = 1
#			var angleDiff = angle_y
#
#			var timeToTurn = abs(angleDiff/deg2rad(rotSpeed))
#			var tween = $"../Rotate_x"
#			tween.interpolate_property(self,"rotation.y",
#			camera.rotation.y,
#			angleDiff,
#			timeToTurn,
#			tween.TRANS_LINEAR,
#			tween.EASE_OUT
#			)
#			tween.start()
#			
#

func _process(_delta):
	
	

	if Input.is_action_just_pressed("ui_home"):
		innerGimbal.rotation.x = deg2rad(camera_x_home)
		self.rotation.y = deg2rad(camera_y_home)

	if Input.is_action_pressed("ui_left"):
		self.rotation.y = self.rotation.y + deg2rad(5)

	if Input.is_action_pressed("ui_right"):
		self.rotation.y = self.rotation.y - deg2rad(5)

	if Input.is_action_pressed("ui_up"):
		innerGimbal.rotation.x = innerGimbal.rotation.x + deg2rad(5)

	if Input.is_action_pressed("ui_down"):
		innerGimbal.rotation.x = innerGimbal.rotation.x - deg2rad(5)
	
	
	if Input.is_action_just_pressed("mouse_left"):
		var position2D = get_viewport().get_mouse_position()
		if !A :
			printt("A",position2D)
			$"../Control/Regle/Line2D".set_point_position(0,position2D)
			A = true
		else :
			print("B")
			$"../Control/Regle/Line2D".set_point_position(1,position2D)
			A = false
			



