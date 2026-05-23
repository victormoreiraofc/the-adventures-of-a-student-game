extends Area2D

var xicara_ativa = {
	"Xicara": true,
	"Xicara2": true,
	"Xicara3": true
}

func _ready():
	$SomXicara.finished.connect(_repetir_xicara)
	$SomXicara2.finished.connect(_repetir_xicara2)
	$SomXicara3.finished.connect(_repetir_xicara3)

func _repetir_xicara():
	if xicara_ativa["Xicara"] and is_instance_valid(get_tree().root.find_child("Xicara", true, false)):
		$SomXicara.play()

func _repetir_xicara2():
	if xicara_ativa["Xicara2"] and is_instance_valid(get_tree().root.find_child("Xicara2", true, false)):
		$SomXicara2.play()

func _repetir_xicara3():
	if xicara_ativa["Xicara3"] and is_instance_valid(get_tree().root.find_child("Xicara3", true, false)):
		$SomXicara3.play()

func som_do_inimigo(body: Node2D) -> void:
	if body.name == "Personagem":
		if xicara_ativa["Xicara"] and is_instance_valid(get_tree().root.find_child("Xicara", true, false)):
			$SomXicara.play()
		if xicara_ativa["Xicara2"] and is_instance_valid(get_tree().root.find_child("Xicara2", true, false)):
			$SomXicara2.play()
		if xicara_ativa["Xicara3"] and is_instance_valid(get_tree().root.find_child("Xicara3", true, false)):
			$SomXicara3.play()

func som_do_inimigo_off(body: Node2D) -> void:
	if body.name == "Personagem":
		$SomXicara.stop()
		$SomXicara2.stop()
		$SomXicara3.stop()

func desativar_som(nome: String) -> void:
	xicara_ativa[nome] = false
	var som_nome = "Som" + nome
	var som = get_node_or_null(NodePath(som_nome))
	if som:
		if nome == "Xicara" and som.finished.is_connected(_repetir_xicara):
			som.finished.disconnect(_repetir_xicara)
		elif nome == "Xicara2" and som.finished.is_connected(_repetir_xicara2):
			som.finished.disconnect(_repetir_xicara2)
		elif nome == "Xicara3" and som.finished.is_connected(_repetir_xicara3):
			som.finished.disconnect(_repetir_xicara3)
		som.stop()
