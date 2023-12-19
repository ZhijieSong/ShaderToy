 // 绘制背景网格
 vec3 grid(in vec2 uv)
 {
    vec3 col = vec3(0.);
    vec2 cell = fract(uv);
    if(abs(cell.x) < fwidth(uv.x) || abs(cell.y) < fwidth(uv.y))
    {
        col = vec3(1., 1., 1.);
    }


    // fwidth 返回相邻像素间在屏幕上距离的差值
    if(abs(uv.y) < fwidth(uv.y) || abs(uv.x) < fwidth(uv.x))
    {
        col = vec3(1., 0.,0.);
    }
    return col;
 }

vec2 fixUV(in vec2 c)
{
   return 3.*(2.*c - iResolution.xy) / min(iResolution.x, iResolution.y);
}

// 绘制线段
 float segment(in vec2 p, in vec2 a, in vec2 b, in float w )
 {
    vec2 ba = b - a;
    vec2 pa = p - a;
    float proj = clamp(dot(pa, ba) / dot(ba,ba), 0.,1.);
    float d = length(proj * ba - pa);

    float f= 0.;
    if(d <= w)
    {
        f = 1.;
    }
    return f;
 }

// 返回
float funcSin(in float x)
{
   // 周期
   float T =  sin(iTime/2.) * 0.25 + 0.75;
   return sin(2. * 3.141592653/ T * x);
}

// 绘制图像
float funcPlot(in vec2 uv)
{
   float f = 0.;
   for(float x = 0.; x <= iResolution.x; x += 1.)
   {
      float fx = fixUV(vec2(x, 0.)).x ;
      float nfx = fixUV(vec2(x+1., 0.)).x;
      f += segment(uv, vec2(fx, funcSin(fx)), vec2(nfx, funcSin(nfx)), fwidth(uv.x));
   }

   return clamp(f, 0., 1.);
}



 void mainImage(out vec4 fragColor, in vec2 fragCoord)
 {
    vec2 uv = 3. * (2. * fragCoord.xy - iResolution.xy) / min(iResolution.x, iResolution.y);

    vec3 color = grid(uv);

   //  col += vec3(segment(uv, vec2(1.,2.), vec2(-2.,-2.), fwidth(uv.x)));
     
    color += mix(color, vec3(1.,0.,1.), funcPlot(uv));
    fragColor = vec4(color, 1.);

 }