extends Spatial

const ObjParser = preload("res://addons/obj_parser/obj_parser.gd")

func resetShape():
	$StaticBody/CollisionShape.shape = $StaticBody/Object.mesh.create_trimesh_shape() 

func _ready():
	if $StaticBody/CollisionShape.shape :
		resetShape()
	
	pass


func _init():
	#VisualServer.set_debug_generate_wireframes(true)
	pass

func _on_MenuButton_obj_selected(obj_path):
	$StaticBody/Object.mesh = ObjParser.parse_obj(obj_path)
	
	resetShape()

	var aabb = $StaticBody/Object.get_aabb( )

	var obj_center = aabb.size / 2
	
	$StaticBody.translation = - ( aabb.position + obj_center)
	
	var piece = $StaticBody/Object.mesh
	var mdt = MeshDataTool.new()
	mdt.create_from_surface($StaticBody/Object.mesh, 0)
	var nb_faces = mdt.get_face_count()
	var nb_edges = mdt.get_edge_count()
	var nb_vertex = mdt.get_vertex_count()
	

	
	var ig = $StaticBody/IG_vertex
	var sm = SpatialMaterial.new()
	sm.flags_unshaded = true
	sm.vertex_color_use_as_albedo = true

	ig.clear()
	ig.begin(Mesh.PRIMITIVE_LINES)
	ig.material_override = sm


	var verticies = piece.get_faces()
	var triangle = [0, 0, 0]

	var i = 0




	while i < verticies.size()/3:


#	
		var a = verticies[i*3].distance_to(verticies[i*3+1])
		var b = verticies[i*3+1].distance_to(verticies[i*3+2])
		var c = verticies[i*3+2].distance_to(verticies[i*3])
		ig.set_color(Color.black)



		triangle[0]=a
		triangle[1]=b
		triangle[2]=c
		var pytha = triangle.duplicate()
		pytha.sort()


		if is_equal_approx(pow(pytha[2],2),(pow(pytha[1],2) + pow(pytha[0],2))) :
			var n = triangle.find(pytha[2])

			if n == 0 :
				# affiche B
				ig.add_vertex(verticies[i*3+1])
				ig.add_vertex(verticies[i*3+2])
				# affiche C
				ig.add_vertex(verticies[i*3+2])
				ig.add_vertex(verticies[i*3]) 
			if n == 1 : 
				# affiche A
				ig.add_vertex(verticies[i*3])
				ig.add_vertex(verticies[i*3+1])
				# affiche C
				ig.add_vertex(verticies[i*3+2])
				ig.add_vertex(verticies[i*3]) 
			if n == 2:
				# affiche A
				ig.add_vertex(verticies[i*3])
				ig.add_vertex(verticies[i*3+1])
				# affiche B
				ig.add_vertex(verticies[i*3+1])
				ig.add_vertex(verticies[i*3+2])
		else :
			# affiche A
			ig.add_vertex(verticies[i*3])
			ig.add_vertex(verticies[i*3+1])
			# affiche B
			ig.add_vertex(verticies[i*3+1])
			ig.add_vertex(verticies[i*3+2])
			# affiche C
			ig.add_vertex(verticies[i*3+2])
			ig.add_vertex(verticies[i*3]) 

		i += 1
	ig.end()
	var sf = 2.0000011
	ig.set_scale(Vector3(sf, sf, sf))

func _on_Transparence_toggled(button_pressed):
	var vp = get_parent()
	var ig = $StaticBody/IG_vertex
	
	if button_pressed :
		vp.debug_draw = 2
		ig.show()
		
	else :
		vp.debug_draw = 0
		ig.hide()

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
	pass # Replace with function body.
