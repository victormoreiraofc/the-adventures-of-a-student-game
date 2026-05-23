extends CharacterBody2D

var gravidade = 10
var forca_pulo = 300
var velocidade = 0
@export var vida = 10
@export var vida_maxima = 10
var morto = false
var som_tocando = false
var personagem

func _ready():
	$ProgressBar.max_value = vida_maxima
	$ProgressBar.value = vida
	personagem = get_tree().root.find_child("Personagem", true, false)

func _physics_process(delta: float) -> void:
	if morto:
		return
	velocity.y += gravidade
	$AnimationPlayer.play("jump")
	if (is_on_floor()):
		velocity.y = -forca_pulo
	
	if personagem != null:
		var distancia = global_position.distance_to(personagem.global_position)
		if distancia <= 150 and not som_tocando:
			$Boss.play()
			som_tocando = true
		elif distancia > 150 and som_tocando:
			$Boss.stop()
			som_tocando = false
		elif distancia <= 150 and not $Boss.playing:
			$Boss.play()
		
	move_and_slide()

func tomar_dano(dano):
	if morto:
		return
	vida -= dano
	$ProgressBar.value = vida
	if vida <= 0:
		morrer()

func morrer():
	morto = true
	$ProgressBar.visible = false
	queue_free()

func atacar_personagem(body: Node2D) -> void:
	if (body.name=="Personagem"):
		$Dano.play()
		ScriptGlobal.qtd_vidas -= 1
		body.piscar_dano()
