extends CharacterBody2D

var distancia_limite = 50
var distancia_atual  = 0
var direcao = 1
var velocidade = 1
var som_tocando = false
var personagem

func _ready():
	personagem = get_tree().root.find_child("Personagem", true, false)

func _physics_process(delta: float) -> void:
	position.x += direcao * velocidade
	distancia_atual += velocidade
	$AnimationPlayer.play("walk")
	if (distancia_atual>=distancia_limite):
		distancia_atual = 0
		direcao *= -1
		if (direcao==1):
			$Sprite2D.flip_h = false
		else:
			$Sprite2D.flip_h = true

	if personagem != null:
		var distancia = global_position.distance_to(personagem.global_position)
		if distancia <= 150 and not som_tocando:
			$Zumbi.play()
			som_tocando = true
		elif distancia > 150 and som_tocando:
			$Zumbi.stop()
			som_tocando = false
		elif distancia <= 150 and not $Zumbi.playing:
			$Zumbi.play()

func atacar_personagem(body: Node2D) -> void:
	if (body.name=="Personagem"):
		$Dano.play()
		ScriptGlobal.qtd_vidas -= 1
		body.piscar_dano()


func som_zumbi(body: Node2D) -> void:
	pass # Replace with function body.
