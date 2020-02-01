extends KinematicBody

export(float) var MOVE_SPEED = 20
export(float) var DEAGRO_DISTANCE = 10

onready var player = get_node("/root/Spatial/player")
onready var path_follow = get_parent()

var follow_player = false
var initial_position = null

func _ready():
	$vision.connect("body_entered", self, "trigger_follow_player")
	$touch.connect("body_entered", self, "trigger_hit_player")

func _physics_process(delta):
	var player_origin = player.get_global_transform().origin
	var enemy_origin = get_global_transform().origin
	
	# Check to see if the enemy is far enough away from the player to de-agro
	if (enemy_origin.distance_to(player_origin) > DEAGRO_DISTANCE or !player.get("targetable")):
		follow_player = false
		
	if (follow_player):
		if (initial_position == null):
			initial_position = enemy_origin
			
		var offset = player_origin - enemy_origin
		move_and_collide(offset.normalized() * MOVE_SPEED * delta)
		look_at(player_origin, Vector3(0,1,0))
		rotate(Vector3(0, 1, 0), PI)
	else:
		if (initial_position != null):
			var offset = initial_position - enemy_origin
			move_and_slide(offset.normalized() * MOVE_SPEED)
			look_at(initial_position, Vector3(0,1,0))
			rotate(Vector3(0, 1, 0), PI)
			
			if (offset.length() < 0.5):
				initial_position = null
		else:
			path_follow.set_offset(path_follow.get_offset() + MOVE_SPEED * delta)

func trigger_follow_player(body):
	if (body.name == 'player'):
		follow_player = true
		
func trigger_hit_player(body):
	if (body.name == 'player'):
		player.hit()
