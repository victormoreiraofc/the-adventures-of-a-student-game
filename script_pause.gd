extends CanvasLayer

func _ready():
	visible = false

func toggle_pause():
	get_tree().paused = !get_tree().paused
	visible = get_tree().paused
	
	if visible:
		$Pause.play()
	else:
		$Pause.stop()

func botao_continuar() -> void:
	get_tree().paused = false
	visible = false

func botao_reiniciar_partida() -> void:
	ScriptGlobal.inicializar()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scene_level.tscn")

func botao_voltar_tela_inicial() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scene_start.tscn")
