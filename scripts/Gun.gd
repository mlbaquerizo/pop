# Gun

extends Node2D

var level = 2

export(Array, Array, int) var GUN_POSITIONS
# = [
#	[0],
#	[1,2],
#	[0,1,2]
#]	

# Preload the projectile scene used by the gun
const SCN_PROJECTILE = preload("res://scenes/Projectile.tscn")

func _ready():
	pass

func create_projectile(pos):
	var projectile = SCN_PROJECTILE.instance()
	projectile.position = pos
	Utils.scene_root.add_child(projectile)
	pass
