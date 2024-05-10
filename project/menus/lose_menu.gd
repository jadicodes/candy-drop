extends Node2D


func _on_play_again_button_pressed():
	get_tree().change_scene_to_file("res://world/world.tscn")
