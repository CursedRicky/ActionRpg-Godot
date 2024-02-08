shader_type canvas_item;

uniform sampler2D noise1 : repeat_enable;
uniform sampler2D noise2 : repeat_enable;
uniform vec2 scroll1 = vec2(0.05, 0.05);
uniform vec2 scroll2 = vec2(-0.05, -0.05);
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform float distortion : hint_range(-1,1) = 0.2;
uniform vec4 color : source_color;
uniform vec4 topColor : source_color;
uniform float lightStart : hint_range(0.0, 1.0) = 0.275;
uniform float lightEnd : hint_range(0.0, 1.0) = 0.4;
//const float speed = 0.05;
//uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
//uniform float distortionStrenght : hint_range(-1,1) = 0.2;

void fragment() {
	float depth = texture(noise1, UV + scroll1 * TIME).r
		* texture(noise2, UV + scroll2 * TIME).r;
	vec4 screenCol = texture(SCREEN_TEXTURE,
		SCREEN_UV + distortion * vec2(depth));
	vec4 topLight = smoothstep(lightStart, lightEnd, depth) * topColor;
	COLOR = screenCol * color + topLight;
	COLOR.a = 1.0;
	//vec2 newUv = vec2(UV.x + TIME * speed, UV.y + TIME * speed);
	//vec4 noise_col = texture(noise, newUv);
	//vec4 screen_col = texture(SCREEN_TEXTURE, SCREEN_UV + distortionStrenght * noise_col.rr);
	//COLOR = screen_col;
}
