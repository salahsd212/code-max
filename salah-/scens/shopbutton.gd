extends Control

# غير المسار تحت على حسب مكان الـ Screen عندك
@onready var screen = $CanvasLayer/shopscreen
@onready var open_button = $shopbutton
@onready var close_button = $CloseButton

func _ready():
	# توصيل الأزرار بالدوال
	open_button.pressed.connect(_on_open_pressed)
	close_button.pressed.connect(_on_close_pressed)
	
	# نخلي الشاشة مقفولة في الأول
	screen.visible = false

func _on_open_pressed():
	screen.visible = true

func _on_close_pressed():
	screen.visible = false
