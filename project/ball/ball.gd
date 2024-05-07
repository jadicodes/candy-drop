class_name Ball
extends RigidBody2D

signal matched(color, pos)

const PINK = preload("res://ball/pink_ball.png")
const RED = preload("res://ball/red_ball.png") 
const ORANGE = preload("res://ball/orange_ball.png") 
const YELLOW = preload("res://ball/yellow_ball.png")
const GREEN = preload("res://ball/green_ball.png")
const LIGHT_BLUE = preload("res://ball/light_blue_ball.png")

enum colors {
	PINK,
	RED,
	ORANGE,
	YELLOW,
	GREEN,
	LIGHT_BLUE
}

var _colliding_array := []

var _ball_color: int: 
	set(state):
		if state == colors.PINK:
			_set_ball_properties(PINK, 24, 11)
		if state == colors.RED:
			_set_ball_properties(RED, 48, 10)
		if state == colors.ORANGE:
			_set_ball_properties(ORANGE, 72, 9)
		if state == colors.YELLOW:
			_set_ball_properties(YELLOW, 96, 8)
		if state == colors.GREEN:
			_set_ball_properties(GREEN, 120, 7)
		if state == colors.LIGHT_BLUE:
			_set_ball_properties(LIGHT_BLUE, 144, 6)
		_ball_color = state


func _set_ball_properties(tex, rad, kg):
	_set_sprite_texture(tex)
	_set_collision_radius(rad)
	_set_mass(kg)


func set_color(color: int) -> void:
	_ball_color = color


func _set_sprite_texture(color: CompressedTexture2D) -> void:
	$Sprite.texture = color


func _set_collision_radius(radius : int) -> void:
	$Collision.shape.radius = radius
	$CollisionDetector.set_size(radius + 8)


func _set_mass(kg : int) -> void:
	mass = kg


func _on_collision_detector_body_entered(body) -> void:
	if body is Ball:
		_colliding_array.append(body)
		search()


func _on_collision_detector_body_exited(body) -> void:
	if body is Ball:
		_colliding_array.erase(body)
		search()


func return_color() -> int:
	return _ball_color


func search() -> void:
	# Iterate through _colliding_array, which tracks all balls that are currently inside the collision detector
	for i in range(_colliding_array.size()):
		print(_colliding_array.size())
		# original_ball is the ball that THIS code is currently being run for, it is always the first item because it is inside its own collision detector first
		var original_ball = _colliding_array[0]
		# colliding_ball is the ball that original_ball is being compared to, i
		var colliding_ball = _colliding_array[i]
		# if colliding_ball is NOT original_ball AND colliding_ball's color matches original_ball's color
		if colliding_ball != original_ball and colliding_ball.return_color() == original_ball.return_color():
			# If the two arrays (the array of this ball and the array of the colliding ball) == 2, then one is duplicated+1 and one is removed
			if Tagger.assign_tags([original_ball, colliding_ball]):
				# next_color is the next color in the sequence, it is what the balls will combine into
				var next_color = original_ball.return_color() + 1
				# if next_color exceeds the array of all colors, delete both balls
				if next_color > BallSelector.get_all_balls().size():
					original_ball.queue_free()
					colliding_ball.queue_free()
					# TODO play particles when balls cancel each other out
				# if next_color is within the array of all colors
				else:
					# emit matched, a signal that sends the color and position of the new ball that needs to be created
					matched.emit(next_color, original_ball.global_position)
					original_ball.queue_free()
					colliding_ball.queue_free()


