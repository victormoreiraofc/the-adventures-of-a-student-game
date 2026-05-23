extends Node2D

func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("Iniciar")):
		voltar_tela_inicial()

func jogar_novamente() -> void:
	ScriptGlobal.inicializar()
	get_tree().change_scene_to_file("res://scene_level.tscn")

func voltar_tela_inicial() -> void:
	get_tree().change_scene_to_file("res://scene_start.tscn")
