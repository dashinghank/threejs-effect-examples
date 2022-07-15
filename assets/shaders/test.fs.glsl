precision mediump float;
varying vec4 vModelPosition;

uniform sampler2D dTexture;
uniform sampler2D uTexture;
varying vec2 vUv;
uniform vec4 resolution;
uniform float aspect;
uniform float uDim;

void main()
{
  // aspect為螢幕比例, 這裡的算法是該點先往左上退整張圖的一半, 在依長寬比例回縮, 最後再回歸位置
    // vec2 newUV = (vUv - vec2(0.5))*(1.5/1.0) + vec2(0.5);
	  vec4 offset = texture2D(dTexture ,vUv);
    offset = offset*vec4(uDim,uDim,uDim,offset.a);
    gl_FragColor = texture2D(uTexture,vUv);
    gl_FragColor = texture2D(uTexture,vUv - 0.1 * offset.rg);
    
}