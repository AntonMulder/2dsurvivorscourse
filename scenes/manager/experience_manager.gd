class_name ExperienceManager extends Node

signal experience_updated(current_experience: float, target_experience: float)
signal level_up(new_level: int)

const TARGET_EXPERIENCE_GROWTH: int = 5

var current_experience: float = 0
var current_level: float = 1
var target_experience: float = 5


func _ready() -> void:
    GameEvents.experience_vial_collected.connect(on_experience_vial_collected)


func increment_experience(number: float) -> void:
    current_experience = min(current_experience + number, target_experience)

    if current_experience == target_experience:
        current_level += 1
        target_experience += TARGET_EXPERIENCE_GROWTH
        current_experience = 0
        level_up.emit(current_level)

    experience_updated.emit(current_experience, target_experience)


func on_experience_vial_collected(number: float) -> void:
    increment_experience(number)
