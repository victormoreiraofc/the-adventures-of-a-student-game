extends Area2D

func zona_da_morte(body: Node2D) -> void:
	if (body.name=="Personagem"):
		ScriptGlobal.qtd_vidas -= 500
