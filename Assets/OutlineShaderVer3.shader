Shader "CustomShaders/OutlineShaderVer3"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
		_OutlineColor ("Outline Color", Color) = (1,0,0,1)
		_Outline("Outline Width", Range(.002, 1)) = .005
    }
	
    SubShader
    {
        CGPROGRAM

        #pragma surface surf Lambert

        struct Input
        {
            float2 uv_MainTex;
        };

		sampler2D _MainTex;

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb;
        }

        ENDCG

		Cull Front
		CGPROGRAM
		
        #pragma surface surf Lambert vertex:vert

        struct Input
        {
            float2 uv_MainTex;
        };

		float4 _OutlineColor;
		float _Outline;

		void vert(inout appdata_full v)
		{
			v.vertex.xyz += v.normal * _Outline;
		}

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = _OutlineColor.rgb;
        }

        ENDCG
    }

    FallBack "Diffuse"
}