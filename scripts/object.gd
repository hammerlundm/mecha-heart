extends Spatial

export(String) var part_name
export(Mesh) var mesh
export(Material) var mat

var selected

func _ready():
	$body/shape.mesh = mesh
	$body/shape.material_override = mat
