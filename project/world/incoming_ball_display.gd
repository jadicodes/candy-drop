extends Control

const PINK_BALL = preload("res://ball/pink_ball.png")
const RED_BALL = preload("res://ball/red_ball.png") 
const ORANGE_BALL = preload("res://ball/orange_ball.png") 
const YELLOW_BALL = preload("res://ball/yellow_ball.png")

var ball_queue


func _ready():
	ball_queue = BallSelector.get_queue()


func _process(_delta):
	if ball_queue[1] == 0:
		$Sprite.texture = PINK_BALL
	if ball_queue[1] == 1:
		$Sprite.texture = RED_BALL
	if ball_queue[1] == 2:
		$Sprite.texture = ORANGE_BALL
	if ball_queue[1] == 3:
		$Sprite.texture = YELLOW_BALL
