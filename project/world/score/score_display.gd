extends Control

var score: int = 0
var new_score: int = 0
var displayed_score: float = 0

func _process(_delta) -> void:
	# Interpolate the displayed score towards the new score
	displayed_score = lerp(float(displayed_score), float(new_score), 0.05)
	$Cloud/ScoreLabel.text = str(int(displayed_score))

	# Update the score immediately after updating the displayed score
	score = new_score

func _add_to_score(num: int) -> void:
	new_score += num

func _return_score() -> int:
	return score
