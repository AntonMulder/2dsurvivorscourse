class_name OptionsMenu extends CanvasLayer

signal back_pressed

@onready var window_button: Button = $%WindowButton
@onready var music_slider: HSlider = $%MusicSlider
@onready var sfx_slider: HSlider = $%SfxSlider
@onready var back_button: Button = $%BackButton


func _ready() -> void:
    window_button.pressed.connect(on_window_button_pressed)
    sfx_slider.value_changed.connect(on_audio_slider_changed.bind("sfx"))
    music_slider.value_changed.connect(on_audio_slider_changed.bind("music"))
    back_button.pressed.connect(on_back_button_pressed)
    update_display()


func update_display() -> void:
    if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
        window_button.text = "Windowed"
    else:
        window_button.text = "Fullscreen"
    sfx_slider.value = get_bus_volume_percent("sfx")
    music_slider.value = get_bus_volume_percent("music")


func on_window_button_pressed() -> void:
    var mode: int = DisplayServer.window_get_mode()
    if mode != DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN:
        DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
    else:
        DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
    update_display()


func get_bus_volume_percent(bus_name: String) -> float:
    var bus_index: int = AudioServer.get_bus_index(bus_name)
    var volume_db: float = AudioServer.get_bus_volume_db(bus_index)
    return db_to_linear(volume_db)


func set_bus_volume_percent(bus_name: String, percent: float) -> void:
    var bus_index: int = AudioServer.get_bus_index(bus_name)
    var volume_db: float = linear_to_db(percent)
    AudioServer.set_bus_volume_db(bus_index, volume_db)


func on_audio_slider_changed(value: float, bus_name: String) -> void:
    set_bus_volume_percent(bus_name, value)


func on_back_button_pressed() -> void:
    ScreenTransition.transition()
    await ScreenTransition.transitioned_halfway
    back_pressed.emit()
