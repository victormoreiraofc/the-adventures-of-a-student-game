extends Area2D

func som_xicara(body: Node2D) -> void:
	if (body.name=="Personagem"):
		$SomXicara.play()

func sim_xicara_fora(body: Node2D) -> void:
	if (body.name=="Personagem"):
		$SomXicara.stop()
