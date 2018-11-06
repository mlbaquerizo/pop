# Asteroid

extends Area2D

var velocity = Vector2()
export(int) var armor = 2 setget set_armor

func _ready():
	set_process(true)
	self.add_to_group("enemy")
	self.connect("area_entered", self, "_on_area_entered")
	pass

func _process(delta):
	self.translate(velocity * delta)
	
	if self.position.y - 15 >= get_viewport_rect().size.y:
		self.queue_free()
	pass

# func create_explosion():
# 	pass

func set_armor(new_value):
	if self.is_queued_for_deletion():
		return
	armor = new_value
	
	if armor <= 0:
		# self.create_explosion()
		self.queue_free()
	pass

func _on_area_entered(other_node):
	if other_node.is_in_group("ship"):
		other_node.set_health(other_node.health - 1)
		#self.create_explosion()
		self.queue_free()
	pass
