extends Control

func _ready():
	EstablecerColores()

func EstablecerColores():
	$colores/q.modulate=Color(0.55,0,0,1)
	$colores/w.modulate=Color(0.12,0.56,1,1)
	$colores/e.modulate=Color(0.13,0.7,0.67,1)
	$colores/a.modulate=Color(1,0.84,0,1)
	$colores/s.modulate=Color(1,1,1,1)
	$colores/d.modulate=Color(1,0.55,0,1)