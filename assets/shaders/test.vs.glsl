uniform float time;
uniform float uFrequency;

varying float shadowFactor;
varying float vDistance;
varying vec2 vUv;
void main()
{

    vUv = uv;
    vec3 transformed = vec3(position);
    float dx = position.x;
    float dy = position.y;
    float freq = sqrt(dx*dx + dy*dy);
    float amp = 0.3;
    float angle = -time*5.0+freq*3.0;
    transformed.z += sin(angle)*amp;
    shadowFactor = transformed.z + 1.0;
    vDistance = freq;
    gl_Position = projectionMatrix * viewMatrix * modelMatrix * vec4(transformed, 1.0);
}