Class {
	#name : #VotoTest,
	#superclass : #TestCase,
	#instVars : [
		'usuario',
		'voto'
	],
	#category : #'CuOOra-Tests'
}

{ #category : #running }
VotoTest >> setUp [
	"Datos y objetos que usaremos en los metodos tests "

	"Creamos e inicializamos los objetos definidos en las VI"

	usuario := Usuario conNombre: 'Codubi' conContrasenia: '123456'.
	voto := Voto conUsuario: usuario
]

{ #category : #tests }
VotoTest >> testRealizadoPor [
	self assert: (voto realizadoPor: usuario) equals: true.

]
