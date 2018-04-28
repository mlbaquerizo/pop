# Utils

extends Node

var scene_root setget , _get_scene_root


func _get_scene_root():
	var root = get_tree().get_root()
	return root.get_child(root.get_child_count() -1)
	pass