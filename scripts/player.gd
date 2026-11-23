extends CharacterBody2D

const max_speed = 100
const accel = 1500
const friction = 4000
var current_dir = "none"

func _ready():
	$AnimatedSprite2D.play("idle")

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		print("Key: ", event.as_text(), " | Echo: ", event.is_echo())

var input = Vector2.ZERO

func _physics_process(delta):
	player_movement(delta)

func get_input():
	input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")) 
	input.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	if input.x == 1:
		current_dir = "right" 
		play_anim(1)
	elif input.x == -1:
		current_dir = "left" 
		play_anim(1)
	elif input.y == 1 or input.y == -1:
		play_anim(1) 
	else:
		play_anim(0)
	return input.normalized()
	
func player_movement(delta):
	input = get_input()
	print(velocity)
	if input == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
	else:
		velocity += (input * accel * delta)
		velocity = velocity.limit_length(max_speed)
	move_and_slide()

func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D 
	
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("right")
		elif movement == 0:
			anim.play("idle")
	if dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("right")
		elif movement == 0:
			anim.play("idle")
	
	
