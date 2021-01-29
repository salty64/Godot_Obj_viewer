extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var animationPlayer = $cotation/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	#animationPlayer.play("Close")
	pass

func _on_CameraGimbal_zoom_value(value):
	$zoom/VSlider.value = value

func _on_Ruler_toggled(button_pressed):
	if button_pressed :
		animationPlayer.play("Deploy")
	else :
		animationPlayer.play_backwards("Deploy")

	$cotation/Horizontal.disabled = !button_pressed
	$cotation/Vertical.disabled = !button_pressed
	$cotation/Libre.disabled = !button_pressed
	$cotation/Angle.disabled = !button_pressed
	
	$"../Regle".visible = button_pressed
	
