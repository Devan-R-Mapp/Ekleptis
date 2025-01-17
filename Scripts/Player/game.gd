extends Node


var weaponInternalCD = .3
var automatic_upgrade = false
var light_energy = 2.5
var dark_energy = 0


var playerHP = 10
var base_playerHP = 10
var cauldronHP = 100
var base_cauldronHP = 100
var wave_1_complete = false

var crafting_zone = false

var ore = 0
var mercury = 0

var basic_kills = 0
var boss_kills = 0
var portal_kills = 0

enum WeaponType {
	GUNS,     	# Weakness: Melee, Strength: Summons
	MELEE,    	# Weakness: Summons, Strength: Guns
	SUMMONS,  	# Weakness: Guns, Strength: Melee
	EXPLOSIVES, # Weakness: Alchemy, Strength: Magic
	MAGIC,    	# Weakness: Explosives, Strength: Alchemy
	ALCHEMY   	# Weakness: Magic, Strength: Explosives
}
