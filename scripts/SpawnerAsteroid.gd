# SpawnerAsteroid

extends Node

const asteroids = [
	preload("res://scenes/Asteroid.tscn")
]

func _ready():
	spawn()
	pass

func spawn():
	
	while true: # infinitely spawn
		# create one instance from asteroids constant - for now just get first
		var asteroid = asteroids[0].instance()
		
		asteroid.position = set_asteroid_pos(asteroid)
		asteroid.velocity = set_asteroid_velocity(asteroid)
		
		$Container.add_child(asteroid)
		yield(Utils.create_timer(rand_range(1.0, 1.25)), "timeout")
	pass

func set_asteroid_pos(asteroid):
	randomize()
	var pos = Vector2()
	pos.x = rand_range(15, Utils.viewport_size.x - 15)
	pos.y = -15
	return pos
	pass

func set_asteroid_velocity(asteroid):
	randomize()
	var velocity = Vector2()
	velocity.x = rand_range(-100, 100)
	velocity.y = rand_range(150, 300)
	return velocity
	pass