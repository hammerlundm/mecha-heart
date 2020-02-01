extends Area

onready var player = get_node("/root/Spatial/player")

func _ready():
	connect("body_entered", self, "trigger_player_safe")
	connect("body_exited", self, "trigger_player_targetable")

func trigger_player_safe(body):
	player.set("targetable", false)
	
func trigger_player_targetable(body):
	player.set("targetable", true)
