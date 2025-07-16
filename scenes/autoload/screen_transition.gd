extends CanvasLayer

signal transitioned_halfway

var skip_emit: bool = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func transition() -> void:
    animation_player.play("default")
    await transitioned_halfway
    skip_emit = true
    animation_player.play_backwards("default")


func emit_transitioned_halfway() -> void:
    if skip_emit:
        skip_emit = false
    else:
        transitioned_halfway.emit()
