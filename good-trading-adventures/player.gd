extends CharacterBody2D

@onready var player_sprite: AnimatedSprite2D
@onready var interaction_hitbox: Area2D = $InteractionHitbox
@onready var camera: Camera2D = $Camera2D
@onready var background_audio: AudioStreamPlayer2D = $BackgroundAudio
@onready var sfx_audio: AudioStreamPlayer2D = $SoundEffectAudio
@onready var input_prompt: LineEdit = $"Control/InputPrompt"

@export var speed: float = 100
var interacting: bool = false

var player_input: String # used to assign the value of get_player_input to this variable for use in the dialogue files



func _ready() -> void:
	# instantiate the selected player sprite
	player_sprite = preload("res://sprites/character_sprite.tscn") \
	.instantiate()
	if Global.spritesheet != "res://sprites/Alex.png":
		var replacement_spritesheet: Texture2D = load(Global.spritesheet)
		player_sprite.swap_textures(replacement_spritesheet)
	
	add_child(player_sprite)
	player_sprite = get_node("AnimatedSprite2D")
	player_sprite.play("idle_down")
	
	DialogueManager.dialogue_started.connect(func(_resource: DialogueResource): interacting = true)
	DialogueManager.dialogue_ended.connect(func(_resource:DialogueResource): interacting = false)
	Global.cutscene_started.connect(func(): interacting = true)
	Global.cutscene_ended.connect(func(): interacting = false)
	interaction_hitbox.area_entered.connect(get_node("../..").on_player_interaction_area_entered)
	
	
func _physics_process(_delta: float) -> void:
	if interacting:
		velocity = Vector2.ZERO
	else:
		velocity = Input.get_vector("move_left","move_right","move_up","move_down") * speed
	
	if velocity.x != 0:
		if velocity.x > 0:
			player_sprite.play("walk_right")
		else:
			player_sprite.play("walk_left")
			
	elif velocity.y != 0:
		if velocity.y > 0:
			player_sprite.play("walk_down")
		else:
			player_sprite.play("walk_up")

	elif velocity == Vector2.ZERO and player_sprite.animation.begins_with("walk"):
		if player_sprite.animation == "walk_right":
			player_sprite.play("idle_right")
		elif player_sprite.animation == "walk_left":
			player_sprite.play("idle_left")
		elif player_sprite.animation == "walk_down":
			player_sprite.play("idle_down")
		else:
			player_sprite.play("idle_up")
	
	move_and_slide()
	
	
func _input(event: InputEvent) -> void:
	get_node("../..").on_player_input(event)

# get text input from player
func get_player_input(prompt: String = "") -> String:
	input_prompt.placeholder_text = prompt
	input_prompt.visible = true
	input_prompt.text = ""
	input_prompt.grab_focus()

	var result: String = await input_prompt.text_submitted

	input_prompt.visible = false
	
	return result

	
