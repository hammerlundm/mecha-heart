extends Control

var main = preload("res://scenes/main.tscn")

func _ready():
	$play_button.connect("pressed", self, "start_game")
	$quit_button.connect("pressed", self, "quit_game")
	$credits_panel.popup_exclusive = true
	
func _on_credits_button_pressed():
	$credits_panel.popup_centered_ratio(0.75)
	
func start_game():
	get_tree().change_scene_to(main)
	
func quit_game():
	get_tree().quit()


func _on_audio_start_finished():
	$audio_loop.play()
