shader_type canvas_item;

uniform sampler2D noise : repeat_enable;
const float speed = 0.05;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform float distortionStrenght : hint_range(-1,1) = 0.2;

void fragment() {
	vec2 newUv = vec2(UV.x + TIME * speed, UV.y + TIME * speed);
	vec4 noise_col = texture(noise, newUv);
	vec4 screen_col = texture(SCREEN_TEXTURE, SCREEN_UV + distortionStrenght * noise_col.rr);
	COLOR = screen_col;
}
