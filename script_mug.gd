extends CharacterBody2D

var gravidade = 10
var forca_pulo = 200
var velocidade = 0

func _physics_process(delta: float) -> void:
	velocity.y += gravidade
	$Sprite2D.flip_h = true
	$AnimationPlayer.play("jump")
	if (is_on_floor()):
		velocity.y = -forca_pulo
		
	move_and_slide()

func atacar_jogador(body: Node2D) -> void:
	if (body.name=="Personagem"):
		$Dano.play()
		ScriptGlobal.qtd_vidas -= 1
		body.piscar_dano()
