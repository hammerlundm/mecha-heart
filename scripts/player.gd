extends KinematicBody

export(float) var MOVE_SPEED = 1000
export(float) var TURN_SPEED = 0.001
export(float) var FRICTION = 0.01

var v = Vector3(0, 0, 0)
var angle = Vector2(0, 0)

func _ready():
	pass

func _process(delta):
	"""if Input.is_action_pressed("turn_left"):
		rotate_y(TURN_SPEED * delta)
		facing = facing.rotated(Vector3(0, 1, 0), TURN_SPEED * delta)
	if Input.is_action_pressed("turn_right"):
		rotate_y(-TURN_SPEED * delta)
		facing = facing.rotated(Vector3(0, 1, 0), -TURN_SPEED * delta)"""
	transform.basis = Basis()
	var size = get_viewport().size
	var mouse = get_viewport().get_mouse_position()
	var asdf = mouse - (size * 0.5)
	angle += asdf * TURN_SPEED * delta
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
	v *= FRICTION / delta
	move_and_slide(v)
