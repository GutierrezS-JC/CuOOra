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
	"Hooks that subclasses may override to define the fixture of test."
	usuario := Usuario conNombre: 'Codubi' conContrasenia: '123456'.
	voto :=Voto conUsuario: usuario .
]

{ #category : #tests }
VotoTest >> testRealizadoPor [
	self assert: (voto realizadoPor: usuario) equals: true.

]
