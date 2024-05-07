extends Node2D



@onready var confetti_particles: GPUParticles2D = $"Confetti Particles"



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		confetti_particles.emitting = true
