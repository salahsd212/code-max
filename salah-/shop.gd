extends Control

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("e"): # هنا ui_accept = E لو ضفته في Input Map
		$Panel.visible = not $Panel.visible
		$Panel/AnimationPlayer.play("oppen")






func _on_close_pressed() -> void:
	$Panel.visible = false
	$Panel/AnimationPlayer.play("Close")
	pass # Replace with function body.


func _on_opppen_pressed() -> void:
	$Panel.visible = true
	$Panel/AnimationPlayer.play("oppen")
	pass # Replace with function body.
