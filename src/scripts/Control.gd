extends Control

func _ready():
	$Regle.visible = false
	$Overlay.visible=true
	pass





func _on_ViewportContainer_resized():
	printt('Size sur VP_Container:',$".".rect_size)
	print("Viewport Resolution is: ", get_viewport_rect().size)
	pass

func _on_Viewport_size_changed():
#	printt('Size sur VP_Container:',$".".rect_size)
#	printt('Size sur VP:',$"../Viewport".rect_size)
#	print("Viewport Resolution is: ", get_viewport_rect().size)
	pass
