extends Area2D

export(float) var health = 4.0 setget set_health
export(Vector2) var velocity = Vector2()
export(float) var firing_rate = 0.25

func _ready():
	set_process(true)
	pass

func _process(delta):
	pass

func tilt(direction):
	# Play tilt animation for the correct direction
	# Move in that direction
	pass

func shoot():
	# Create a projectile
	# Play shooting animation
	pass

func set_health(new_value):
	health = new_value
	
	if health <= 0:
		self.queue_free()
	pass