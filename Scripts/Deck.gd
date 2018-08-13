extends Node2D


var _cards = []

var SUITS = ["SPADES", "CLUBS", "DIAMONDS", "HEARTS"]

var RANKS = [2,3,4,5,6,7,8,9,10, "Jack", "Queen", "King", "Ace"]

func _ready():
	#Create and shuffle the deck
	create_deck()
	_shuffle()

func create_deck():
	#Load the card template
	var card_template = load("res://Scenes/Card.tscn")

	#Create a card that has a value and suit
	for i in range(SUITS.size()):
		for j in range(RANKS.size()):
			#A templated card with no value and suit
			var single_card = card_template.instance()

			#Set the suit, rank & value
			single_card.set_value(j+2)
			single_card.set_type(SUITS[i])
			single_card.set_rank(str(RANKS[j]))


			#Add the card to the deck
			_cards.append(single_card)
			
func _on_Hand_hit(hand):
	#Check if there are enough cards in the deck
	if _cards.size() == 0:
		#Create a new deck
		create_deck()
		_shuffle()
	
	#Add card to hand
	hand.add_card(get_card())

func _shuffle():
	#Generate random seed
	randomize()

	#For each card in the deck swap cards with a random one
	for i in range(_cards.size()):

		#Randomly index in the deck
		var rand_num = randi() % _cards.size()

		#Card that is about to be swapped
		var temp = _cards[i]

		#Swap cards
		_cards[i] = _cards[rand_num]
		_cards[rand_num] = temp

func get_card():
		return _cards.pop_front()

func _on_Hand_reset(hand):
	hand.empty()
	hand.add_card(get_card())
	hand.add_card(get_card())