# Projectile

extends Area2D

export(Vector2) var VELOCITY

func _ready():
	set_process(true)
	
	self.connect("area_entered", self, "_on_area_entered")
	
	yield(get_node("VisNotifier"), "screen_exited")
	self.queue_free()
	pass

func _process(delta):
	self.translate(self.VELOCITY * delta)
	pass

func _on_area_entered(other_node):
	if other_node.is_in_group("enemy"):
		other_node.set_armor(other_node.armor - 1)
		
		self.queue_free()
	pass
