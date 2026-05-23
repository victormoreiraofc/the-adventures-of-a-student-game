extends Area2D

var velocidade = 4
var direcao = 1

func _process(delta: float) -> void:
	if (direcao == 1):
		global_position.x += velocidade
		$Sprite2D.flip_h = false
	else:
		global_position.x -= velocidade
		$Sprite2D.flip_h = true

func eliminar_inimigo(body: Node2D) -> void:
	if (body.name == "Inimigo"):
		body.queue_free()
		queue_free()

	if (body.name == "Boss"):
		body.tomar_dano(1)
		queue_free()

func bater_caixa(area: Area2D) -> void:
	if (area.name == "Caixa"):
		queue_free()
