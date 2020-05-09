extends Control
onready var colorRect=$ColorRect

func _ready():
	pass


func CambiarColor(r,g,b,a):
	colorRect.color=Color(r,g,b,a);

func ObtenerColor():
	return colorRect.get("color")

func CambiarAlpha(a):
	var colores=colorRect.get("color")
	colorRect.color=Color(colores.r,colores.g,colores.b,a)

func ColorActual()->String:
	CambiarAlpha(1);
	if colorRect.get("color")==Color(0.12,0.56,1,1): return "Azul"
	elif colorRect.get("color")==Color(1,0.55,0,1): return "Naranja"
	elif colorRect.get("color")==Color(0.55,0,0,1): return "Rojo"
	elif colorRect.get("color")==Color(1,0.84,0,1): return "Amarillo"
	elif colorRect.get("color")==Color(0.13,0.7,0.67,1): return "Verde"
	elif colorRect.get("color")==Color(1,1,1,1): return "Blanco"
	return "Color no encontrado"