extends Control



func _ready():
	$Regle.visible = false
	pass 


func _on_CameraGimbal_zoom_value(value):
	$Toolbar/Panel/VSlider.value=value



func _on_Ruler_toggled(button_pressed):
	
	$Regle.visible = button_pressed
