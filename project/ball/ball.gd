class_name Ball
extends RigidBody2D


signal color_changed(collision_radius)


enum colors {
	PINK,
	RED,
}

var collision_radius

var _ball_color: int: 
	set(state):
		if state == colors.PINK:
			$RedBall.hide()
			$Collision.shape.radius = 24
		else:
			$RedBall.show()
			$Collision.shape.radius = 48


func _ready():
	var number = randi_range(1,2)
	if number == 1:
		_ball_color = colors.PINK
	if number == 2:
		_ball_color = colors.RED
