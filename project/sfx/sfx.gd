extends Control

var playing := true


func play_music() -> void:
	if playing:
		$Music.play()


func stop_music() -> void:
	if !playing:
		$Music.stop()


func _toggle_sound():
	$Music.stream_paused = !$Music.stream_paused
