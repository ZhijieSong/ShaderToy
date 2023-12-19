// 绘制网格
vec3 grid(vec2 uv)
{
    vec3 color = vec3(0.);
    vec2 cell = fract(uv);// fract 返回变量的小数部分

    // 绘制格子
    if(abs(cell.x) < fwidth(uv.x) || abs(cell.y) < fwidth(uv.y))
    {
        color = vec3(1.,1.,1.);
    }
    else{
        color = vec3(cell.x, cell.y, cell.y);
    }


    // 绘制坐标轴
    // fwidth 返回相邻像素间在屏幕上距离的差值
    // fwidth(uv.y) 表示纵坐标像素与像素间最小值
    // fheight(uv.x) 表示横坐标像素宽度
    if(abs(uv.y) < fwidth(uv.y) || abs(uv.x) < fwidth(uv.x))
    {
        color = vec3(1., 0.,0.);
    }

    return color;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{

    // 屏幕空间转换到 (-3,3)
    vec2 uv = 3. *(2.* fragCoord.xy - iResolution.xy) / min(iResolution.x , iResolution.y);

    vec3 color = grid(uv);

    fragColor = vec4(color, 1.);
}