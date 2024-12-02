extends Node

var first_character_obtained #This will be whichever character the player picked first. Used to change sprite for player.
var party = [Mage]
var unobtained_characters = [Bard, Mage, Ranger, Rogue]

func obtained_character(character) -> void:
	var character_index = unobtained_characters.find(character)
	party.push_back(unobtained_characters[character_index])
	unobtained_characters.pop_at(character_index)
