extends Node2D

onready var play = get_node("canvas/Node2D/play")
onready var stop = get_node("canvas/Node2D/pausar")

var next_scene = preload("res://scenes/level1.tscn")

func _ready():
	$music.play()

func _on_play_pressed():
	get_node("music").play()

func _on_pausar_pressed():
	get_node("music").stop()

func _on_Button_pressed():
	get_node("choice").play()
	get_tree().change_scene_to(next_scene)
