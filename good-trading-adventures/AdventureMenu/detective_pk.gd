extends Button

func _ready():
	
	# Connect the "pressed" signal to the "_on_button_pressed" function in this script
	pressed.connect(_on_button_pressed)

func _on_button_pressed():
	get_tree().change_scene_to_file("res://DetectivePK/detective_pk.tscn")
	
