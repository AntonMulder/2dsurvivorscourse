class_name GameCamera extends Camera2D

var target_position: Vector2 = Vector2.ZERO


func _ready() -> void:
    make_current()


func _process(delta: float) -> void:
    acquire_target()

    global_position = global_position.lerp(
        target_position, 1.0 - exp(-delta * 20)
    )


func acquire_target() -> void:
    var player_nodes: Array[Node] = get_tree().get_nodes_in_group("player")

    if player_nodes.size() > 0:
        var player: Node2D = player_nodes[0]

        target_position = player.global_position
