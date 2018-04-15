# Projectile

extends Area2D

export(Vector2) var VELOCITY

func _ready():
	set_process(true)
	
	yield(get_node("VisNotifier"), "screen_exited")
	self.queue_free()
	pass

func _process(delta):
	self.translate(self.VELOCITY * delta)
	pass
