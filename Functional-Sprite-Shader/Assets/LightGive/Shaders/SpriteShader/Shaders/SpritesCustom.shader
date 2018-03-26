Shader "LightGive/Sprites/Custom"
{
    Properties
    {
        [PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
        //[Enum(None, 0, Outline 4, 1, Outline 8, 2)] _OutlineType("OutlineType", Int) = 0
        //_OutlineColor ("OutlineColor", Color) = (1,1,1,1)
        [MaterialToggle] PixelSnap ("Pixel snap", Float) = 0
        [Toggle(PIXEL_PERFECT)] _PixelPerfect ("PixelPerfect", Float) = 0
        _Grid ("Width", Range(1, 256)) = 16
        _WhiteColor ("WhiteColor", Range(0.0 , 1.0)) = 0
    }
 
    SubShader
    {
        Tags
        { 
            "Queue"="Transparent" 
            "IgnoreProjector"="True" 
            "RenderType"="Transparent" 
            "PreviewType"="Plane"
            "CanUseSpriteAtlas"="True"
        }
 
        Cull Off
        Lighting Off
        ZWrite Off
        Blend One OneMinusSrcAlpha
 
        Pass
        {
        CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile _ PIXELSNAP_ON PIXEL_PERFECT
            #include "UnityCG.cginc"
            
            struct appdata_t
            {
                float4 vertex   : POSITION;
                float4 color    : COLOR;
                float2 texcoord : TEXCOORD0;
            };
 
            struct v2f
            {
                float4 vertex   : SV_POSITION;
                fixed4 color    : COLOR;
                float2 texcoord  : TEXCOORD0;
            };
            
            fixed4 _Color;
            float _Grid;
 
            v2f vert(appdata_t IN)
            {
                v2f OUT;

                #ifdef PIXEL_PERFECT

                //PixelPerfectにチェックがある時
                OUT.vertex = mul(UNITY_MATRIX_M, IN.vertex);
                OUT.vertex = floor(OUT.vertex * _Grid) / _Grid;
                OUT.vertex = mul(UNITY_MATRIX_VP, OUT.vertex);
                #else

                //PixelPerfectにチェックがない時
                OUT.vertex = UnityObjectToClipPos(IN.vertex);
                #endif

                OUT.texcoord = IN.texcoord;
                OUT.color = IN.color;
                #ifdef PIXELSNAP_ON
                OUT.vertex = UnityPixelSnap (OUT.vertex);
                #endif
 
                return OUT;
            } 
 
            sampler2D _MainTex;
            sampler2D _AlphaTex;
            float _WhiteColor;

            fixed4 frag(v2f IN) : SV_Target
            {
                fixed4 c = tex2D(_MainTex,IN.texcoord);
                c.rgb = saturate((IN.color.rgb * c.rgb) + _WhiteColor);
                c.a = IN.color.a * c.a;
                c.rgb *= c.a;
                return c;
            }
        ENDCG
        }
    }
}