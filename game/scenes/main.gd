extends Node2D
## Game manager

signal spaced

var score:int = 0
var time_elapsed:float = 0
var collectibles_count:int
var game_over:bool = false

@onready var UI = $UI
@onready var player:Player = $Player

# Setup the connections between elements
func _ready():
	# Connect all signals from coins 
	var _collectibles = $Collectibles
	for collectible in _collectibles.get_children():
		collectible.collected.connect(_increase_score)
	
	var _obstacles = $Obstacles
	for obstacle in _obstacles.get_children():
		obstacle.died.connect(_defeat)
	
	collectibles_count = _collectibles.get_child_count()
	
	_reset_game(collectibles_count)

func _process(delta):
	if not game_over:
		time_elapsed += delta
		UI.update_time(time_elapsed)

func _reset_game(_collectibles_count: int) -> void:
	score = 0
	time_elapsed = 0.0
	UI.update_score(score)
	UI.update_goal_text(_collectibles_count)
	UI.gameover(false)

func _increase_score() -> void:
	score += 1
	UI.update_score(score)
	if score >= collectibles_count:
		_gameover()

# Player died, reset game
func _defeat() -> void: 
	get_tree().reload_current_scene()

func _gameover() -> void:
	game_over = true
	UI.gameover(game_over, time_elapsed)
	player.process_mode = Node.PROCESS_MODE_DISABLED
	
	await spaced
	get_tree().reload_current_scene()

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_SPACE:
			spaced.emit()
