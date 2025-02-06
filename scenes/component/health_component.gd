class_name HealthComponent extends Node

signal died
signal health_changed

@export var max_health: float = 10

var current_health: float


func _ready() -> void:
    current_health = max_health


func damage(damage_amount: float) -> void:
    current_health -= damage_amount
    health_changed.emit()
    Callable(check_health).call_deferred()


func get_health_percent() -> float:
    if max_health <= 0:
        return 0
    return min(current_health / max_health, 1)


func check_health() -> void:
    if current_health <= 0:
        died.emit()
        owner.queue_free()
