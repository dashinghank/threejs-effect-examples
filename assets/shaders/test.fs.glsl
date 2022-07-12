precision mediump float;
varying float shadowFactor;



void main()
{
    gl_FragColor = vec4(shadowFactor, 0.0, 0.0, 1.0);
    
}