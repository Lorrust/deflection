extends Node2D

@export var player_scene : PackedScene
@export var ball_scene : PackedScene

var players = []
var player1
var player2
var ball

# Called when the node enters the scene tree for the first time.
func _ready():
	var screen_size = get_viewport_rect().size
	
	player1 = player_scene.instantiate()
	player2 = player_scene.instantiate()
	
	player1.player_number = 1
	player2.player_number = 2
	
	players.append(player1)
	players.append(player2)
	
	ball = ball_scene.instantiate()
	
	add_child(player1)
	add_child(player2)
	add_child(ball)
	
	reset_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func reset_game():
	reset_ball()
	reset_players()

func reset_ball():
	var screen_size = get_viewport_rect().size
	ball.position = Vector2(screen_size.x / 2, screen_size.y / 2)
	ball.speed = ball.INITIAL_SPEED  # If you want to reset the speed

func reset_players():
	var screen_size = get_viewport_rect().size
	player1.position = Vector2(200, screen_size.y / 2)
	player2.position = Vector2(screen_size.x - 200, screen_size.y / 2)
