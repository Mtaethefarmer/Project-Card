extends Node2D

var _value = 0 setget set_value, get_value
var _type = "Clubs" setget set_type, get_type
var _rank = "3" setget set_rank, get_rank

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func set_value(unit):
	#Check if unit in numerical i.e 2-10
	if (unit >= 2 && unit <=10):
		#Card value is taken at face value
		_value = unit

	#Check if unit is Jack, Queen, King
	elif (unit == 11 || unit == 12 || unit == 13):
		#Face cards have a value of 10
		_value = 10

	#Check if unit is Ace
	elif (unit == 14):
		#Ace can be 1 or 11
		_value = 1

func get_value():
	return _value

func set_type(new_type):
	_type = new_type

func get_type():
	return _type

func set_rank(rank):
	_rank = rank

func get_rank():
	return _rank