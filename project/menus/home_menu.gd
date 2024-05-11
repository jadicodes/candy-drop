extends Control


func _ready() -> void:
	Sfx.play_music()
	var _world_children = _get_ball_children()
	for ball in _world_children:
		var color = BallSelector.get_all_balls().pick_random()
		ball.set_color(color)


func _get_ball_children() -> Array:
	var _ball_children = []
	for child in get_children():
		if child is Ball:
			_ball_children.append(child)
	return _ball_children


func _on_button_pressed():
	get_tree().change_scene_to_file("res://world/world.tscn")


func _on_credits_button_pressed():
	pass # Replace with function body.
