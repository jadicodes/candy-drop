extends Control

const PINK_BALL = preload("res://ball/pink_ball.png")
const RED_BALL = preload("res://ball/red_ball.png") 
const ORANGE_BALL = preload("res://ball/orange_ball.png") 

var ball_queue


func _ready():
	ball_queue = BallSelector.get_queue()


func _process(_delta):
	if ball_queue[1] == "pink":
		$Sprite.texture = PINK_BALL
	if ball_queue[1] == "red":
		$Sprite.texture = RED_BALL
	if ball_queue[1] == "orange":
		$Sprite.texture = ORANGE_BALL
