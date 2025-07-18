class_name AxeAbility extends Node2D

const MAX_RADIUS: int = 100

var base_rotation: Vector2

@onready var hitbox_component: HitboxComponent = $HitboxComponent


func _ready() -> void:
    base_rotation = Vector2.RIGHT.rotated(randf_range(0, TAU))
    var tween: Tween = create_tween()
    tween.tween_method(tween_method, 0.0, 2.0, 3)
    tween.tween_callback(queue_free)


func tween_method(rotations: float) -> void:
    var current_radius: float = (rotations / 2) * MAX_RADIUS
    var current_direction: Vector2 = base_rotation.rotated(rotations * TAU)

    var player: Player = get_tree().get_first_node_in_group("player")
    if player == null:
        return

    global_position = (
        player.global_position + (current_direction * current_radius)
    )
