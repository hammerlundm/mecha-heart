extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	var t = get_tree().create_timer(10)
	t.connect("timeout", self, "main_menu")

func main_menu():
	get_tree().change_scene("res://scenes/mainMenu.tscn")
