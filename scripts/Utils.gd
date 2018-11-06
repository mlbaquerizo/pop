# Utils

extends Node

var viewport_size setget , _get_viewport_size
var scene_root setget , _get_scene_root

func _get_viewport_size():
	return get_tree().get_root().get_visible_rect().size
	pass

func _get_scene_root():
	var root = get_tree().get_root()
	return root.get_child(root.get_child_count() -1)
	pass

func create_timer(wait_time):
	var timer = Timer.new()
	timer.set_wait_time(wait_time)
	timer.set_one_shot(true)
	timer.connect("timeout", timer, "queue_free")
	add_child(timer)
	timer.start()
	return timer
	pass