extends Node2D
onready var retroalimentacion=$Retoralimentacion
var cuadrados=[]
var cola=[]
var vis={}
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

func ConfiguracionPosible()->bool:
	var azul=0
	var naranja=0
	var rojo=0
	var amarillo=0
	var verde=0
	var blanco=0
	for cuadrado in cuadrados:
		if cuadrado.ColorActual()=="Azul": azul+=1
		elif cuadrado.ColorActual()=="Naranja": naranja+=1
		elif cuadrado.ColorActual()=="Rojo": rojo+=1
		elif cuadrado.ColorActual()=="Amarillo": amarillo+=1
		elif cuadrado.ColorActual()=="Verde": verde+=1
		elif cuadrado.ColorActual()=="Blanco": blanco+=1
	if azul!=9 or naranja!=9 or rojo!=9 or amarillo!=9 or verde!=9 or blanco!=9: return false
	return true

func SolucionCorrecta(solucion)->bool:
	var i=1
	while i<=53:
		if solucion[i].ColorActual()!=solucion[i-1].ColorActual(): return false
		i+=1
		if i%9==0: i+=1
	return true

func GirarDerecha(posReferencia,actual):
	var nuevo
	nuevo=actual
	nuevo[posReferencia]=actual[posReferencia+6]
	nuevo[posReferencia+1]=actual[posReferencia+3]
	nuevo[posReferencia+2]=actual[posReferencia]
	nuevo[posReferencia+3]=actual[posReferencia+7]
	nuevo[posReferencia+4]=actual[posReferencia+4]
	nuevo[posReferencia+5]=actual[posReferencia+1]
	nuevo[posReferencia+6]=actual[posReferencia+8]
	nuevo[posReferencia+7]=actual[posReferencia+5]
	nuevo[posReferencia+8]=actual[posReferencia+2]
	return nuevo

func GirarIzquierda(posReferencia,actual):
	var nuevo
	nuevo=actual
	nuevo[posReferencia]=actual[posReferencia+2]
	nuevo[posReferencia+1]=actual[posReferencia+5]
	nuevo[posReferencia+2]=actual[posReferencia+8]
	nuevo[posReferencia+3]=actual[posReferencia+1]
	nuevo[posReferencia+4]=actual[posReferencia+4]
	nuevo[posReferencia+5]=actual[posReferencia+7]
	nuevo[posReferencia+6]=actual[posReferencia+0]
	nuevo[posReferencia+7]=actual[posReferencia+3]
	nuevo[posReferencia+8]=actual[posReferencia+6]
	return nuevo

func MostrarPasos(paso):
	if vis[paso]=="0": return
	pass

func Girar(subCuadrado,direccion,actual):
	var pos=[]
	var intercambio=[]
	var nuevo=actual
	if subCuadrado==1:
		if direccion=="Derecha":
			pos=[0,1,2,3,4,5,6,7,8,9,10,11,18,19,20,27,28,29,51,52,53]
			intercambio=[6,3,0,7,4,1,8,5,2,18,19,20,27,28,29,53,52,51,11,10,9]
		elif direccion=="Izquierda":
			pos=[0,1,2,3,4,5,6,7,8,9,10,11,18,19,20,27,28,29,51,52,53]
			intercambio=[2,5,8,1,4,7,0,3,6,53,52,51,9,10,11,18,19,20]
	elif subCuadrado==2:
		if direccion=="Derecha":
			pos=[9,10,11,12,13,14,15,16,0,3,6,18,21,24,36,39,42,45,48,51]
			intercambio=[15,12,9,16,13,10,17,14,11,45,48,51,0,3,6,18,21,24,36,39,42]
		elif direccion=="Izquierda":
			pos=[9,10,11,12,13,14,15,16,0,3,6,18,21,24,36,39,42,45,48,51]
			intercambio=[11,14,17,10,13,16,9,12,15,18,21,24,36,39,42,45,48,51,6,3,0]
	elif subCuadrado==3:
		if direccion=="Derecha":
			pos=[18,19,20,21,22,23,24,25,26,6,7,8,11,14,17,27,30,33,36,37,38]
			intercambio=[24,21,18,25,22,19,26,23,20,17,14,11,36,37,38,6,7,8,33,30,27]
		elif direccion=="Izquierda":
			pos=[18,19,20,21,22,23,24,25,26,6,7,8,11,14,17,27,30,33,36,37,38]
			intercambio=[]
	elif subCuadrado==4:
		if direccion=="Derecha":
			pos=[]
			intercambio=[]
		elif direccion=="Izquierda":
			pos=[]
			intercambio=[]
	elif subCuadrado==5:
		if direccion=="Derecha":
			pos=[]
			intercambio=[]
		elif direccion=="Izquierda":
			pos=[]
			intercambio=[]
	elif subCuadrado==6:
		if direccion=="Derecha":
			pos=[]
			intercambio=[]
		elif direccion=="Izquierda":
			pos=[]
			intercambio=[]
	var i=0
	while i<pos.size():
		nuevo[pos[i]]=actual[intercambio[i]]
		i+=1



func BuscarSolucion():
	cola=[]
	var actual
	cola.push_back(cuadrados)
	vis[cuadrados]="0"
	while cola.size()>0:
		actual=cola.front()
		cola.pop_back()
		if SolucionCorrecta(actual): 
			MostrarPasos(actual)
			break
		pass
		#Agregar Girar(a,b,c)
	cola=[]

func _on_Resolver_button_down():
	vis={}
	if !ConfiguracionPosible(): retroalimentacion.text="Configuracion invalida"
	else:
		retroalimentacion.text="Resolviendo..."
		BuscarSolucion()
		retroalimentacion.text="Resuelto :)"













