extends Node2D

var time_start = 0
var time_now = 0

func _ready():
	time_start = OS.get_unix_time()
	print(time_start)
	set_process(true)
	
	
func _process(delta):
	time_now = OS.get_unix_time()
	var elapsed = time_now - time_start
	var minutes = elapsed / 60
	var seconds = elapsed % 60
	var str_elapsed = "%02d : %02d" % [minutes, seconds]
	print("elapsed:", str_elapsed )