extends Node2D
class_name World

enum is_dropped {
	TRUE,
	FALSE,
}

const PINK = preload("res://ball/pink_ball.png")
const RED = preload("res://ball/red_ball.png") 
const ORANGE = preload("res://ball/orange_ball.png") 

var collision : CollisionShape2D
var _ball : Ball

var _ball_state: int: 
	set(state):
		if state == is_dropped.TRUE:
			_ball.gravity_scale = 1
		else:
			_ball.gravity_scale = 0
		_ball_state = state


func _ready() -> void:
	_make_new_ball("random")


func _process(_delta) -> void:
	if _ball_state == is_dropped.FALSE:
		_ball.global_position.x = _follow_mouse()


func _make_new_ball(color) -> void:
	_ball = preload("res://ball/ball.tscn").instantiate()
	add_child(_ball)
	_ball_state = is_dropped.FALSE
	collision = _ball.get_node("Collision")
	
	_ball.set_color(color)

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
	_make_new_ball("random")
