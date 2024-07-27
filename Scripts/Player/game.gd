extends Node


var playerHP = 10
var base_playerHP = 10
var cauldronHP = 100
var base_cauldronHP = 100
var wave_1_complete = false

var ore = 0
var mercury = 0

enum WeaponType {
	GUNS,     	# Weakness: Melee, Strength: Summons
	MELEE,    	# Weakness: Summons, Strength: Guns
	SUMMONS,  	# Weakness: Guns, Strength: Melee
	EXPLOSIVES, # Weakness: Alchemy, Strength: Magic
	MAGIC,    	# Weakness: Explosives, Strength: Alchemy
	ALCHEMY   	# Weakness: Magic, Strength: Explosives
}
