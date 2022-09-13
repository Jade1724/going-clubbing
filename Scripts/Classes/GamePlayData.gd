extends Reference
class_name GamePlayData


var seal_count: int = 0 setget set_seal_count, get_seal_count
var headshot_count: int = 0 setget set_headshot_count, get_headshot_count
var score: int = 0 setget set_score, get_score


# Getters and setters
func get_seal_count():
	return seal_count
	
func set_seal_count(count):
	seal_count = int(count)
	
func get_headshot_count():
	return headshot_count
	
func set_headshot_count(count):
	headshot_count = int(count)
	
func get_score():
	return score
	
func set_score(new_score):
	score = new_score
