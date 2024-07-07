extends Node


var inventory: Array = [
]
var hotbar: Array = []
var c_hbar_slot: Dictionary = {
	"slot" : 0,
	"item" : {
		
	}
}
var c_hbar_item: Dictionary = {}


func remove_0stacks() -> void:
	for i: int in len(inventory):
		if i < len(inventory):
			if inventory[i]["count"] <= 0:
				inventory.remove_at(i)
	if c_hbar_slot["item"] != {}:
		if c_hbar_slot["item"]["count"] == 0:
			c_hbar_slot["item"] = {}


func add_inventory_item(item: String, count: int) -> void:
	var found: bool = false
	for i: int in len(inventory):
		if inventory[i]['item'] == item && inventory[i]['count'] < 100:
			found = true
			inventory[i]['count'] += count
	if not found:
		inventory.append({
			"item": item,
			"count": count
		})


func remove_inventory_item(item: String, count: int) -> void:
	for i: int in len(inventory):
		if inventory[i]['item'] == item && inventory[i]['count'] > 0:
			inventory[i]['count'] -= count


func inventory_has_item(item: String, count: int) -> bool:
	var found: bool = false
	for i: int in len(inventory):
		if count > 0:
			if inventory[i]['item'] == item && inventory[i]['count'] >= count:
				found = true
				break
			else:
				found = false
		elif count <= 0:
			if inventory[i]['item'] == item:
				found = true
				break
			else:
				found = false
	return found
