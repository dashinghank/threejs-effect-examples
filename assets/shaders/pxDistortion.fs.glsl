// uniform float time;
// uniform float progress;
// uniform sampler2D uDataTexture;
// uniform sampler2D uTexture;


// uniform vec4 resolution;
// varying vec2 vUv;
// varying vec3 vPosition;
// float PI = 3.141592653589793238;
// void main()	{
// 	vec2 newUV = (vUv - vec2(0.5))*resolution.zw + vec2(0.5);
// 	vec4 color = texture2D(uTexture,newUV);
// 	vec4 offset = texture2D(uDataTexture,vUv);
// 	gl_FragColor = vec4(vUv,0.0,1.);
// 	gl_FragColor = vec4(offset.r,0.,0.,1.);
// 	gl_FragColor = color;
// 	gl_FragColor = texture2D(uTexture,newUV - 0.02*offset.rg);
// 	// gl_FragColor = offset;

// }

uniform float time;
float wave(float time, float freq, float amp) {
  float angle = (time+position.y)*freq;
  return sin(angle)*amp;
}
float waveNorm(float time, float freq, float amp) {
  float angle = (time+position.y)*freq;
  return -amp * freq * cos(angle);
}
void main()	{

  vec3 transformed = vec3(position);
  float freq = 3.0;
  float amp = 0.1;
  transformed.z += wave(time,freq,amp);
  wave(time,freq*2.0,amp/2.0);
  wave(time,freq*3.5,amp*0.2);
    
  float normWave = waveNorm(time,freq,amp);
  waveNorm(time,freq*2.0,amp/2.0);
  waveNorm(time,freq*3.5,amp*0.2);
  objectNormal = normalize(vec3(0.0, normWave,1.0));
  gl_Position =transformed;
}