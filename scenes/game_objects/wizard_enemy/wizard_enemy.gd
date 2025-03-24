class_name WizardEnemy extends CharacterBody2D

var is_moving: bool = false

@onready var velocity_component: VelocityComponent = $VelocityComponent
@onready var visuals: Node2D = $Visuals
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent


func _ready() -> void:
    hurtbox_component.hit.connect(on_hit)


func _process(_delta: float) -> void:
    if is_moving:
        velocity_component.accelerate_to_player()
    else:
        velocity_component.decelerate()

    velocity_component.move(self)

    var move_sign: float = sign(velocity.x)
    if move_sign != 0:
        visuals.scale = Vector2(move_sign, 1)


func set_is_moving(moving: bool) -> void:
    is_moving = moving


func on_hit() -> void:
    $HitRandomAudioPlayerComponent.play_random()
