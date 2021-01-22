extends Control


func _ready():
	pass 


func _on_CameraGimbal_zoom_value(value):
	$Toolbar/Panel/VSlider.value=value

