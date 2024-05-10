extends Control


func _ready() -> void:
	if !Sfx._return_playing():
		Sfx.play_music()


func _on_button_pressed():
	get_tree().change_scene_to_file("res://world/world.tscn")
