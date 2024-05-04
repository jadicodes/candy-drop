class_name Ball
extends RigidBody2D

signal combined(color, position)

const PINK = preload("res://ball/pink_ball.png")
const RED = preload("res://ball/red_ball.png") 
const ORANGE = preload("res://ball/orange_ball.png") 

enum colors {
	PINK,
	RED,
	ORANGE,
}

var _ball_array = []

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


func _ready() -> void:
	var number = randi_range(1,3)
	if number == 1:
		_ball_color = colors.PINK
	if number == 2:
		_ball_color = colors.RED
	if number == 3:
		_ball_color = colors.ORANGE


func _set_sprite_texture(color):
	$Sprite.texture = color


func _set_collision_radius(radius) -> void:
	$Collision.shape.radius = radius
	$CollisionDetector.set_size(radius + 5)


func return_color() -> int:
	return _ball_color


func _on_collision_detector_body_entered(body) -> void:
	if body is Ball:
		_ball_array.append(body)
		search()


func _on_collision_detector_body_exited(body) -> void:
	if body is Ball:
		_ball_array.erase(body)


func search() -> void:
	for i in _ball_array.size():
			if _ball_array[i] != _ball_array[0] and _ball_array[i].return_color() == _ball_array[0].return_color():
				_ball_array[i].queue_free()
				_ball_array[0].queue_free()
