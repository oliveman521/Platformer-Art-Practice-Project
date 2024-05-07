extends CharacterBody2D
class_name Player

const SPEED = 1000.0
const JUMP_VELOCITY = -2200.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var sprite_2d: Sprite2D = $Sprite2D

const kill_y: float = 5500

var spawn_point: Vector2

static var instance: Player
@onready var animation_player: AnimationPlayer = $AnimationPlayer
const JUMP_ANIM: String = "Jump"
const WALK_ANIM: String = "Walk"
const IDLE_ANIM: String = "Idle"
const LAND_ANIM: String = "Land"
const AIRBORN_ANIM: String = "Airborn"

var coins: int = 0

func _ready() -> void:
	instance = self
	spawn_point = position

func respawn() -> void:
	position = spawn_point
	velocity = Vector2.ZERO

var was_just_on_floor: bool = false

func _physics_process(delta: float) -> void:
	if position.y > kill_y:
		respawn()
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animation_player.play(JUMP_ANIM, 0)
		animation_player.queue(AIRBORN_ANIM)
	
	
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction: float = Input.get_axis("Left", "Right")
	if direction:
		sprite_2d.flip_h = direction == -1
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED/5)
	
	move_and_slide()
	
	#Animations
	if is_on_floor():
		if !was_just_on_floor: #if we just landed
			animation_player.play(LAND_ANIM, 0)
		
		if animation_player.current_animation != LAND_ANIM:
			if velocity.x != 0:
				animation_player.play(WALK_ANIM)
			else:
				animation_player.play(IDLE_ANIM)
	else:
		if animation_player.current_animation != JUMP_ANIM:
			animation_player.play(AIRBORN_ANIM)
	
	was_just_on_floor = is_on_floor()
