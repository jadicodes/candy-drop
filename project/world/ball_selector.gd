extends Node

var throwable_balls = [0, 1, 2]
var all_balls = [0, 1, 2,3]
var ball_queue = []


func _ready():
	ball_queue = [throwable_balls.pick_random()]
	create_incoming_ball()


func remove_and_create_ball():
	remove_first_ball()
	create_incoming_ball()


func create_incoming_ball():
	ball_queue.push_back(throwable_balls.pick_random())


func remove_first_ball():
	ball_queue.remove_at(0)


func get_queue() -> Array:
	return ball_queue


func get_all_balls() -> Array:
	return all_balls
