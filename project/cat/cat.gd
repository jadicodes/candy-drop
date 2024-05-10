extends CharacterBody2D

const PINK = preload("res://ball/pink_ball.png")
const RED = preload("res://ball/red_ball.png") 
const ORANGE = preload("res://ball/orange_ball.png")

var ball_queue: Array
var _offset_amount

func _ready() -> void:
	ball_queue = BallSelector.get_queue()
	_next_ball()


func _physics_process(_delta) -> void:
	global_position.x = clamp(get_global_mouse_position().x, 426 + $Collision.shape.radius/2 + _offset_amount, 1494 - $Collision.shape.radius/2 - _offset_amount)


func _next_ball() -> void:
	if ball_queue[0] == 0:
		$HoldItem.texture = PINK
		_offset_amount = 1
	if ball_queue[0] == 1:
		$HoldItem.texture = RED
		_offset_amount = 24
	if ball_queue[0] == 2:
		_offset_amount = 48
		$HoldItem.texture = ORANGE


func _empty_hand():
	$HoldItem.texture = null
