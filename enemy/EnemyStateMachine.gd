extends StateMachine

func takeDamage(damageAmount):
	state.call_deferred("takeDamage", damageAmount)

func vision_sphere_area_entered(area):
	if area != null && area.get_parent().name == "Player":
		state.call_deferred("handle_vision_sphere_area_entered", area)

func vision_sphere_area_exited(area):
	if area != null && area.get_parent().name == "Player":
		state.call_deferred("handle_vision_sphere_area_exited", area)

func attack_range_body_entered(body):
	if body != null && body.name == "Player":
		state.call_deferred("handle_attack_range_body_entered", body)

func attack_range_body_exited(body):
	if body != null && body.name == "Player":
		state.call_deferred("handle_attack_range_body_exited", body)
