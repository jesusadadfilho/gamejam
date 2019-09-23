extends Node2D

signal uptdate_map

onready var pessoa  = preload("res://scenes/pessoa.tscn")
onready var start_pos =  $startPos
onready var end_pos = $endpos
onready var nav = $nav
onready var map = $nav/map

func _ready():
	set_process_input(true)

func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
			var tile = map.world_to_map(event.position)
			if event.get_button_index() == 1:
				map.set_cell(tile.x, tile.y, 1)
			elif event.get_button_index() == 2:
				map.set_cell(tile.x, tile.y, 1)
	if event is InputEventMouseButton and not event.is_pressed():
		emit_signal("uptdate_map")

func _on_mob_time_timeout():
	var m = pessoa.instance()
	add_child(m)
	m.position = start_pos.position
	m.goal = end_pos.position
	m.nav = nav
	#connect("uptdate_map",m, "update_path")
