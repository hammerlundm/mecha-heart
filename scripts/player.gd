extends KinematicBody

export(float) var MOVE_SPEED = 1000
export(float) var TURN_SPEED = 0.001
export(float) var FRICTION = 0.01
export(float) var GRAVITY = 1000
export(float) var HEALTH = 1

var tracks = [preload("res://sounds/Heartbeat1.ogg"), preload("res://sounds/Heartbeat2.ogg"), preload("res://sounds/Heartbeat3.ogg"), preload("res://sounds/Heartbeat4.ogg"), preload("res://sounds/Heartbeat5.ogg"), preload("res://sounds/Heartbeat6.ogg")]

var v = Vector3(0, 0, 0)
var angle = Vector2(0, 0)
var old_pos = Vector2(0, 0)

var object = null
var targetable = true
var current_health = HEALTH
var points = 0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$reach.connect("area_entered", self, "select")
	$reach.connect("area_exited", self, "deselect")

func _process(delta):
	transform.basis = Basis()
	rotate(transform.basis.y, -angle.x)
	rotate(transform.basis.x, -angle.y)
	var v2 = Vector2(0, 0)
	v2.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	v2.y = Input.get_action_strength("move_back") - Input.get_action_strength("move_forward")
	v2 = v2.normalized()
	if v2.length_squared() > 0.2 and not $footsteps.playing:
		$footsteps.play()
	elif v2.length_squared() < 0.2:
		$footsteps.stop()
		pass
	var asdf = v2.x * transform.basis.x + v2.y * transform.basis.z
	var flat = asdf - (asdf.dot(Vector3(0, 1, 0)) * Vector3(0, 1, 0))
	v += flat.normalized() * delta * MOVE_SPEED
	if is_on_wall():
		if Input.is_action_pressed("jump"):
			v.y += 1000 * delta
	else:
		v.y -= GRAVITY * delta
		pass
	if Input.is_action_pressed("interact"):
		if object == null:
			var objects = get_tree().get_nodes_in_group("object")
			for obj in objects:
				if obj.selected:
					object = obj
					obj.get_parent().remove_child(obj)
					add_child(obj)
		else:
			var heart = get_tree().get_nodes_in_group("heart")
			for part in heart:
				if part.selected:
					if part.place(object):
						points += 1
						$"../FinalChamber/Heart/objectClunk".play()
						$"../FinalChamber/Heart/heartbeat".stream = tracks[points]
						$"../FinalChamber/Heart/heartbeat".play()
						if points >= 5:
							get_tree().change_scene("res://scenes/win.tscn")
						object = null
						break
		if Input.is_action_pressed("ui_cancel"):
			Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
			get_tree().change_scene("res://scenes/mainMenu.tscn")
	v *= FRICTION / (delta + 0.01)
	move_and_slide(v)

func _input(event):
	if event is InputEventMouseMotion:
		angle += event.relative * TURN_SPEED
		if angle.y > PI/2:
			angle.y = PI/2
		if angle.y < -PI/2:
			angle.y = -PI/2

func select(area):
	var groups = area.get_parent().get_groups()
	if groups.has("object") or groups.has("heart"):
		area.get_parent().selected = true

func deselect(area):
	var groups = area.get_parent().get_groups()
	if groups.has("object") or groups.has("heart"):
		area.get_parent().selected = false
		
func hit():
	current_health -= 1
	if current_health <= 0:
		get_tree().change_scene("res://scenes/dead.tscn")
