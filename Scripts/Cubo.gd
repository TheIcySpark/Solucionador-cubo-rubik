extends Node2D
var cuadrados=[]
var posicion=0

func _ready():
	cuadrados=get_tree().get_nodes_in_group("cuadrado")


func LeerTeclado():
	if Input.is_action_just_pressed("ui_derecha"):
		cuadrados[posicion].CambiarAlpha(1)
		posicion+=1
		if posicion>=54: posicion-=1
	if Input.is_action_just_pressed("ui_izquierda"):
		cuadrados[posicion].CambiarAlpha(1)
		posicion-=1
		if posicion<0: posicion+=1
	if Input.is_action_just_pressed("ui_azul"):
		cuadrados[posicion].CambiarColor(0.12,0.56,1,1)
	if Input.is_action_just_pressed("ui_naranja"):
		cuadrados[posicion].CambiarColor(1,0.55,0,1)
	if Input.is_action_just_pressed("ui_rojo"):
		cuadrados[posicion].CambiarColor(0.55,0,0,1)
	if Input.is_action_just_pressed("ui_amarillo"):
		cuadrados[posicion].CambiarColor(1,0.84,0,1)
	if Input.is_action_just_pressed("ui_verde"):
		cuadrados[posicion].CambiarColor(0.13,0.7,0.67,1)
	if Input.is_action_just_pressed("ui_blanco"):
		cuadrados[posicion].CambiarColor(1,1,1,1)

func Parpadear():
	var colores=cuadrados[posicion].ObtenerColor()
	colores.a+=0.02
	if colores.a>1: colores.a=0
	cuadrados[posicion].CambiarAlpha(colores.a)

func _process(delta):
	LeerTeclado()
	Parpadear()