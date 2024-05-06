extends CharacterBody2D

const PINK = preload("res://ball/pink_ball.png")
const RED = preload("res://ball/red_ball.png") 
const ORANGE = preload("res://ball/orange_ball.png")

var ball_queue: Array


func _ready() -> void:
	ball_queue = BallSelector.get_queue()


func _physics_process(_delta) -> void:
	global_position.x = clamp(get_global_mouse_position().x, 426 + $Collision.shape.radius/2, 1494 - $Collision.shape.radius/2)


func _process(_delta) -> void:
	if ball_queue[0] == 0:
		$HoldItem.texture = PINK
	if ball_queue[0] == 1:
		$HoldItem.texture = RED
	if ball_queue[0] == 2:
		$HoldItem.texture = ORANGE
