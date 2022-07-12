uniform float iTime;
uniform float uFrequency;


varying vec2 vUv;
varying float vTime;


void main()
{
    vTime = iTime;
    vUv = uv;
    vec3 transformed = vec3(position);
    float dx = position.x;
    float dy = position.y;
    float freq = sqrt(dx*dx + dy*dy);
    float amp = 0.3;
    float angle = -iTime*5.0+freq*3.0;
    transformed.z += sin(angle)*amp;
    gl_Position = projectionMatrix * viewMatrix * modelMatrix * vec4(position, 1.0);
}