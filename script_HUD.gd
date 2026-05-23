extends Node2D

func _process(delta: float) -> void:
	$Label.text = "X " + str(ScriptGlobal.qtd_vidas)
