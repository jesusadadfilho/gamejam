extends Node2D

onready var play = get_node("play")
var next_scene = preload("res://scenes/level1.tscn")

func _ready():
	$music.play()

func _on_play_pressed():
	$choice.play()
	get_tree().change_scene_to(next_scene)
