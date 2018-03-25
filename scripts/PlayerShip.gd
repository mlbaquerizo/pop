extends Area2D

export(float) var health = 4.0 setget set_health
export(float) var MAX_SPEED = 1000
export(float) var ACCELERATION = 4000
export(float) var DECELERATION = 800
export(float) var firing_rate = 0.25

var screensize
var input_direction = Vector2()
var speed = 0

func _ready():
	screensize = get_viewport_rect().size
	set_process(true)
	pass

func _process(delta):
	var velocity = Vector2()
	
	var move_up = Input.is_action_pressed("move_up")
	var move_right = Input.is_action_pressed("move_right")
	var move_down = Input.is_action_pressed("move_down")
	var move_left = Input.is_action_pressed("move_left")
	var not_moving = !(move_up || move_right|| move_down || move_left)
	
	if move_up && !move_down:
		self.input_direction.y = -1
	
	if move_right && !move_left:
		self.input_direction.x = 1
	
	if move_down && !move_up:
		self.input_direction.y = 1
	
	if move_left && !move_right:
		self.input_direction.x = -1
	
	if !(move_up || move_down):
		self.input_direction.y = 0
	
	if !(move_right || move_left):
		self.input_direction.x = 0
	
	if not_moving:
		self.input_direction = Vector2()
	
	if self.input_direction.length() != 0:
		self.speed += self.ACCELERATION * delta
	else:
		self.speed -= self.DECELERATION * delta
	
	self.speed = clamp(self.speed, 0, self.MAX_SPEED)

	velocity = self.input_direction.normalized() * self.speed
	
	var new_pos = self.position
	new_pos += velocity * delta
	new_pos.x = clamp(new_pos.x, 60, screensize.x - 60)
	new_pos.y = clamp(new_pos.y, 60, screensize.y - 60)
	
	self.position = new_pos
	
	pass

func tilt(direction):
	# Play tilt animation for the correct direction
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