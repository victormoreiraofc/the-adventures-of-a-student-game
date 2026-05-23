extends CharacterBody2D

var sofrendo_dano = false
var velocidade = 300
var forca_pulo = 700
var gravidade  = 40
var vivo = true
@export var animando = false

func piscar_dano():
	$Sprite2D.modulate.a = 0.3
	await get_tree().create_timer(0.2).timeout
	$Sprite2D.modulate.a = 1.0

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		var tela = get_tree().root.find_child("TelaPause", true, false)
		if tela:
			tela.toggle_pause()
		return
		
	velocity.x = 0
	velocity.y += gravidade
	
	if (ScriptGlobal.qtd_vidas<=0 and vivo):
		ScriptGlobal.qtd_vidas = 0
		$AnimationPlayer.play("Dead")
		$Morte.play()
		vivo = false

	if (vivo):
		if (Input.is_action_pressed("ui_left")):
				velocity.x = -velocidade
				$Sprite2D.flip_h = true
				$Marker2D.position.x = -1 * abs($Marker2D.position.x) # abs converter negativo para positivo
				$Area2D.scale.x = -1
				
		if (Input.is_action_pressed("ui_right")):
				velocity.x = velocidade
				$Sprite2D.flip_h = false
				$Marker2D.position.x = abs($Marker2D.position.x) # abs converter negativo para positivo
				$Area2D.scale.x = 1
				
		if (Input.is_action_just_pressed("ui_up") and is_on_floor()):
			velocity.y = -forca_pulo
			animando = false

		if (Input.is_action_pressed("Shot") and is_on_floor()):
			animando = true
			$AnimationPlayer.play("Shot")

		if (Input.is_action_just_pressed("Attack") and is_on_floor()):
			animando = true
			$AnimationPlayer.play("Attack")
			$Mochila.play()

		var anim_atual = $AnimationPlayer.current_animation
		if (anim_atual=="Shot" || anim_atual=="Attack"):
			velocity.x = 0

		if (not animando):
			if (is_on_floor()):
				if (velocity.x == 0):
					$AnimationPlayer.play("Idle")
				else:
					$AnimationPlayer.play("Walk")
			else:
				$AnimationPlayer.play("Jump")
				
	move_and_slide()

func spawnar_livro():
	$ArremecandoLivro.play()
	var cena_livro   = preload("res://scene_book.tscn")
	var objeto_livro = cena_livro.instantiate()
	
	if (not $Sprite2D.flip_h): # não foi flipada, então é a imagem padrão, ou seja, direita
		objeto_livro.get_node("Livro").direcao = 1
	else:
		objeto_livro.get_node("Livro").direcao = -1
	
	add_sibling(objeto_livro)
	objeto_livro.global_position = $Marker2D.global_position

func eliminar_inimigo(body: Node2D) -> void:
	if (body.name=="Inimigo"):
		body.queue_free()
	
	if (body.name == "Boss"):
		body.tomar_dano(1)
		
func cancelar_animacao():
	animando = false
func tela_game_over():
	get_tree().change_scene_to_file("res://scene_game_over.tscn")
