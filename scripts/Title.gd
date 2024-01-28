extends Node2D

@onready var CREWSCENE = preload("res://scenes/crew_select.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Intro")



func _on_button_pressed():
	$LaLoonsTitle.hide()
	get_tree().get_root().add_child(CREWSCENE)
