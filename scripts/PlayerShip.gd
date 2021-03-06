# PlayerShip

extends Area2D

export(float) var health = 4.0 setget set_health
export(int) var MAX_SPEED
export(int) var ACCELERATION
export(int) var DECELERATION
export(float) var firing_rate = 0.25

var screensize
var input_direction = Vector2()
var direction = Vector2()
var speed = 0
var tilt_state = "neutral" setget set_tilt_state

onready var anim_player = $Sprite/AnimationPlayer

func _ready():
	screensize = get_viewport_rect().size
	set_process(true)
	set_process_input(true)
	
	self.add_to_group("ship")
	pass

func _input(event):
	_handle_movement(event)
	_handle_shoot_button_pressed(event)
	pass

func _process(delta):
	var velocity = Vector2()
	
	if self.input_direction.length():
		self.speed += self.ACCELERATION * delta
	else:
		self.speed -= self.DECELERATION * delta

	self.speed = clamp(self.speed, 0, self.MAX_SPEED)
	
	velocity += self.direction.normalized() * self.speed
	
	var new_pos = self.position
	new_pos += velocity * delta
	new_pos.x = clamp(new_pos.x, 60, screensize.x - 60)
	new_pos.y = clamp(new_pos.y, 60, screensize.y - 60)
	
	self.position = new_pos
	
	var root = get_tree().get_root()
	pass

func tilt(direction):
	# Play tilt animation for the correct direction
	var tilt_str = "tilt_%s"
	self.anim_player.play(tilt_str % direction)
	pass

func return_to_neutral(from_dir):
	var tilt_str = "tilt_%s"
	self.anim_player.play_backwards(tilt_str % from_dir)
	pass

func _handle_movement(event):
	var move_up = event.is_action_pressed("move_up")
	var move_right = event.is_action_pressed("move_right")
	var move_down = event.is_action_pressed("move_down")
	var move_left = event.is_action_pressed("move_left")
	
	var input_move_up = Input.is_action_pressed("move_up")
	var input_move_right = Input.is_action_pressed("move_right")
	var input_move_down = Input.is_action_pressed("move_down")
	var input_move_left = Input.is_action_pressed("move_left")
	
	var not_moving = !(input_move_up || input_move_right || input_move_down || input_move_left)

	if move_up:
		if input_move_down:
			self.input_direction.y = 0
		else:
			self.input_direction.y = -1
		
	if move_right:
		if input_move_left:
			self.input_direction.x = 0
			if self.tilt_state == "left" || self.tilt_state == "right":
				self.return_to_neutral(self.tilt_state)
				self.set_tilt_state("neutral")
		else:
			self.input_direction.x = 1
			self.set_tilt_state("right")
	
	if move_down:
		if input_move_up:
			self.input_direction.y = 0
		else:
			self.input_direction.y = 1
	
	if move_left:
		if input_move_right:
			self.input_direction.x = 0
			if self.tilt_state == "left" || self.tilt_state == "right":
				self.return_to_neutral(self.tilt_state)
				self.set_tilt_state("neutral")
		else:
			self.input_direction.x = -1
			self.set_tilt_state("left")
	
	if event.is_action_released("move_right"):
		if input_move_left:
			self.input_direction.x = -1
			self.set_tilt_state("left")
	
	if event.is_action_released("move_left"):
		if input_move_right:
			self.input_direction.x = 1
			self.set_tilt_state("right")
	
	if event.is_action_released("move_up"): 
		if input_move_down:
			self.input_direction.y = 1
	
	if event.is_action_released("move_down"):
		if input_move_up:
			self.input_direction.y = -1
	
	if !(input_move_up || input_move_down):
		#self.input_direction.y = 0
		pass
	
	if !(input_move_right || input_move_left):
		#self.input_direction.x = 0
		if self.tilt_state == "left" || self.tilt_state == "right":
			self.return_to_neutral(self.tilt_state)
			self.set_tilt_state("neutral")
		
	if not_moving:
		self.input_direction = Vector2()
	
	if self.input_direction.length():
		self.direction = self.input_direction
	
	pass

func _handle_shoot_button_pressed(event):
	var shoot = event.is_action_pressed("shoot")
	
	if(shoot):
		self.shoot()
	pass

func shoot():
	var gun_node = $Gun
	if gun_node:
		var cannons = gun_node.get_children()
		if cannons.size() > 0:
			for i in gun_node.GUN_LEVEL_POSITIONS[gun_node.level]:
				var cannon = cannons[i]
				var pos = cannon.get_global_position()
				gun_node.create_projectile(pos)
				pass
	#for i range(cannons.length):
	#	if 
	#	var cannon = $Gun.get_children()[i]
	#	var pos = cannon.get_global_position()
	#	$Gun.create_projectile(pos)
	pass

func set_health(new_health):
	health = new_health
	
	if health <= 0:
		self.queue_free()
	pass
	
func set_tilt_state(new_state):
	tilt_state = new_state
	if new_state == "left" || new_state == "right":
		self.tilt(new_state)
	pass