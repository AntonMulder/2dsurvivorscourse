extends Node

const SPAWN_RADIUS = 375

@export var basic_enemy_scene: PackedScene


func _ready() -> void:
	$Timer.timeout.connect(on_timer_timeout)


func on_timer_timeout():
	var player: CharacterBody2D = get_tree().get_first_node_in_group("player")

	if player == null:
		return

	var random_direction: Vector2 = Vector2.RIGHT.rotated(randf_range(0, TAU))

	var spawn_position = player.global_position + (random_direction * SPAWN_RADIUS)

	var enemy: CharacterBody2D = basic_enemy_scene.instantiate()
	get_parent().add_child(enemy)
	enemy.global_position = spawn_position
