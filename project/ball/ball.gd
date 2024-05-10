class_name Ball
extends RigidBody2D

signal collision_detected(body)

const PINK = preload("res://ball/pink_ball.png")
const RED = preload("res://ball/red_ball.png") 
const ORANGE = preload("res://ball/orange_ball.png") 
const YELLOW = preload("res://ball/yellow_ball.png")
const GREEN = preload("res://ball/green_ball.png")
const LIGHT_BLUE = preload("res://ball/light_blue_ball.png")

var removed = false

enum colors {
	PINK,
	RED,
	ORANGE,
	YELLOW,
	GREEN,
	LIGHT_BLUE
}

var _collided_balls := []

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
		_collided_balls.append(body)
		emit_signal("collision_detected")


func _on_collision_detector_body_exited(body) -> void:
	if body is Ball:
		_collided_balls.erase(body)
		emit_signal("collision_detected")


func _return_color() -> int:
	return _ball_color


func _get_collisions():
	for i in range(_collided_balls.size()):
		if _collided_balls[i] != self and _collided_balls[i]._return_color() == _return_color():
			print("Collided ball:" + str(_collided_balls[i]))
			return _collided_balls[i]
	print("null")
	return null
