extends Node

@export var end_screen_scene: PackedScene
@onready var player: Player = $%Player


func _ready() -> void:
    player.health_component.died.connect(on_player_died)


func on_player_died() -> void:
    var end_screen_instance: EndScreen = end_screen_scene.instantiate()
    add_child(end_screen_instance)
    end_screen_instance.set_defeat()
