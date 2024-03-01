shader_type canvas_item;

uniform bool active = false;

void fragment() {
	vec4 previusColor = texture(TEXTURE, UV);
	vec4 white = vec4(1.0, 1.0, 1.0, previusColor.a);
	COLOR = white;
}
