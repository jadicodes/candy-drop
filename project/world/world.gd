extends Node2D
class_name World

var _ball : Ball


func _ready():
	Sfx.play_music()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("throw"):
		_throw()


func _check_collision():
	var _world_children = _get_ball_children()
	print("World: " + str(_world_children))
	for ball in _world_children:
		var ball2 = ball._get_collisions()
		if ball2 != null:
			if ball != ball2 and ball._return_color() == ball2._return_color() and ball.removed == false and ball2.removed == false:
				var color = ball._return_color() + 1
				var pos = ball.position
				ball.removed = true
				ball2.removed = true
				_delete_balls(ball, ball2)
				_create_combo_ball(color, pos)
				_world_children = _get_ball_children()
				print("World after:" + str(_world_children))


func _delete_balls(ball1, ball2):
	remove_child.call_deferred(ball1)
	remove_child.call_deferred(ball2)


func _throw() -> void:
	var queue = BallSelector.get_queue()
	var ball_thrown = queue[0]
	BallSelector.remove_and_create_ball()
	
	_create_thrown_ball(ball_thrown)
	_get_ball_children()


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
	print(color)
	_ball = preload("res://ball/ball.tscn").instantiate()
	call_deferred("add_child", _ball)
	_ball.collision_detected.connect(_check_collision)
	_ball.set_color(color)
	_ball.global_position = pos
	$Particles.global_position = pos
	$Particles.emitting = true
