extends CanvasLayer

@onready var score_label = $MarginContainer/HSplitContainer/scoreLabel
@onready var time_label = $MarginContainer/HSplitContainer/timeLabel
@onready var goal_label = $Static/goalLabel
@onready var gameover_label = $gameoverLabel

func update_score(_score: int) -> void:
	score_label.text = "Score: " + str(_score)

func update_goal_text(_coins_goal: int) -> void:
	goal_label.text = "Collect the " + str(_coins_goal) + " coins to win the game"
	await get_tree().create_timer(3).timeout
	goal_label.visible = false

func update_time(_time:float) -> void:
	time_label.text = _format_seconds(_time)

func _format_seconds(_elapsed_seconds: float) -> String:
	var seconds:float = fmod(_elapsed_seconds , 60.0)
	var minutes:int   =  int(_elapsed_seconds / 60.0) % 60
	var hhmmss_string:String = "%02d:%05.2f" % [minutes, seconds]
	return hhmmss_string

# End state
func gameover(_state:bool, _final_time:float=0.0) -> void:
	gameover_label.text = "Good job! Completed in " + _format_seconds(_final_time)
	gameover_label.text += "\n Press any key to restart"
	gameover_label.visible = _state
	time_label.visible = !_state
	goal_label.visible = !_state
	
