extends Node

@export_range(0, 1) var drop_percent: float = 1.0
@export var vial_scene: PackedScene
@export var health_component: Node


func _ready() -> void:
    (health_component as HealthComponent).died.connect(on_died)


func on_died():
    if randf() > drop_percent:
        return

    if vial_scene == null:
        return

    if not owner is Node2D:
        return

    var spawn_position = (owner as Node2D).global_position
    var vial_instance: Node2D = vial_scene.instantiate()
    var entities_layer: Node2D = get_tree().get_first_node_in_group(
        "entities_layer"
    )
    entities_layer.add_child(vial_instance)
    vial_instance.global_position = spawn_position
