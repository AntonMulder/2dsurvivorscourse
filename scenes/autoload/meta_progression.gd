extends Node

const SAVE_FILE_PATH: String = "user://game.save"

var save_data: Dictionary = {
    "meta_upgrade_currency": 0,
    "meta_upgrades": {},
}


func _ready() -> void:
    GameEvents.experience_vial_collected.connect(on_experience_vial_collected)
    load_saved_file()


func load_saved_file() -> void:
    if not FileAccess.file_exists(SAVE_FILE_PATH):
        return
    var file: FileAccess = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
    save_data = file.get_var()


func save() -> void:
    var file: FileAccess = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
    file.store_var(save_data)


func on_experience_vial_collected(number: float) -> void:
    save_data["meta_upgrade_currency"] += number
    save()


func add_meta_upgrade(upgrade: MetaUpgrade) -> void:
    if not save_data["meta_upgrades"].has(upgrade.id):
        save_data["meta_upgrades"][upgrade.id] = {"quantity": 0}
    save_data["meta_upgrades"][upgrade.id]["quantity"] += 1
    save()
