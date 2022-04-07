Shader "Unlit/NewUnlitShader"
{
    Properties
    {
        _MainTex ("Render Texture", 2D) = "white" {}
        _Min("min", Float) = 0.5
        _Max("min", Float) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        ZWrite Off
        Blend SrcAlpha OneMinusSrcAlpha
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            float _Min;
            float _Max;


            float invLerp(float from, float to, float value) {
                return (value - from) / (to - from);
            }

            float remap(float origFrom, float origTo, float targetFrom, float targetTo, float value) {
                float rel = invLerp(origFrom, origTo, value);
                return lerp(targetFrom, targetTo, rel);
            }

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                // sample the texture

                float h = _Min;

                float yValueColor = remap(-1, 1, h, _Max, i.uv.y);
                float yValueMask = remap(-1, 1, 0, 1, i.uv.y);
                fixed4 mask = tex2D(_MainTex, float2(i.uv.x, yValueMask));
                fixed4 col = tex2D(_MainTex, float2(i.uv.x, yValueColor));
                col.a = mask.r;
                return col;
            }
            ENDCG
        }
    }
}
