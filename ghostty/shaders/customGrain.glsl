void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    // Convert fragment coords to [0,1]
    vec2 uv = fragCoord / iResolution.xy;
    // Sample the terminal/bloom pass
    vec4 color = texture(iChannel0, uv);

    // 1) Slow down the flicker by reducing the multiplier on iTime
    float noiseVal = fract(
        sin(dot(fragCoord.xy + iTime * 10.0, vec2(12.9898, 78.233)))
        * 43758.5453
    );

    // 2) Lower grain intensity for a subtler effect
    float grainIntensity = 0.15;

    // 3) Use a dark gray (0.2) for a very subtle noise color
    color.rgb = mix(color.rgb, vec3(0.2), noiseVal * grainIntensity);

    // 4) Clamp final color to [0,1] and output
    fragColor = clamp(color, 0.0, 1.0);
}
