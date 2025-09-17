extends CanvasLayer

@onready var screen = $shopscreen

func _ready():
	screen.visible = false   # الشاشة تبدأ مخفية

func _on_shopbutton_pressed():
	screen.visible = true    # يفتح الشاشة

func _on_closebutton_pressed():
	screen.visible = false   # يقفل الشاشة
# يفتح ويقفل








func _on_oppenbutton_pressed() -> void:
	pass # Replace with function body.
