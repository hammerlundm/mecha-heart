extends Control

var main = preload("res://scenes/main.tscn")
var scale_factor = 1.02

func _ready():
	$play_button.connect("pressed", self, "start_game")
	$quit_button.connect("pressed", self, "quit_game")
	$credits_panel.popup_exclusive = true
	$credits_button.rect_pivot_offset = $credits_button.rect_size/2
	$play_button.rect_pivot_offset = $play_button.rect_size/2
	$quit_button.rect_pivot_offset = $quit_button.rect_size/2
	
	
func _on_credits_button_pressed():
	$credits_panel.popup_centered_ratio(0.75)
	
func start_game():
	get_tree().change_scene_to(main)
	
func quit_game():
	get_tree().quit()


func _on_audio_start_finished():
	$audio_loop.play()

func _on_credits_button_mouse_entered():
	$credits_button.rect_scale *= scale_factor
	
func _on_credits_button_mouse_exited():
	$credits_button.rect_scale /= scale_factor


func _on_play_button_mouse_entered():
	$play_button.rect_scale *= scale_factor


func _on_play_button_mouse_exited():
	$play_button.rect_scale /= scale_factor


func _on_quit_button_mouse_entered():
	$quit_button.rect_scale *= scale_factor


func _on_quit_button_mouse_exited():
	$quit_button.rect_scale /= scale_factor
