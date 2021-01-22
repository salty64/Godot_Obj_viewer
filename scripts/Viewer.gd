extends Spatial



func _ready():
	pass



func _on_MenuButton_obj_selected(obj_name):
	
	var path = "res://objects/"+obj_name
	
	$StaticBody/Object.mesh = load(path)
	$StaticBody/CollisionShape.shape = $StaticBody/Object.mesh.create_trimesh_shape() 


	var aabb 
	aabb=$StaticBody/Object.get_aabb( )

	var obj_center = aabb.size / 2

	$StaticBody.translation = - ( aabb.position + obj_center)
		

#	var mdt = MeshDataTool.new() 
#	var nd = get_node("StaticBody/Object")
#	var m = nd.get_mesh()
#	#get surface 0 into mesh data tool
#	mdt.create_from_surface(m, 0)
#	for vtx in range(mdt.get_vertex_count()):
#		var vert=mdt.get_vertex(vtx)
#		print("global vertex: "+str(nd.global_transform.xform(vert)))



