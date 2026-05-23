extends Area2D

func som_zumbi(body: Node2D) -> void:
	if (body.name=="Personagem"):
		$SomZumbi.play()

func som_zumbi_fora(body: Node2D) -> void:
	if (body.name=="Personagem"):
		$SomZumbi.stop()
