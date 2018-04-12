# Projectile

extends Area2D

export(int) var SPEED

func _ready():
	set_process(true)
	
	yield(get_node("VisNotifier"), "screen_exited")
	self.queue_free()
	pass

func _process(delta):
	self.translate(Vector2(0, self.SPEED) * delta)
	pass
