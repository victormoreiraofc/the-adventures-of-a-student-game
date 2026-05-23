extends Area2D

func fim_de_jogo(body: Node2D) -> void:
	if (body.name=="Personagem"):
		get_tree().change_scene_to_file("res://scene_victory.tscn")
