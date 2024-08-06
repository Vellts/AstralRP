
float4 ClearMe() : COLOR0
{	
    return 0;	
}

technique ClearTexture
{
    pass p0
    {
		AlphaBlendEnable = FALSE;
        PixelShader = compile ps_2_0 ClearMe();
    }
}

technique fallback
{
    pass P0
    {
    }
}