extends Node

enum TURN {PLAYER, HOUSE}

enum STATE {IN_ST, TWENTYONE_ST, BUST_ST, BLACKJACK_ST}

var turn = TURN.PLAYER

onready var _player = get_node("Player/Hand")
onready var _house = get_node("House/Hand")

signal winner
signal player_turn
signal house_turn

func _ready():
	_player.hit_me()
	_player.hit_me()
	calc_winner(_house.get_score(), _player.get_score())

func _on_Stand_Btn_pressed():
	#Set the turn to the house
	turn = TURN.HOUSE
	emit_signal("house_turn", _player.get_score())
	
func calc_winner(house_score, player_score):
	
	#Check if the player has BlackJack
	if _player.cur_st == STATE.BLACKJACK_ST:
		return "Player"
	
	#Check if either hand BUSTED
	if _player.cur_st == STATE.BUST_ST:
		return "House"
		
	if _house.cur_st == STATE.BUST_ST:
		return "Player"
	
	#Check if the house and player both have the same score
	if house_score == player_score:
		return "Push"
		
	#Check for the winner
	if house_score < player_score:
		return "Player"
	else:
		return "House"

func _on_House_isDone():
	#Calculate the winner
	var winner = calc_winner(_house.get_score(), _player.get_score())
	print("Winner is " + winner)
	emit_signal("winner", winner)