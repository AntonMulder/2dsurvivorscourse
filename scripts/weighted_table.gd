class_name WeightedTable

var items: Array = []
var weight_sum: int = 0


func add_item(item: Object, weight: int) -> void:
    items.append({"item": item, "weight": weight})
    weight_sum += weight


func pick_item(exclude: Array = []) -> Object:
    var adjusted_items: Array = items
    var adjusted_weight_sum: int = weight_sum
    if exclude.size() > 0:
        adjusted_items = []
        adjusted_weight_sum = 0
        for item in items:
            if item["item"] in exclude:
                continue
            adjusted_items.append(item)
            adjusted_weight_sum += item["weight"]

    var chosen_weight: int = randi_range(1, adjusted_weight_sum)
    var iteration_sum: int = 0
    for item in adjusted_items:
        iteration_sum += item["weight"]
        if chosen_weight <= iteration_sum:
            return item["item"]
    return null


func remove_item(item_to_remove) -> void:
    items = items.filter(
        func(item) -> bool: return item["item"] != item_to_remove
    )
    weight_sum = 0
    for item in items:
        weight_sum += item["weight"]
