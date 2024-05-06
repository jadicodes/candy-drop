class_name Ball
extends RigidBody2D

#signal matched(color)

const PINK = preload("res://ball/pink_ball.png")
const RED = preload("res://ball/red_ball.png") 
const ORANGE = preload("res://ball/orange_ball.png") 

enum colors {
	PINK,
	RED,
	ORANGE,
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
			_set_collision_radius(96)
		_ball_color = state
#
#
func set_color(color):
	if color == "pink":
		_ball_color = colors.PINK
	if color == "red":
		_ball_color = colors.RED
	if color == "orange":
		_ball_color = colors.ORANGE


func _set_sprite_texture(color):
	$Sprite.texture = color


func _set_collision_radius(radius) -> void:
	$Collision.shape.radius = radius
	$CollisionDetector.set_size(radius + 5)


func _on_collision_detector_body_entered(body) -> void:
	if body is Ball:
		_colliding_array.append(body)
		print(_colliding_array)


func _on_collision_detector_body_exited(body) -> void:
	if body is Ball:
		_colliding_array.erase(body)
		print(_colliding_array)


#func return_color() -> int:
	#return _ball_color

#func search() -> void:
	#for i in _ball_array.size():
		#var original_ball = _ball_array[0]
		#if _ball_array[i] != original_ball and _ball_array[i].return_color() == original_ball.return_color():
			#var _match_array = []
			#_match_array.append(original_ball)
			#_match_array.append(_ball_array[i])
			#var send = Tagger.assign_tags(_match_array)
			#if send == true:
				#var t_color = original_ball.return_color()
				#matched.emit(t_color)
				#original_ball.queue_free()
				#_ball_array[i].queue_free()
			#else:
				#pass
