
extends Node

@onready var shop_ui = $ShopUI   # غيّر المسار حسب مكان الـ UI عندك

func _input(event):
	if event.is_action_pressed("interact"): # زر E
		shop_ui.visible = !shop_ui.visible
