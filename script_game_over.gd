extends Node2D

func recomeçar_jogo() -> void:
	ScriptGlobal.inicializar()
	get_tree().change_scene_to_file("res://scene_level.tscn")

func tela_titulo() -> void:
	get_tree().change_scene_to_file("res://scene_start.tscn")
	
func _process(delta: float) -> void: # Preset do botão ao clicar no enter.
	if (Input.is_action_just_pressed("Iniciar")):
		tela_titulo()
