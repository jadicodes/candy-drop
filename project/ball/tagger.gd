extends Node

var big_array = []


func assign_tags(match_array) -> bool:
	big_array.append(match_array)
	if len(big_array) == 2:
		clear_arrays()
		print("true")
		return true
	else: 
		return false


func clear_arrays():
	big_array.clear()
