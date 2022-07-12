// uniform mat4 projectionMatrix;
// uniform mat4 viewMatrix;
// uniform mat4 modelMatrix;

// attribute vec3 position;
uniform float time;

void main()
{
    vec3 transformed = vec3(position);
    float dx = position.x;
    float dy = position.y;
    float freq = sqrt(dx*dx + dy*dy);
    float amp = 0.1;
    float angle = -time*10.0+freq*6.0;
    transformed.z += sin(angle)*amp;

    gl_Position = projectionMatrix * viewMatrix * modelMatrix * vec4(transformed, 1.0);
}