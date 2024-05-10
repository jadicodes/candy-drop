class_name Ball
extends RigidBody2D

signal collision_detected(body)

const PINK = preload("res://ball/pink_ball.png")
const RED = preload("res://ball/red_ball.png") 
const ORANGE = preload("res://ball/orange_ball.png") 
const YELLOW = preload("res://ball/yellow_ball.png")
const GREEN = preload("res://ball/green_ball.png")
const LIGHT_BLUE = preload("res://ball/light_blue_ball.png")
const DARK_BLUE = preload("res://ball/dark_blue_ball.png")
const PURPLE = preload("res://ball/purple_ball.png")

var removed = false

enum colors {
	PINK,
	RED,
	ORANGE,
	YELLOW,
	GREEN,
	LIGHT_BLUE,
	DARK_BLUE,
	PURPLE,
}

var _collided_balls := []
var _multiplier := 1

var _ball_color: int: 
	set(state):
		if state == colors.PINK:
			_set_ball_properties(PINK, 24, 11, 1)
		if state == colors.RED:
			_set_ball_properties(RED, 48, 10, 2)
		if state == colors.ORANGE:
			_set_ball_properties(ORANGE, 72, 9, 3)
		if state == colors.YELLOW:
			_set_ball_properties(YELLOW, 96, 8, 4)
		if state == colors.GREEN:
			_set_ball_properties(GREEN, 120, 7, 5)
		if state == colors.LIGHT_BLUE:
			_set_ball_properties(LIGHT_BLUE, 144, 6, 6)
		if state == colors.DARK_BLUE:
			_set_ball_properties(DARK_BLUE, 168, 5, 7)
		if state == colors.PURPLE:
			_set_ball_properties(PURPLE, 192, 4, 8)
		_ball_color = state


func _set_ball_properties(tex, rad, kg, mult) -> void:
	_set_sprite_texture(tex)
	_set_collision_radius(rad)
	_set_mass(kg)
	_set_multiplier(mult)


func set_color(color: int) -> void:
	_ball_color = color


func _set_sprite_texture(color: CompressedTexture2D) -> void:
	$Sprite.texture = color


func _set_collision_radius(radius : int) -> void:
	$Collision.shape.radius = radius
	$CollisionDetector.set_size(radius + 8)


func _set_mass(kg : int) -> void:
	mass = kg


func _set_multiplier(mult: int) -> void:
	_multiplier = mult


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


func _return_multiplier() -> int:
	return _multiplier


func _get_collisions():
	for i in range(_collided_balls.size()):
		if _collided_balls[i] != self and _collided_balls[i]._return_color() == _return_color():
			return _collided_balls[i]
	return null
