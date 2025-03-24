void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    // Convert to [0,1] coordinate space
    vec2 uv = fragCoord / iResolution.xy;

    // Sample the base color, which includes RGBA
    vec4 baseColor = texture(iChannel0, uv);

    // Simple bloom logic
    float bloom = 0.05;
    vec3 glow = vec3(0.0);

    // Offsets for sampling
    for(float i = 0.0; i < 4.0; i++) {
        vec2 offset = vec2(i) / iResolution.xy;
        glow += texture(iChannel0, uv + offset).rgb;
        glow += texture(iChannel0, uv - offset).rgb;
    }

    // Add bloom glow to the original color
    baseColor.rgb += glow * bloom;

    // Preserve the original alpha channel rather than forcing 1.0
    fragColor = baseColor;
}
