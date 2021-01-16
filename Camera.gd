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

func _ready():
	pass # Replace with function body.


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
	
	if (event is InputEventMouseButton && event.button_index == BUTTON_LEFT && event.pressed):
		$InnerGimbal/Camera/RayCast.translation=Vector3(0,0,0)
		
		
	if (mouse_rotate_button and event is InputEventMouseMotion):
		if event.relative.x != 0:
			self.rotate_object_local(Vector3.UP, event.relative.x * mouse_sensitivity)
			
		if event.relative.y != 0:
			$InnerGimbal.rotate_object_local(Vector3.RIGHT, event.relative.y * mouse_sensitivity)



func _process(_delta):
	
		$InnerGimbal/Camera.size = zoom






