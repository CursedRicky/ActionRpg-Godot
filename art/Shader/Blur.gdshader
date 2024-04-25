shader_type canvas_item;

//uniform sampler2D SCREEN_TEXTURE : hint_screen_texture;
uniform vec2 blur_amount = vec2(0.01, 0.01);
uniform vec2 focus_point = vec2(0.5, 0.5);
uniform float focus_radius = 0.1f;

void fragment(){
	vec4 color = texture(TEXTURE, UV);
	vec4 color_up = texture(TEXTURE, UV + vec2(0.0, blur_amount.y));
	vec4 color_down = texture(TEXTURE, UV + vec2(0.0, -blur_amount.y));
	vec4 color_left = texture(TEXTURE, UV + vec2(-blur_amount.x, 0.0));
	vec4 color_right = texture(TEXTURE, UV + vec2(blur_amount.x, 0.0));
	
	COLOR = (color_up + color_down + color_left + color_right) /4.0;
}