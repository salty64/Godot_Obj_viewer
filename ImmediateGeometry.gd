extends ImmediateGeometry

func _process(_delta):

	# Begin draw.
	begin(Mesh.PRIMITIVE_LINES)
	set_normal(Vector3(1, 0,0 ))
	set_uv(Vector2(0, 0))
	add_vertex(Vector3(-0.25, 0, 0))
	set_normal(Vector3(1, 0, 0))
	set_uv(Vector2(0, 0))
	add_vertex(Vector3(1, 2, 0))
	set_color(Color( 0, 1, 1, 1 )) 
	# End drawing.
	end()
