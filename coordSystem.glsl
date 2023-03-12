// 绘制网格
vec3 grid(vec2 uv)
{
    vec3 col = vec3(0.);
    vec2 cell = fract(uv);// fract 返回变量的小数部分
    if(abs(cell.x) < fwidth(uv.x) || abs(cell.y) < fwidth(uv.y))
    {
        col = vec3(1.,1.,1.);
    }


    // fwidth 返回相邻像素间在屏幕上距离的差值
    if(abs(uv.y) < fwidth(uv.y) || abs(uv.x) < fwidth(uv.x))
    {
        col = vec3(1., 0.,0.);
    }

    return col;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{

    vec2 uv = 3. *(2.* fragCoord.xy - iResolution.xy) / min(iResolution.x , iResolution.y);

    vec3 color = grid(uv);

    fragColor = vec4(color, 1.);
}