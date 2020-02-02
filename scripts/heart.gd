extends Spatial

export(String) var part_name
export(PackedScene) var part_scene

var selected

func place(obj):
	if obj.part_name == part_name:
		obj.queue_free()
		var inst = part_scene.instance()
		$"..".add_child(inst)
		return true
	else:
		return false
