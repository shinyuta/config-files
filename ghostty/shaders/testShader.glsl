void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    // Ignore iChannel0 and iResolution; just paint everything solid red
    fragColor = vec4(1.0, 0.0, 0.0, 1.0);
}
