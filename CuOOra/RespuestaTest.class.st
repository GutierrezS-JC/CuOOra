Class {
	#name : #RespuestaTest,
	#superclass : #TestCase,
	#instVars : [
		'respuesta',
		'usuario',
		'usuario2'
	],
	#category : #CuOOra
}

{ #category : #running }
RespuestaTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."

	usuario := Usuario conNombre: 'Codubi' conContrasenia: '123456'.
	usuario2 := Usuario conNombre: 'Test' conContrasenia: '654321'.
	respuesta := Respuesta conContenido: 'Ay no c' conUsuario: usuario
]

{ #category : #tests }
RespuestaTest >> testDevolverPuntosTotales [
	respuesta agregarLike: usuario.
	respuesta agregarLike: usuario2.
	self assert: respuesta devolverPuntosTotales equals: 52
]

{ #category : #tests }
RespuestaTest >> testPerteneceA [
	self assert: (respuesta perteneceA: usuario) equals: true.
	self assert: (respuesta perteneceA: usuario2) equals: false
]
