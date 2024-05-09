extends Node

var big_array = []


func assign_tags(match_array) -> bool:
	big_array.append(match_array)
	print(str(big_array) + "\n")
	if len(big_array) == 2:
		if big_array[0][0] == big_array[1][1] and big_array[1][0] == big_array[0][1]:
			clear_arrays()
			return true
		else:
			clear_arrays()
	return false


func clear_arrays():
	big_array.clear()
