extends Node2D
onready var retroalimentacion=$Retoralimentacion
var cuadrados=[]
var cola=[]
var vis={}
var posicion=0

func _ready():
	cuadrados=get_tree().get_nodes_in_group("cuadrado")
	InizializarCasoPrueba(1)

func InizializarCasoPrueba(caso):
	if caso==1:
		cuadrados[0].CambiarColor(0.55,0,0,1)
		cuadrados[1].CambiarColor(0.55,0,0,1)
		cuadrados[2].CambiarColor(0.55,0,0,1)
		cuadrados[3].CambiarColor(0.55,0,0,1)
		cuadrados[4].CambiarColor(0.55,0,0,1)
		cuadrados[5].CambiarColor(0.55,0,0,1)
		cuadrados[27].CambiarColor(0.55,0,0,1)
		cuadrados[30].CambiarColor(0.55,0,0,1)
		cuadrados[33].CambiarColor(0.55,0,0,1)
		
		cuadrados[6].CambiarColor(0.12,0.56,1,1)
		cuadrados[7].CambiarColor(0.12,0.56,1,1)
		cuadrados[8].CambiarColor(0.12,0.56,1,1)
		cuadrados[9].CambiarColor(0.12,0.56,1,1)
		cuadrados[10].CambiarColor(0.12,0.56,1,1)
		cuadrados[12].CambiarColor(0.12,0.56,1,1)
		cuadrados[13].CambiarColor(0.12,0.56,1,1)
		cuadrados[15].CambiarColor(0.12,0.56,1,1)
		cuadrados[16].CambiarColor(0.12,0.56,1,1)
		
		cuadrados[18].CambiarColor(1,0.55,0,1)
		cuadrados[19].CambiarColor(1,0.55,0,1)
		cuadrados[20].CambiarColor(1,0.55,0,1)
		cuadrados[21].CambiarColor(1,0.55,0,1)
		cuadrados[22].CambiarColor(1,0.55,0,1)
		cuadrados[23].CambiarColor(1,0.55,0,1)
		cuadrados[24].CambiarColor(1,0.55,0,1)
		cuadrados[25].CambiarColor(1,0.55,0,1)
		cuadrados[26].CambiarColor(1,0.55,0,1)
		
		cuadrados[11].CambiarColor(0.13,0.7,0.67,1)
		cuadrados[14].CambiarColor(0.13,0.7,0.67,1)
		cuadrados[17].CambiarColor(0.13,0.7,0.67,1)
		cuadrados[39].CambiarColor(0.13,0.7,0.67,1)
		cuadrados[40].CambiarColor(0.13,0.7,0.67,1)
		cuadrados[41].CambiarColor(0.13,0.7,0.67,1)
		cuadrados[42].CambiarColor(0.13,0.7,0.67,1)
		cuadrados[43].CambiarColor(0.13,0.7,0.67,1)
		cuadrados[44].CambiarColor(0.13,0.7,0.67,1)
		
		cuadrados[45].CambiarColor(1,0.84,0,1)
		cuadrados[46].CambiarColor(1,0.84,0,1)
		cuadrados[47].CambiarColor(1,0.84,0,1)
		cuadrados[48].CambiarColor(1,0.84,0,1)
		cuadrados[49].CambiarColor(1,0.84,0,1)
		cuadrados[50].CambiarColor(1,0.84,0,1)
		cuadrados[51].CambiarColor(1,0.84,0,1)
		cuadrados[52].CambiarColor(1,0.84,0,1)
		cuadrados[53].CambiarColor(1,0.84,0,1)

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


func MostrarPasos(paso):
	if "Origen" in str(vis[paso].hash()): return
	if "Derecha" in str(vis[paso].hash()):
		paso=Girar(int(vis[0]),"Izquierda",paso)
	elif "3 Izquierda" in str(vis[paso].hash()):
		paso=Girar(int(vis[0]),"Derecha",paso)
	print(vis[paso])

func Girar(subCuadrado,direccion,actual):
	var pos=[]
	var intercambio=[]
	var nuevo=actual.duplicate(true)
	if subCuadrado==1:
		if direccion=="Derecha":
			pos=[0,1,2,3,4,5,6,7,8,9,10,11,18,19,20,27,28,29,51,52,53]
			intercambio=[6,3,0,7,4,1,8,5,2,18,19,20,27,28,29,53,52,51,11,10,9]
		elif direccion=="Izquierda":
			pos=[0,1,2,3,4,5,6,7,8,9,10,11,18,19,20,27,28,29,51,52,53]
			intercambio=[2,5,8,1,4,7,0,3,6,53,52,51,9,10,11,18,19,20,29,28,27]
	elif subCuadrado==2:
		if direccion=="Derecha":
			pos=[9,10,11,12,13,14,15,16,17,0,3,6,18,21,24,36,39,42,45,48,51]
			intercambio=[15,12,9,16,13,10,17,14,11,45,48,51,0,3,6,18,21,24,36,39,42]
		elif direccion=="Izquierda":
			pos=[9,10,11,12,13,14,15,16,17,0,3,6,18,21,24,36,39,42,45,48,51]
			intercambio=[11,14,17,10,13,16,9,12,15,18,21,24,36,39,42,45,48,51,0,3,6]
	elif subCuadrado==3:
		if direccion=="Derecha":
			pos=[18,19,20,21,22,23,24,25,26,6,7,8,11,14,17,27,30,33,36,37,38]
			intercambio=[24,21,18,25,22,19,26,23,20,17,14,11,36,37,38,6,7,8,33,30,27]
		elif direccion=="Izquierda":
			pos=[18,19,20,21,22,23,24,25,26,6,7,8,11,14,17,27,30,33,36,37,38]
			intercambio=[20,23,26,19,22,25,18,21,24,27,30,33,8,7,6,38,37,36,11,14,17]
	elif subCuadrado==4:
		if direccion=="Derecha":
			pos=[27,28,29,30,31,32,33,34,35,2,5,8,20,23,26,38,41,44,47,50,53]
			intercambio=[33,30,27,34,31,28,35,32,29,20,23,26,38,41,44,47,50,53,2,5,8]
		elif direccion=="Izquierda":
			pos=[27,28,29,30,31,32,33,34,35,2,5,8,20,23,26,38,41,44,47,50,53]
			intercambio=[29,32,35,28,31,34,27,30,33,47,50,53,2,5,8,20,23,26,38,41,44]
	elif subCuadrado==5:
		if direccion=="Derecha":
			pos=[36,37,38,39,40,41,42,43,44,15,16,17,24,25,26,33,34,35,45,46,47]
			intercambio=[42,39,36,43,40,37,44,41,38,47,46,45,15,16,17,24,25,26,35,34,33]
		elif direccion=="Izquierda":
			pos=[36,37,38,39,40,41,42,43,44,15,16,17,24,25,26,33,34,35,45,46,47]
			intercambio=[38,41,44,37,40,43,36,39,42,24,25,26,33,34,35,47,46,45,17,16,15]
	elif subCuadrado==6:
		if direccion=="Derecha":
			pos=[45,46,47,48,49,50,51,52,53,0,1,2,9,12,15,29,32,35,42,43,44]
			intercambio=[51,48,45,52,49,46,53,50,47,29,32,35,2,1,0,44,43,42,9,12,15]
		elif direccion=="Izquierda":
			pos=[45,46,47,48,49,50,51,52,53,0,1,2,9,12,15,29,32,35,42,43,44]
			intercambio=[47,50,53,46,49,52,45,48,51,15,12,9,42,43,44,0,1,2,35,32,29]
	var i=0
	while i<pos.size():
		nuevo[pos[i]]=actual[intercambio[i]]
		i+=1
	if !(nuevo in vis):
		cola.push_back(nuevo)
		vis[nuevo]=str(subCuadrado)+" "+str(direccion)
	return nuevo.duplicate(true)

func MostrarEnConsolaCubo(cubo):
	var i=0
	while i<cubo.size():
		print(cubo[i].ColorActual())
		i+=1
	print("->            SALTO")

func BuscarSolucion():
	cola=[]
	vis={}
	var actual
	actual=cuadrados.duplicate(true)
	cola.push_back(actual)
	vis[actual]="Origen"
	while cola.size()>0:
		actual=cola.front()
		cola.pop_front()
		if SolucionCorrecta(actual): 
			MostrarPasos(actual)
			break
		Girar(1,"Izquierda",actual)
		Girar(1,"Derecha",actual)
		Girar(2,"Izquierda",actual)
		Girar(2,"Derecha",actual)
		Girar(3,"Izquierda",actual)
		Girar(3,"Derecha",actual)
		Girar(4,"Izquierda",actual)
		Girar(4,"Derecha",actual)
		Girar(5,"Izquierda",actual)
		Girar(5,"Derecha",actual)
		Girar(6,"Izquierda",actual)
		Girar(6,"Derecha",actual)
	cola=[]

func _on_Resolver_button_down():
	vis={}
	if !ConfiguracionPosible(): retroalimentacion.text="Configuracion invalida"
	else:
		retroalimentacion.text="Resolviendo..."
		BuscarSolucion()
		retroalimentacion.text="Resuelto :)"













