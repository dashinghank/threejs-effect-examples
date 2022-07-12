precision mediump float;
varying float shadowFactor;
varying float vDistance;
uniform sampler2D uTexture;
varying vec2 vUv;

void main()
{
    vec4 textureColor = texture2D(uTexture, vUv);
    
    vec4 textureWithShadow = vec4(textureColor.x * shadowFactor, textureColor.y * shadowFactor, textureColor.z * shadowFactor, textureColor.w);
    gl_FragColor = textureWithShadow;   
}