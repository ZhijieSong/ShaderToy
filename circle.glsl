void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    // fragCoord 表示像素坐标
    // iResolution为渲染窗口分辨率
    // fragCoord / iResolution.xy 即为将像素坐标转换到(0,1)空间
    // 下面的代码表示将 fragCoord转换到(-1,1)空间， min函数用于保证长宽比一致
    vec2 uv = (2.0 * fragCoord - iResolution.xy) / min(iResolution.xx, iResolution.yy) ;
    float circle = length(uv) ; // uv 到屏幕中心点的长度
    float r = 0.5;
    if(circle > r)
    {
        circle = 1.;
    }
    fragColor = vec4(vec3(circle),1);
}