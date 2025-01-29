extends CharacterBody2D

const MAX_SPEED = 125
const ACCELERATION_SMOOTHING = 25

var number_coliding_bodies = 0
@onready var damage_interval_timer: Timer = $DamageIntervalTimer


func _ready() -> void:
    $CollisionArea2D.body_entered.connect(on_body_entered)
    $CollisionArea2D.body_exited.connect(on_body_exited)
    damage_interval_timer.timeout.connect(on_damage_interval_timer_timeout)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    var movement_vector = get_movement_vector()
    var direction = movement_vector.normalized()
    var target_velocity = direction * MAX_SPEED

    velocity = velocity.lerp(
        target_velocity, 1 - exp(-delta * ACCELERATION_SMOOTHING)
    )
    move_and_slide()


func get_movement_vector() -> Vector2:
    var x_movement = (
        Input.get_action_strength("move_right")
        - Input.get_action_strength("move_left")
    )
    var y_movement = (
        Input.get_action_strength("move_down")
        - Input.get_action_strength("move_up")
    )

    return Vector2(x_movement, y_movement)


func check_deal_damage() -> void:
    if number_coliding_bodies == 0 || !damage_interval_timer.is_stopped():
        return

    $HealthComponent.damage(1)
    damage_interval_timer.start()
    print($HealthComponent.current_health)


func on_body_entered(_other_body: Node2D) -> void:
    number_coliding_bodies += 1
    check_deal_damage()


func on_body_exited(_other_body: Node2D) -> void:
    number_coliding_bodies -= 1


func on_damage_interval_timer_timeout() -> void:
    check_deal_damage()
