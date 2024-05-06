class_name Ball
extends RigidBody2D

signal matched(color, pos)

const PINK = preload("res://ball/pink_ball.png")
const RED = preload("res://ball/red_ball.png") 
const ORANGE = preload("res://ball/orange_ball.png") 
const YELLOW = preload("res://ball/yellow_ball.png")


enum colors {
	PINK,
	RED,
	ORANGE,
	YELLOW,
}

var _colliding_array = []

var _ball_color: int: 
	set(state):
		if state == colors.PINK:
			_set_sprite_texture(PINK)
			_set_collision_radius(24)
		if state == colors.RED:
			_set_sprite_texture(RED)
			_set_collision_radius(48)
		if state == colors.ORANGE:
			_set_sprite_texture(ORANGE)
			_set_collision_radius(72)
		if state == colors.YELLOW:
			_set_sprite_texture(YELLOW)
			_set_collision_radius(96)
		_ball_color = state


func set_color(color):
	if color == 0:
		_ball_color = colors.PINK
	if color == 1:
		_ball_color = colors.RED
	if color == 2:
		_ball_color = colors.ORANGE
	if color == 3:
		_ball_color = colors.YELLOW


func _set_sprite_texture(color):
	$Sprite.texture = color


func _set_collision_radius(radius) -> void:
	$Collision.shape.radius = radius
	$CollisionDetector.set_size(radius + 5)


func _on_collision_detector_body_entered(body) -> void:
	if body is Ball:
		_colliding_array.append(body)
		search()

func _on_collision_detector_body_exited(body) -> void:
	if body is Ball:
		_colliding_array.erase(body)


func return_color() -> int:
	return _ball_color


func search() -> void:
	for i in _colliding_array.size():
		var original_ball = _colliding_array[0]
		if _colliding_array[i] != original_ball and _colliding_array[i].return_color() == original_ball.return_color():
			var _match_array = []
			_match_array.append(original_ball)
			_match_array.append(_colliding_array[i])
			var send = Tagger.assign_tags(_match_array)
			print(send)
			if send == true:
				if original_ball.return_color() + 1 > BallSelector.get_all_balls().size() - 1:
					original_ball.queue_free()
					_colliding_array[i].queue_free()
				else:
					var t_color = original_ball.return_color() + 1
					var t_pos = original_ball.global_position
					matched.emit(t_color, t_pos)
					original_ball.queue_free()
					_colliding_array[i].queue_free()
			else:
				pass
