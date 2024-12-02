extends Timer


func _on_timeout():
	var parent = get_parent()
	if is_instance_valid(parent):
		parent.queue_free()
