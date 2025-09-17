extends Node

@onready var shop_ui = $ShopUI

func _input(event):
	if event.is_action_pressed("interact"): # زر E
		if shop_ui.visible:
			shop_ui.hide()
		else:
			shop_ui.show()
