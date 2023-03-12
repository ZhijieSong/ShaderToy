void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 uv = (2.0 * fragCoord - iResolution.xy) / min(iResolution.xx, iResolution.yy) ;
    float circle = length(uv);
    float r = 0.5;
    if(circle > r)
    {
        circle = 1.;
    }
    fragColor = vec4(vec3(circle),1);
}