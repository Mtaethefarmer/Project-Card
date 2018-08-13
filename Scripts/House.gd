extends Node

onready var hand = $Hand
onready var deck = $Deck

signal isDone

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _on_BlackJack_World_house_turn(player_score):
	while(hand.get_score() < 17):
		hand.hit_me()
		
	emit_signal("isDone")