extends CharacterBody2D
class_name Enemy

const SPEED = 300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

const kill_y: float = 5500

var spawn_point: Vector2

@onready var animation_player: AnimationPlayer = $AnimationPlayer
const JUMP_ANIM: String = "Jump"
const WALK_ANIM: String = "Walk"
const IDLE_ANIM: String = "Idle"
const LAND_ANIM: String = "Land"
const AIRBORN_ANIM: String = "Airborn"

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var outgoing_hitbox: Area2D = $"Outgoing hitbox"
@onready var incoming_hitbox: Area2D = $"Incoming Hitbox"


func die() -> void:
	queue_free()

var was_just_on_floor: bool = false

var direction: float = 1

func _physics_process(delta: float) -> void:
	if position.y > kill_y:
		die()
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if is_on_wall():
		position.x += 20 * - direction
		direction *= -1
		sprite_2d.flip_h = direction == -1
	else:
		velocity.x = direction * SPEED
	
	move_and_slide()
	
	#Animations
	if is_on_floor():
		if !was_just_on_floor: #if we just landed
			animation_player.play(LAND_ANIM)
		
		if animation_player.current_animation != LAND_ANIM:
			if velocity.x != 0:
				animation_player.play(WALK_ANIM)
			else:
				animation_player.play(IDLE_ANIM)
	else:
		if animation_player.current_animation != JUMP_ANIM:
			animation_player.play(AIRBORN_ANIM)
	
	was_just_on_floor = is_on_floor()




func _on_outgoing_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.respawn()


func _on_incoming_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		queue_free()
