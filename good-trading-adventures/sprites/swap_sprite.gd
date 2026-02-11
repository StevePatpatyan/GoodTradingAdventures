extends AnimatedSprite2D

func swap_textures(p_texture : Texture2D) -> void:
	for anim_name in sprite_frames.get_animation_names():
		for i in sprite_frames.get_frame_count(anim_name):
			var texture : AtlasTexture = sprite_frames.get_frame_texture(anim_name, i)
			texture.atlas = p_texture
