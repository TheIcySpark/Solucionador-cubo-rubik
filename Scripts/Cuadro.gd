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