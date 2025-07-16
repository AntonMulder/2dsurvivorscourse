class_name PauseMenu extends CanvasLayer

var is_closing: bool = false
var options_menu_scene: PackedScene = preload(
    "res://scenes/ui/options_menu.tscn"
)

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var panel_container: PanelContainer = %PanelContainer
@onready var resume_button: Button = %ResumeButton
@onready var options_button: Button = %OptionsButton
@onready var quit_button: Button = %QuitButton


func _ready() -> void:
    resume_button.pressed.connect(on_resume_pressed)
    options_button.pressed.connect(on_options_pressed)
    quit_button.pressed.connect(on_quit_pressed)

    get_tree().paused = true

    panel_container.pivot_offset = panel_container.size / 2

    animation_player.play("default")

    var tween: Tween = create_tween()
    tween.tween_property(panel_container, "scale", Vector2.ZERO, 0)
    (
        tween
        . tween_property(panel_container, "scale", Vector2.ONE, .3)
        . set_ease(Tween.EASE_OUT)
        . set_trans(Tween.TRANS_BACK)
    )


func on_resume_pressed() -> void:
    close()


func on_options_pressed() -> void:
    ScreenTransition.transition()
    await ScreenTransition.transitioned_halfway
    var options_menu_instance: OptionsMenu = options_menu_scene.instantiate()
    add_child(options_menu_instance)
    options_menu_instance.back_pressed.connect(
        on_options_back_pressed.bind(options_menu_instance)
    )


func on_quit_pressed() -> void:
    get_tree().paused = false
    get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")


func on_options_back_pressed(options_menu: OptionsMenu) -> void:
    options_menu.queue_free()


func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("Pause"):
        get_tree().root.set_input_as_handled()
        close()


func close() -> void:
    if is_closing:
        return

    is_closing = true

    animation_player.play_backwards("default")

    var tween: Tween = create_tween()
    tween.tween_property(panel_container, "scale", Vector2.ONE, 0)
    (
        tween
        . tween_property(panel_container, "scale", Vector2.ZERO, .3)
        . set_ease(Tween.EASE_IN)
        . set_trans(Tween.TRANS_BACK)
    )

    await tween.finished
    get_tree().paused = false

    queue_free()
