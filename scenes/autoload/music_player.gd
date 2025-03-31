extends AudioStreamPlayer

@onready var timer: Timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    finished.connect(on_finished)
    timer.timeout.connect(on_timeout)


func on_finished() -> void:
    timer.start()


func on_timeout() -> void:
    play()
