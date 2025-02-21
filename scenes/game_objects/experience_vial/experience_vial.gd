class_name ExperienceVal extends Node2D

@onready var area_2d: Area2D = $Area2D
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var sprite_2d: Sprite2D = $Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    area_2d.area_entered.connect(on_area_entered)


func tween_collect(percent: float, start_position: Vector2) -> void:
    var player: Player = get_tree().get_first_node_in_group("player")

    if player == null:
        return

    global_position = start_position.lerp(player.global_position, percent)
    var direction_from_start: Vector2 = player.global_position - start_position

    var target_rotation: float = direction_from_start.angle() + deg_to_rad(90)
    rotation = lerp_angle(
        rotation, target_rotation, 1 - exp(-2 * get_process_delta_time())
    )


func collect() -> void:
    GameEvents.emit_experience_vial_collected(1)
    queue_free()


func disable_collision() -> void:
    collision_shape_2d.disabled = true


func on_area_entered(_other_area: Area2D) -> void:
    Callable(disable_collision).call_deferred()
    var tween: Tween = create_tween()
    tween.set_parallel()
    (
        tween
        . tween_method(tween_collect.bind(global_position), 0.0, 1.0, 0.5)
        . set_ease(Tween.EASE_IN)
        . set_trans(Tween.TRANS_BACK)
    )
    tween.tween_property(sprite_2d, "scale", Vector2.ZERO, .5).set_delay(0.5)
    tween.chain()
    tween.tween_callback(collect)
