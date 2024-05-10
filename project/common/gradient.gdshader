shader_type canvas_item;

uniform vec4 topleft:source_color = vec4(0.8, 0.6, 0.6, 1);
uniform vec4 topright:source_color = vec4(0.8, 0.6, 0.6, 1);
uniform vec4 bottomleft:source_color = vec4(1, 0.7, 1, 1);
uniform vec4 bottomright:source_color = vec4(1, 0.7, 1, 1);

void fragment() {
	vec4 top = mix(topleft, topright, UV.x);
	vec4 bottom = mix(bottomleft, bottomright, UV.x);
	COLOR =  mix(top, bottom, UV.y);
}
