extends Button

@onready
var random_stream_player: RandomStreamPlayerComponent = $RandomStreamPlayerComponent


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pressed.connect(on_pressed)


func on_pressed() -> void:
    random_stream_player.play_random()
