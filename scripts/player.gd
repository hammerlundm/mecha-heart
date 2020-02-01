extends KinematicBody

export(float) var MOVE_SPEED = 1000
export(float) var TURN_SPEED = 0.001
export(float) var FRICTION = 0.01
export(float) var INTERACT_SIZE = 500

var v = Vector3(0, 0, 0)
var angle = Vector2(0, 0)
var old_pos = Vector2(0, 0)

var object = null

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$reach.connect("area_entered", self, "select")
	$reach.connect("area_exited", self, "deselect")

func _process(delta):
	transform.basis = Basis()
	rotate(transform.basis.y, -angle.x)
	rotate(transform.basis.x, -angle.y)
	if Input.is_action_pressed("move_forward"):
		v -= transform.basis.z * delta * MOVE_SPEED
	if Input.is_action_pressed("move_back"):
		v += transform.basis.z * delta * MOVE_SPEED
	if Input.is_action_pressed("move_left"):
		v -= transform.basis.x * delta * MOVE_SPEED
	if Input.is_action_pressed("move_right"):
		v += transform.basis.x * delta * MOVE_SPEED
	v.y -= 9.8
	if Input.is_action_pressed("interact"):
		if object == null:
			var objects = get_tree().get_nodes_in_group("object")
			for obj in objects:
				if obj.selected:
					print("!!!")
					object = obj
					obj.get_parent().remove_child(obj)
					add_child(obj)
		else:
			var heart = get_tree().get_nodes_in_group("heart")
			for part in heart:
				if part.selected:
					if part.place(object):
						object = null
	v *= FRICTION / (delta + 0.01)
	move_and_slide(v)

func _input(event):
	if event is InputEventMouseMotion:
		angle += event.relative * TURN_SPEED

func select(area):
	var groups = area.get_parent().get_groups()
	if groups.has("object") or groups.has("heart"):
		area.get_parent().selected = true

func deselect(area):
	var groups = area.get_parent().get_groups()
	if groups.has("object") or groups.has("heart"):
		area.get_parent().selected = false
