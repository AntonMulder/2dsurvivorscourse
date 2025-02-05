class_name BasicEnemey extends CharacterBody2D

const MAX_SPEED: int = 40

@onready var health_component: HealthComponent = $HealthComponent


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
    var direction: Vector2 = get_direction_to_player()
    velocity = direction * MAX_SPEED
    move_and_slide()


func get_direction_to_player() -> Vector2:
    var player_node: CharacterBody2D = get_tree().get_first_node_in_group(
        "player"
    )

    if player_node:
        return (player_node.global_position - global_position).normalized()
    return Vector2.ZERO
