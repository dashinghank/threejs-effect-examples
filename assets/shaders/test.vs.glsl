uniform float time;
uniform float uFrequency;

varying float shadowFactor;

void main()
{
    vec4 modelPosition = modelMatrix * vec4(position, 1.0);
    modelPosition.z += sin(modelPosition.x * uFrequency + time) * 0.3;
    vec4 viewPosition = viewMatrix * modelPosition;
    vec4 projectedPosition = projectionMatrix * viewPosition;
    
    shadowFactor = ((modelPosition.z + 1.0) * 1.8) /2.0;

    gl_Position = projectedPosition;
}