extends Area2D

var tempo = 0.0
var posicao_inicial

func _ready():
	posicao_inicial = $Sprite2D.position

func _process(delta):
	tempo += delta
	$Sprite2D.position.y = posicao_inicial.y + sin(tempo * 2) * 5

func coletar_vida(body: Node2D) -> void:
	if (body.name=="Personagem"):
		ScriptGlobal.qtd_vidas += 1
		$AudioStreamPlayer2D.play()
		hide()
		$CollisionShape2D.set_deferred("disabled", true)
		await $AudioStreamPlayer2D.finished
		queue_free()
