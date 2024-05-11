extends Node2D
class_name World

var _ball : Ball
var _can_throw := true
var _bodies_in_lose_area := []
var _entered := false


func _ready():
	$LoseScreen.hide()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("throw"):
		_throw()


func _check_collision() -> void:
	var _world_children = _get_ball_children()
	for ball in _world_children:
		var ball2 = ball._get_collisions()
		if ball2 != null:
			if ball != ball2 and ball._return_color() == ball2._return_color() and ball.removed == false and ball2.removed == false:
				var color = ball._return_color() + 1
				var pos = ball.position
				if color <= BallSelector.get_all_balls().size() - 1:
					_delete_balls(ball, ball2)
					_create_combo_ball(color, pos)
					_world_children = _get_ball_children()
				else:
					_delete_balls(ball, ball2)
					_world_children = _get_ball_children()
				$Particles.global_position = pos
				$Particles.emitting = true


func _delete_balls(ball1, ball2) -> void:
	ball1.removed = true
	ball2.removed = true
	remove_child.call_deferred(ball1)
	remove_child.call_deferred(ball2)


func _throw() -> void:
	if _can_throw:
		var queue = BallSelector.get_queue()
		var ball_thrown = queue[0]
		BallSelector.remove_and_create_ball()
		$Cat._empty_hand()
		
		_create_thrown_ball(ball_thrown)
		_get_ball_children()
		
		$Timer.start()
		_can_throw = false


func _get_ball_children() -> Array:
	var _ball_children = []
	for child in get_children():
		if child is Ball:
			_ball_children.append(child)
	return _ball_children


func _create_thrown_ball(color: int) -> void:
	_ball = preload("res://ball/ball.tscn").instantiate()
	call_deferred("add_child", _ball)
	_ball.collision_detected.connect(_check_collision)
	_ball.global_position = $Cat/HoldItem.global_position
	_ball.set_color(color)


func _create_combo_ball(color: int, pos: Vector2) -> void:
	_ball = preload("res://ball/ball.tscn").instantiate()
	call_deferred("add_child", _ball)
	_ball.collision_detected.connect(_check_collision)
	_ball.set_color(color)
	_ball.global_position = pos
	
	_calculate_score()


func _on_timer_timeout() -> void:
	$Cat._next_ball()
	$IncomingBallDisplay._update_incoming()
	_can_throw = true


func _on_danger_line_body_entered(body) -> void:
	if body is Ball:
		_bodies_in_lose_area.append(body)
		if !_entered:
			$LoseTimer.start()
			$AnimationPlayer.play("danger")
			_entered = true


func _on_danger_line_body_exited(body) -> void:
	if body is Ball:
		_bodies_in_lose_area.erase(body)
		if _bodies_in_lose_area == []:
			_entered = false
			$LoseTimer.stop()
			$AnimationPlayer.stop()


func _on_lose_timer_timeout() -> void:
	$LoseScreen.show()
	$LoseScreen/ScoreLabel.text = str($ScoreDisplay._return_score())


func _calculate_score():
	var mult = _ball._return_multiplier()
	$ScoreDisplay._add_to_score(11 * mult)


func _on_home_button_pressed():
	get_tree().change_scene_to_file("res://menus/home_menu.tscn")


func _on_play_again_button_pressed():
	get_tree().reload_current_scene()


func _on_mute_button_mouse_entered():
	_can_throw = false


func _on_mute_button_mouse_exited():
	_can_throw = true
