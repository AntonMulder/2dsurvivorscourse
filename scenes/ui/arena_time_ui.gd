class_name ArenaTimeUI extends CanvasLayer

@export var arena_time_manager: ArenaTimeMagner

@onready var label: Label = $MarginContainer/Label


func _process(_delta: float) -> void:
    if arena_time_manager == null:
        return
    var time_elapsed: float = arena_time_manager.get_time_elapsed()

    label.text = format_seconds_to_string(time_elapsed)


func format_seconds_to_string(seconds: float) -> String:
    var minutes: int = floor(seconds / 60)
    var remaining_seconds: int = floor(seconds - (minutes * 60))

    return str(minutes) + ":" + ("%02d" % remaining_seconds)
