extends Node2D
class_name World

var _ball : Ball


func _input(event) -> void:
	if event.is_action_pressed("throw"):
		_throw()


func _throw():
	var queue = BallSelector.get_queue()
	var ball_thrown = queue[0]
	BallSelector.remove_and_create_ball()
	
	_create_thrown_ball(ball_thrown)


func _create_thrown_ball(color):
	_ball = preload("res://ball/ball.tscn").instantiate()
	call_deferred("add_child", _ball)
	
	_ball.global_position = $Cat.global_position
	_ball.set_color(color)
