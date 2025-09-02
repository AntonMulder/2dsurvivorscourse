class_name MetaUpgradeCard extends PanelContainer

var upgrade: MetaUpgrade

@onready var name_label: Label = $%NameLabel
@onready var description_label: Label = $%DescriptionLabel
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var progress_bar: ProgressBar = $%ProgressBar
@onready var purchasse_button: Button = $%PurchaseButton
@onready var progress_label: Label = $%ProgressLabel


func _ready() -> void:
    purchasse_button.pressed.connect(on_purchase_pressed)


func select_card() -> void:
    animation_player.play("selected")


func set_meta_upgrade(upgrade: MetaUpgrade) -> void:
    self.upgrade = upgrade
    name_label.text = upgrade.name
    description_label.text = upgrade.description
    update_progress()


func update_progress() -> void:
    var currency: int = MetaProgression.save_data["meta_upgrade_currency"]
    var percent: float = float(currency) / upgrade.experience_cost
    percent = min(1, percent)
    progress_bar.value = percent
    purchasse_button.disabled = percent < 1
    progress_label.text = str(currency) + "/" + str(upgrade.experience_cost)


func on_purchase_pressed() -> void:
    if upgrade == null:
        return
    MetaProgression.add_meta_upgrade(upgrade)
    MetaProgression.save_data["meta_upgrade_currency"] -= (
        upgrade.experience_cost
    )
    MetaProgression.save()
    get_tree().call_group("meta_upgrade_card", "update_progress")
    animation_player.play("selected")
