extends Control

func _ready():
	var t = get_tree().create_timer(3)
	t.connect("timeout", self, "main_menu")

func main_menu():
	get_tree().change_scene("res://scenes/mainMenu.tscn")
