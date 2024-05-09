extends Node2D
class_name World

var _ball : Ball

func _ready():
	Sfx.play_music()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("throw"):
		_throw()


func _throw() -> void:
	var queue = BallSelector.get_queue()
	var ball_thrown = queue[0]
	BallSelector.remove_and_create_ball()
	
	_create_thrown_ball(ball_thrown)
	_get_ball_children()


func _get_ball_children():
	var _ball_children = []
	for child in get_children():
		if child is Ball:
			_ball_children.append(child)


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
