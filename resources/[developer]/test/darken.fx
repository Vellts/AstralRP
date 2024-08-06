struct VS_OUTPUT {
    float4 Position : POSITION;
    float2 TexCoord : TEXCOORD0;
};

VS_OUTPUT vs_main(float4 Position : POSITION, float2 TexCoord : TEXCOORD0) {
    VS_OUTPUT output;
    output.Position = Position;
    output.TexCoord = TexCoord;
    return output;
}

// Pixel shader
sampler2D Sampler0 : register(s0);

float4 ps_main(float2 TexCoord : TEXCOORD0) : COLOR {
    float4 color = tex2D(Sampler0, TexCoord);
    // Ajusta este valor para cambiar la oscuridad
    float darknessFactor = 0.5; // 0.5 sería un 50% más oscuro
    color.rgb *= darknessFactor;
    return color;
}

technique Darken {
    pass P0 {
        VertexShader = compile vs_2_0 vs_main();
        PixelShader = compile ps_2_0 ps_main();
    }
}