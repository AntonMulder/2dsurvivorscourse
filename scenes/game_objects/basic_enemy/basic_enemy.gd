class_name BasicEnemey extends CharacterBody2D

const MAX_SPEED: int = 40

@onready var visuals: Node2D = $Visuals
@onready var velocity_component: VelocityComponent = $VelocityComponent
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent


func _ready() -> void:
    hurtbox_component.hit.connect(on_hit)


func _process(_delta: float) -> void:
    velocity_component.accelerate_to_player()
    velocity_component.move(self)

    var move_sign: float = sign(velocity.x)
    if move_sign != 0:
        visuals.scale = Vector2(-move_sign, 1)


func on_hit() -> void:
    $HitRandomAudioPlayerComponent.play_random()
