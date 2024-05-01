extends Node2D


enum is_dropped {
	TRUE,
	FALSE,
}

var _ball : Ball
var _ball_state: int: 
	set(state):
		if state == is_dropped.TRUE:
			_ball.gravity_scale = 1
		else:
			_ball.gravity_scale = 0
		_ball_state = state


func _ready():
	_make_new_ball()


func _process(_delta):
	if _ball_state == is_dropped.FALSE:
		_ball.global_position.x = _get_spawn_location()


func _input(event):
	if event.is_action("drop") and _ball_state == is_dropped.FALSE:
		_drop()


func _make_new_ball():
	_ball = preload("res://ball/ball.tscn").instantiate()
	add_child(_ball)
	_ball.global_position.x = _get_spawn_location()
	_ball_state = is_dropped.FALSE


func _drop():
	_ball_state = is_dropped.TRUE
	$Timer.start()


func _on_timer_timeout():
	_make_new_ball()


func _get_spawn_location():
	var _ball_location = clamp(get_global_mouse_position().x, 425, 1500)
	return _ball_location
