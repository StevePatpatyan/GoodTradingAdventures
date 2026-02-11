extends Camera2D

# Configurable parameters
@export var random_strength: float = 30.0 # Initial strength
@export var shake_decay: float = 5.0      # How fast it fades (higher = faster)

var shake_strength: float = 0.0
var camera_pos: Vector2

func _ready() -> void:
	randomize()
	camera_pos = offset # Store default position

func _process(delta: float) -> void:
	# Gradually decrease shake strength
	shake_strength = lerp(shake_strength, 0.0, shake_decay * delta)
	
	# Apply shake using random values
	if shake_strength > 0.0:
		offset = Vector2(
			randf_range(-shake_strength, shake_strength),
			randf_range(-shake_strength, shake_strength)
		)
	else:
		offset = Vector2.ZERO # Reset to zero when done

# Call this function from other scripts to trigger shake
func apply_shake(strength: float = random_strength) -> void:
	var sfx: AudioStreamPlayer2D = get_node("../SoundEffectAudio")
	sfx.stream = preload("res://audio/thud.wav")
	shake_strength = strength
