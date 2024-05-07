extends Node2D
class_name World

var _ball : Ball


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("throw"):
		_throw()


func _throw() -> void:
	var queue = BallSelector.get_queue()
	var ball_thrown = queue[0]
	BallSelector.remove_and_create_ball()
	
	_create_thrown_ball(ball_thrown)


<<<<<<< Updated upstream
func _create_thrown_ball(color: int) -> void:
	_ball = preload("res://ball/ball.tscn").instantiate()
	call_deferred("add_child", _ball)
	_ball.matched.connect(_create_combo_ball)
	_ball.global_position = $Cat/HoldItem.global_position
	_ball.set_color(color)


func _create_combo_ball(color: int, pos: Vector2) -> void:
	_ball = preload("res://ball/ball.tscn").instantiate()
	call_deferred("add_child", _ball)
	_ball.matched.connect(_create_combo_ball)
	_ball.set_color(color)
	_ball.global_position = pos
	$Particles.global_position = pos
	$Particles.emitting = true
=======
func _process(_delta) -> void:
	if _ball_state == is_dropped.FALSE:
		_ball.global_position.x = _follow_mouse()


func _make_new_ball() -> void:
	_ball = preload("res://ball/ball.tscn").instantiate()
	add_child(_ball)
	
	_ball_state = is_dropped.FALSE
	collision = _ball.get_node("Collision")
	_ball.global_position.x = _follow_mouse()
	_ball.global_position.y = 100


func _follow_mouse() -> float:
	var _ball_location = clamp(get_global_mouse_position().x, 426 + collision.shape.radius, 1494 - collision.shape.radius)
	return _ball_location


func _input(event) -> void:
	if event.is_action("drop") and _ball_state == is_dropped.FALSE:
		_drop()


func _drop() -> void:
	_ball_state = is_dropped.TRUE
	$Timer.start()


func _on_timer_timeout() -> void:
	_make_new_ball()
>>>>>>> Stashed changes
