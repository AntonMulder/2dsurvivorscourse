extends Node

@export var sword_ability: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.timeout.connect(on_timer_timeout)


func on_timer_timeout():
	var player: CharacterBody2D = get_tree().get_first_node_in_group("player")

	if player == null:
		return
	var sword_instance = sword_ability.instantiate() as Node

	player.get_parent().add_child(sword_instance)
	sword_instance.global_position = player.global_position
