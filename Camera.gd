extends Spatial



export (float, 0.0, 2.0) var rotation_speed = PI/2

# mouse properties

export (float, 0.001, 0.1) var mouse_sensitivity = 0.005




# zoom settings

export (float) var zoom = 0.15

export (float) var zoom_min = 0.1
export (float) var zoom_max = 2
export (float, 0.05, 1.0) var zoom_speed = 0.05


var mouse_rotate_button = false

var position3D : Vector3
var doubleclik : bool = false

func _ready():
#	$InnerGimbal/Camera/RayCast/coin.show()
	pass 


func _unhandled_input(event):
	
	if (event is InputEventMouseButton && event.button_index == BUTTON_WHEEL_UP):
		zoom -= zoom_speed
	if (event is InputEventMouseButton && event.button_index == BUTTON_WHEEL_DOWN):
		zoom += zoom_speed
	
	zoom = clamp(zoom, zoom_min, zoom_max)
	
	if (event is InputEventMouseButton && event.button_index == BUTTON_RIGHT && event.pressed):
		mouse_rotate_button = true
	if (event is InputEventMouseButton && event.button_index == BUTTON_RIGHT && !event.pressed):
		mouse_rotate_button = false
	
	doubleclik = false
	
	if (event is InputEventMouseButton && event.button_index == BUTTON_LEFT && event.doubleclick):
		doubleclik= true
		var position2D = get_viewport().get_mouse_position()
		
		position3D = $InnerGimbal/Camera.project_ray_origin(position2D)
		print ("doubleclik -> ", position3D)
		
		position3D=$InnerGimbal/Camera.to_local(position3D)
		$InnerGimbal/Camera/coin.translation= Vector3(position3D.x, position3D.y,$InnerGimbal/Camera/coin.translation.z)
		

	if (mouse_rotate_button and event is InputEventMouseMotion):
		if event.relative.x != 0:
			self.rotate_object_local(Vector3.UP, event.relative.x * mouse_sensitivity)
			
		if event.relative.y != 0:
			$InnerGimbal.rotate_object_local(Vector3.RIGHT, event.relative.y * mouse_sensitivity)

func _physics_process(_delta):
	if doubleclik:
		$InnerGimbal/Camera/RayCast.translation= Vector3(position3D.x, position3D.y,$InnerGimbal/Camera/RayCast.translation.z)
		
		if $InnerGimbal/Camera/RayCast.is_colliding():
#			$InnerGimbal/Camera/RayCast/coin.show()
			
			print ($InnerGimbal/Camera/RayCast.get_collision_point())
		else:
#			$InnerGimbal/Camera/RayCast/coin.hide()
			pass

func _process(_delta):
	
		$InnerGimbal/Camera.size = zoom






