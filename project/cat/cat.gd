extends CharacterBody2D

const PINK = preload("res://ball/pink_ball.png")
const RED = preload("res://ball/red_ball.png") 
const ORANGE = preload("res://ball/orange_ball.png")

var ball_queue

func _ready():
	ball_queue = BallSelector.get_queue()


func _physics_process(_delta):
	global_position.x = clamp(get_global_mouse_position().x, 426 + $Collision.shape.radius, 1494 - $Collision.shape.radius)


func _process(_delta):
	if ball_queue[0] == "pink":
		$HoldItem.texture = PINK
	if ball_queue[0] == "red":
		$HoldItem.texture = RED
	if ball_queue[0] == "orange":
		$HoldItem.texture = ORANGE
