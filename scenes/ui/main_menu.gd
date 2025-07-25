class_name MainMenu extends CanvasLayer

var options_scene: PackedScene = preload("res://scenes/ui/options_menu.tscn")

@onready var play_button: Button = $%PlayButton
@onready var options_button: Button = $%OptionsButton
@onready var quit_button: Button = $%QuitButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    play_button.pressed.connect(on_play_pressed)
    options_button.pressed.connect(on_options_pressed)
    quit_button.pressed.connect(on_quit_pressed)


func on_play_pressed() -> void:
    ScreenTransition.transition()
    await ScreenTransition.transitioned_halfway
    get_tree().change_scene_to_file("res://scenes/main/main.tscn")


func on_options_pressed() -> void:
    ScreenTransition.transition()
    await ScreenTransition.transitioned_halfway
    var options_instance: OptionsMenu = options_scene.instantiate()
    add_child(options_instance)
    options_instance.back_pressed.connect(
        on_options_closed.bind(options_instance)
    )


func on_quit_pressed() -> void:
    get_tree().quit()


func on_options_closed(options_instance: OptionsMenu) -> void:
    options_instance.queue_free()
