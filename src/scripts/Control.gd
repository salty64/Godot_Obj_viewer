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
	
#	$Toolbar/Panel/cotation/Horizontal.disabled=!button_pressed
	$Toolbar/Panel/cotation/Vertical.disabled=!button_pressed
	$Toolbar/Panel/cotation/Libre.disabled=!button_pressed
	$Toolbar/Panel/cotation/Angle.disabled=!button_pressed
	
	$Regle.visible = button_pressed
	$Toolbar/Panel/cotation/Horizontal.pressed = button_pressed


func _on_Transparence_toggled(button_pressed):
	var vp = get_viewport()
	vp.debug_draw = (vp.debug_draw + 1 ) % 4
#	var mat = $"../StaticBody/Object".get_active_material(0)
#	var color = Color(mat.albedo_color)
#
#	if button_pressed:
#		mat.flags_transparent = true
#		mat.albedo_color.a= 0.5
#	else:
#		mat.flags_transparent = false
#		mat.albedo_color.a = 1
#	$"../StaticBody/Object".set_surface_material(0, mat)
	
