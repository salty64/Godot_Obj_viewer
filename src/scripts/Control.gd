extends Control



func _ready():
	$Regle.visible = false
	$"../AnimationPlayer".play("Close")
	pass 


func _on_CameraGimbal_zoom_value(value):
	$Toolbar/Panel/zoom/VSlider.value=value



func _on_Ruler_toggled(button_pressed):
	
	if button_pressed :
		$"../AnimationPlayer".play("Deploy")
	else :
		$"../AnimationPlayer".play_backwards("Deploy")
	
	$Toolbar/Panel/cotation/Horizontal.disabled=!button_pressed
	$Toolbar/Panel/cotation/Vertical.disabled=!button_pressed
	$Toolbar/Panel/cotation/Libre.disabled=!button_pressed
	$Toolbar/Panel/cotation/Angle.disabled=!button_pressed
	
	$Regle.visible = button_pressed
	$Toolbar/Panel/cotation/Horizontal.pressed = button_pressed
