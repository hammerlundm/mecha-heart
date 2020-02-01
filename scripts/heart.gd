extends Spatial

export(String) var part_name

var selected

func place(obj):
	if obj.part_name == part_name:
		print(":)")
		obj.queue_free()
		return true
	else:
		print(":(")
		return false
