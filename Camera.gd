extends Spatial



export (float, 0.0, 2.0) var rotation_speed = PI/2

# mouse properties

export (float, 0.001, 0.1) var mouse_sensitivity = 0.005




# zoom settings

export (float) var zoom = 0.15

export (float) var zoom_min = 0.1
export (float) var zoom_max = 2
export (float, 0.05, 1.0) var zoom_speed = 0.05

const camera_x_home = 60
const camera_y_home = 15

var camera_x
var camera_y

var mouse_rotate_button = false

var position3D : Vector3
var doubleclik : bool = false

onready var camera = $InnerGimbal/Camera
onready var raycast = $InnerGimbal/Camera/RayCast

func _ready():
	$InnerGimbal.rotation.x = deg2rad(camera_x_home)
	self.rotation.y = deg2rad(camera_y_home)
	pass 


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
			$InnerGimbal.rotate_object_local(Vector3.RIGHT, event.relative.y * mouse_sensitivity)

	
func _physics_process(_delta):
	

		
	if Input.is_action_just_pressed("mouse_center"):
		var position2D = get_viewport().get_mouse_position()

		position3D = camera.project_ray_origin(position2D)
		position3D=camera.to_local(position3D)
		raycast.translation= Vector3(position3D.x, position3D.y,raycast.translation.z)
		raycast.force_raycast_update()
		
		if raycast.is_colliding():

			var normale =raycast.get_collision_normal()
			var origin_normale = raycast.get_collision_point()
			
			var normale_node = $"../normale"
			normale_node.clear()
			normale_node.begin(Mesh.PRIMITIVE_LINES, null)
			normale_node.add_vertex(origin_normale)
			normale_node.add_vertex(origin_normale + normale*0.25)
			normale_node.end()
			
			var vecteur_node = $"../Back"
			vecteur_node.clear()
			vecteur_node.begin(Mesh.PRIMITIVE_LINES, null)
			vecteur_node.add_vertex(origin_normale)
			vecteur_node.add_vertex(origin_normale + Vector3.BACK*0.25)
			vecteur_node.end()
			
			var vecteur_node2 = $"../Vec"
			vecteur_node2.clear()
			vecteur_node2.begin(Mesh.PRIMITIVE_LINES, null)
			vecteur_node2.add_vertex(origin_normale)
			vecteur_node2.add_vertex(origin_normale + Vector3.UP*0.25)
			vecteur_node2.end()

#			var angle_x = normale.angle_to(Vector3.BACK)
#			var angle_y = normale.angle_to(Vector3.UP)


##			camera_x = $InnerGimbal.rotation.x
##
#			if round(rad2deg(angle_x)) != 180 : 
#				angle_x = sign(normale.x)* angle_x
#
#			self.rotation.y = angle_x
#			$InnerGimbal.rotation.x = angle_y
#
#
#			camera_x = $InnerGimbal.rotation.x
##			if camera_x < 0 :
#			printt("inv", rad2deg(camera_x))
##				self.rotation.y = self.rotation.y + PI
##				$InnerGimbal.rotation.x = $InnerGimbal.rotation.x + PI






func _process(_delta):
	
	

	if Input.is_action_just_pressed("ui_home"):
		$InnerGimbal.rotation.x = deg2rad(camera_x_home)
		self.rotation.y = deg2rad(camera_y_home)

	if Input.is_action_pressed("ui_left"):
		self.rotation.y = self.rotation.y + deg2rad(5)

	if Input.is_action_pressed("ui_right"):
		self.rotation.y = self.rotation.y - deg2rad(5)

	if Input.is_action_pressed("ui_up"):
		$InnerGimbal.rotation.x = $InnerGimbal.rotation.x + deg2rad(5)

	if Input.is_action_pressed("ui_down"):
		$InnerGimbal.rotation.x = $InnerGimbal.rotation.x - deg2rad(5)

	

