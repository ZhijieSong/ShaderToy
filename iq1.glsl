
#define MAX_SPEPS  100
#define MAX_DIST 100.
#define SURF_DIST .01

float sdfSphere(vec3 p){
    vec3 center = vec3(0, 1, 10);
    float radius = 1.;
    float sphereDist = length(p - center) - radius;
    float planDist = p.y;
    return min(sphereDist, planDist);
}

float rayMarch(vec3 ro, vec3 rd) {
    float dO = 0.;
    for(int i = 0; i < MAX_SPEPS; ++i) {
        vec3 p = ro + rd * dO;
        float ds = sdfSphere(p);
        dO += ds;
        if(dO > MAX_DIST || dO < SURF_DIST){
            break;
        }
    }

    return dO;
}

vec3 getNormal(vec3 p) {
    float d = sdfSphere(p);
    vec2 e = vec2(.01, 0);
    vec3 n = vec3(sdfSphere(p + e.xyy) - sdfSphere(p - e.xyy), 
        sdfSphere(p + e.yxy) - sdfSphere(p-e.yxy),
        sdfSphere(p + e.yyx) - sdfSphere(p-e.yyx));
    return normalize(n);
    
}

float getLight(vec3 p) {
    vec3 lightPos = vec3(0, 5, 6);

    lightPos.xy += vec2(sin(iTime), cos(iTime)*2.)*2.;

    vec3 l = normalize(lightPos - p)  ;
    vec3 n = getNormal(p);
    float dif = dot(n, l);

    float d = rayMarch(p + n* SURF_DIST * 2., l);
    if(d < length(lightPos - p)) dif *= 0.1;

    return dif;
}



void mainImage(out vec4 fragColor, in vec2 fragCoord) {

    vec2 uv = (fragCoord - iResolution.xy * .5) / min(iResolution.x, iResolution.y);
    vec3 col = vec3(0.);

    vec3 ro = vec3(0, 1, 0);
    vec3 rd = normalize(vec3(uv.x, uv.y, 1));

    float d = rayMarch(ro, rd);

    vec3 p = ro + d * rd;
    float dif = getLight(p);

    // col = vec3(d / 10.);
    col = vec3(dif);

    fragColor = vec4(col, 1.);
}