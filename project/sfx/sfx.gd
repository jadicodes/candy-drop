extends Control

var playing := true


func play_music() -> void:
	if playing:
		$Music.play()


func stop_music() -> void:
	if !playing:
		$Music.stop()

func _return_playing():
	return $Music.playing
