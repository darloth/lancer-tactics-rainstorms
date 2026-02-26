extends Weather

func modify_environment(env: Environment) -> void :
    env.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
    env.ambient_light_color = Color("4b5998ff")
    env.ambient_light_energy = 0.65
    env.adjustment_enabled = true
    env.adjustment_brightness = 0.9
    env.adjustment_contrast = 0.9
    env.adjustment_saturation = 0.85
    
    # Start a timer that takes a random time to timeout. 
    # When it times out, if the environment is still valid
    #   tween VERY fast to bright
    #   chained tween back to normal slower
    #   chained start the timer again.
    
    # If we only hold weak references to the environment resource in the timer and tweens it should be fine.
    
    env.fog_enabled = true
    env.fog_mode = Environment.FOG_MODE_DEPTH
    env.fog_light_color = Color("4b5998ff")
    env.fog_light_energy = 0.65
    env.fog_sun_scatter = 1.0
    env.fog_density = 0.1
    env.fog_sky_affect = 1
    env.fog_height = 2.0
    env.fog_height_density = -0.3

func modify_global_light(light: DirectionalLight3D) -> void:
    # Filthy.  And yet... effective. Once.
    var light_parent = light.get_parent()
    if light_parent is not MapNode3D: return
    var map_node: MapNode3D = light_parent
    var wenv: WorldEnvironment = map_node.WorldEnv
    start_lightning(weakref(wenv))
    

func start_lightning(wenv: WeakRef):
    var attack_time = 0.05
    var decay_time = 0.8
    
    while is_instance_valid(wenv.get_ref()):
        await wenv.get_ref().get_tree().create_timer(randf_range(7, 25)).timeout
        #await wenv.get_ref().get_tree().create_timer(randf_range(2, 2)).timeout
        if wenv.get_ref():
            var tween: Tween = wenv.get_ref().create_tween()
            tween.set_parallel()
            tween.tween_property(wenv.get_ref().environment, "ambient_light_energy", 1.0, attack_time)
            tween.tween_property(wenv.get_ref().environment, "adjustment_brightness", 1.10, attack_time)
            tween.tween_property(wenv.get_ref().environment, "ambient_light_color", Colors.white, attack_time)
            tween.tween_property(wenv.get_ref().environment, "adjustment_contrast", 1.5, attack_time)
            tween.chain()
            tween.set_trans(Tween.TRANS_QUAD)
            tween.tween_property(wenv.get_ref().environment, "ambient_light_energy", 0.65, decay_time)
            tween.tween_property(wenv.get_ref().environment, "adjustment_brightness", 0.9, decay_time)
            tween.tween_property(wenv.get_ref().environment, "ambient_light_color", Color("4b5998ff"), decay_time)
            tween.tween_property(wenv.get_ref().environment, "adjustment_contrast", 0.9, decay_time)
        
    
