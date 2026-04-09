extends CharacterBody2D

const MOVE_SPEED := 75.0
const JUMP_SPEED := 150.0
const GRAVITY := 10

##Set to acces as unique name by right clicking the animated sprite2d. supposedly this lets you change the name without issue
@onready var sprite = %AnimatedSprite2D

func _process(delta: float) -> void:
	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true
		
	if velocity.x !=0:
		sprite.play("walk")
	elif !is_on_floor():
		sprite.play("jump")
	else:
		sprite.play("idle")

func _physics_process(delta: float) -> void:
	
	##Jumping
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y -= JUMP_SPEED
	
	##Gravity
	if !is_on_floor():
		velocity.y += GRAVITY
		##Preferably make your own gravity
		
	##Movement
	var direction = Input.get_axis("ui_left","ui_right")
	velocity.x = direction * MOVE_SPEED
	
	move_and_slide()
	
var health = 3
	
func _on_hurtbox_area_entered(area: Area2D) -> void:
	health -= 1
	print(health)
	if health == 0:
		queue_free()
	
