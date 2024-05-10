extends Control

var score: int = 0


func _update_score_label():
	$Cloud/ScoreLabel.text = str(score)


func _add_to_score(num):
	score = score + num
	_update_score_label()


func _return_score():
	return score
