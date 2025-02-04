extends Node

const SPAWN_RADIUS = 375

@export var basic_enemy_scene: PackedScene
@export var arena_time_manager: ArenaTimeMagner

var base_spawn_time: float = 0.0

@onready var timer: Timer = $Timer


func _ready() -> void:
    base_spawn_time = timer.wait_time
    timer.timeout.connect(on_timer_timeout)
    arena_time_manager.arena_difficulty_increased.connect(
        on_arena_difficulty_increased
    )


func on_timer_timeout():
    timer.start()

    var player: CharacterBody2D = get_tree().get_first_node_in_group("player")

    if player == null:
        return

    var random_direction: Vector2 = Vector2.RIGHT.rotated(randf_range(0, TAU))

    var spawn_position = (
        player.global_position + (random_direction * SPAWN_RADIUS)
    )

    var entities_layer: Node2D = get_tree().get_first_node_in_group(
        "entities_layer"
    )

    var enemy: CharacterBody2D = basic_enemy_scene.instantiate()
    entities_layer.add_child(enemy)
    enemy.global_position = spawn_position


func on_arena_difficulty_increased(arena_difficulty: int) -> void:
    var time_off = (.1 / 12) * arena_difficulty
    print(time_off)
    timer.wait_time = max(base_spawn_time - time_off, 0.1)
