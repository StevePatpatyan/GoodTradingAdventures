extends AudioStreamPlayer2D

var fade_tween: Tween


func fade_out(duration: float) -> void:
	# Kill any existing fade
	if fade_tween:
		fade_tween.kill()

	fade_tween = create_tween()
	fade_tween.tween_property(
		self,
		"volume_db",
		-80.0,
		duration
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)

	# Wait for fade to finish, then stop and reset volume
	fade_tween.finished.connect(func(): 
		stop()
		volume_db = 0.0
		)
	await fade_tween.finished

func fade_in(duration: float, target_db: float = 0.0) -> void:
	# Kill any existing fade
	if fade_tween:
		fade_tween.kill()

	volume_db = -80.0
	play()

	fade_tween = create_tween()
	fade_tween.tween_property(
		self,
		"volume_db",
		target_db,
		duration
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)


func set_audio(audio_path: String) -> void:
	stream = load(audio_path)
