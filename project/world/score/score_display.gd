extends Control

var score: int

func _ready():
	score = 0
	_update_score_label()


func _update_score_label():
	$Cloud/Score.text = str(score)


func _add_to_score(num):
	score = score + num
	_update_score_label()
