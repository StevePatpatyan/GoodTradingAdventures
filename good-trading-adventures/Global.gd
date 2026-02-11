extends Node

var username: String
var spritesheet: String
var sprite_name: String

signal cutscene_started()
signal cutscene_ended()

# add portrait to dialogue balloon
func add_portrait(balloon_node_path: String, portrait_path: String):
	var balloon := get_node(balloon_node_path)
	var portrait: TextureRect = balloon.get_node("Balloon/MarginContainer/PanelContainer/MarginContainer/HBoxContainer/TextureRect")
	var texture = load(portrait_path)
	portrait.texture = texture

# remove existing portrait from dialogue balloon
func remove_portrait(balloon_node_path: String):
	var balloon := get_node(balloon_node_path)
	var portrait: TextureRect = balloon.get_node("Balloon/MarginContainer/PanelContainer/MarginContainer/HBoxContainer/TextureRect")
	portrait.texture = null

# make character look in the direction of the target
func character_look_at(source: CharacterBody2D, target: Node2D):
	var sprite: AnimatedSprite2D = source.get_node("AnimatedSprite2D")
	var displacement: Vector2 = target.position - source.position
	if abs(displacement.x) > abs(displacement.y):
		if displacement.x < 0: # look to left
			sprite.play("idle_left")
		else: # look to right
			sprite.play("idle_right")
	else:
		if displacement.y < 0: # look up
			sprite.play("idle_up")
		else: # look to right
			sprite.play("idle_down")

func generate_completion_certificate_text(adventure_name: String):
	var current_time = Time.get_datetime_dict_from_system()
	var year = current_time["year"]
	var month = current_time["month"]
	var day = current_time["day"]
	var hour = current_time["hour"]
	var minute = current_time["minute"]
	var second = current_time["second"]

	var cert_id: int = Time.get_unix_time_from_datetime_dict(current_time) + ord(Global.username.substr(0, 1)) + ord(adventure_name.substr(len(adventure_name) - 1, 1))

	return "[color=gold][b]Certificate of Approval: {0} at {1}-{2}-{3} {4}:{5}:{6}\nID: {7}[/b][/color]".format(
	[adventure_name,
	str(month).pad_zeros(2),
	str(day).pad_zeros(2),
	str(year).pad_zeros(4),
	str(hour).pad_zeros(2),
	str(minute).pad_zeros(2),
	str(second).pad_zeros(2),
	str(cert_id)]
)
