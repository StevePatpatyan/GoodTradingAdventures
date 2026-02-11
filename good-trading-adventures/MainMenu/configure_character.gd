extends Button

@onready var _log: RichTextLabel = $"../../Log"
@onready var _username_input: LineEdit = $"../../LineEdit"

func _ready() -> void:
	pressed.connect(_on_button_pressed)
	_username_input.grab_focus()

func _on_button_pressed():
	if _username_input.text.is_empty():
		_log.text += "\n[color=red]Please input a username[/color]"
		_username_input.grab_focus()
		return
	Global.username = _username_input.text
	
	Global.spritesheet = "res://sprites/" + name + ".png"
	Global.sprite_name = name
	get_tree().change_scene_to_file("res://AdventureMenu/adventure_menu.tscn")
	
	
