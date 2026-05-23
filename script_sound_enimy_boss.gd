extends Area2D

func som_boss(body: Node2D) -> void:
	if (body.name=="Personagem"):
		$SomBoss.play()

func som_boss_fora(body: Node2D) -> void:
	if (body.name=="Personagem"):
		$SomBoss.stop()
