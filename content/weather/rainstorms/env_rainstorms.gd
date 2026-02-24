extends Weather

func modify_environment(env: Environment) -> void :
    env.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
    env.ambient_light_color = Color("4b5998ff")
    env.ambient_light_energy = 0.65
    env.adjustment_enabled = true
    env.adjustment_brightness = 0.9
    env.adjustment_contrast = 0.9
    env.adjustment_saturation = 0.85
    
    env.fog_enabled = true
    env.fog_mode = Environment.FOG_MODE_DEPTH
    env.fog_light_color = Color("4b5998ff")
    env.fog_light_energy = 0.65
    env.fog_sun_scatter = 1.0
    env.fog_density = 0.1
    env.fog_sky_affect = 1
    env.fog_height = 2.0
    env.fog_height_density = -0.3
