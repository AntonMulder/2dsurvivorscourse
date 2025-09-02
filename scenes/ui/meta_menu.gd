class_name MetaMenu extends CanvasLayer

@export var upgrades: Array[MetaUpgrade] = []

var meta_upgrade_card_scene: PackedScene = preload(
    "res://scenes/ui/meta_upgrade_card.tscn"
)

@onready var grid_container = $%GridContainer


func _ready() -> void:
    for upgrade: MetaUpgrade in upgrades:
        var meta_upgrade_card_instance: MetaUpgradeCard = (
            meta_upgrade_card_scene.instantiate()
        )
        grid_container.add_child(meta_upgrade_card_instance)
        meta_upgrade_card_instance.set_meta_upgrade(upgrade)
