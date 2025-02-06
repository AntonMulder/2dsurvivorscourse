class_name AxeAbilityController extends Node

@export var axe_ability_scene: PackedScene

var damage: int = 10

@onready var timer: Timer = $Timer


func _ready() -> void:
    timer.timeout.connect(on_timer_timeout)


func on_timer_timeout() -> void:
    var player: Player = get_tree().get_first_node_in_group("player")
    if player == null:
        return

    var foreground_layer: Node = get_tree().get_first_node_in_group(
        "foreground_layer"
    )
    if foreground_layer == null:
        return

    var axe_instance: AxeAbility = axe_ability_scene.instantiate()
    foreground_layer.add_child(axe_instance)
    axe_instance.global_position = player.global_position
    axe_instance.hitbox_component.damage = damage
