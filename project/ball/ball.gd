class_name Ball
extends RigidBody2D

signal color_changed(collision_radius)


enum colors {
	PINK,
	RED,
}

var _ball_array = []

var _ball_color: int: 
	set(state):
		if state == colors.PINK:
			$RedBall.hide()
			_set_collision_radius(24)
		else:
			$RedBall.show()
			_set_collision_radius(48)
		_ball_color = state


func _ready() -> void:
	var number = randi_range(1,2)
	if number == 1:
		_ball_color = colors.PINK
	if number == 2:
		_ball_color = colors.RED


func _set_collision_radius(radius) -> void:
	$Collision.shape.radius = radius
	$CollisionDetector.set_size(radius + 5)

func return_color() -> int:
	return _ball_color


func set_size(radius) -> void:
	$Collision.shape.radius = radius


func _on_collision_detector_body_entered(body) -> void:
	if body is Ball:
		_ball_array.append(body)
		search()


func _on_collision_detector_body_exited(body) -> void:
	if body is Ball:
		_ball_array.erase(body)


func search() -> void:
	for i in range(_ball_array.size() - 1):
		for j in range(i + 1, _ball_array.size()):
			if _ball_array[i].return_color() == _ball_array[j].return_color():
				_ball_array[i].queue_free()
				_ball_array[j].queue_free()
