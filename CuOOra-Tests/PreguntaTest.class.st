Class {
	#name : #PreguntaTest,
	#superclass : #TestCase,
	#instVars : [
		'pregunta',
		'topicos',
		'topicos2',
		'topico1',
		'topico2',
		'usuario1',
		'usuario2'
	],
	#category : #'CuOOra-Tests'
}

{ #category : #running }
PreguntaTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."

	topicos := OrderedCollection new.
	topicos2:=OrderedCollection new.
	topico1 := Topico
		conNombre: 'Javascript'
		conDescripcion: 'El lenguaje de la web'.
	topico2 := Topico conNombre: 'PHP' conDescripcion: 'Goldie'.
	usuario1 := Usuario conNombre: 'Codubi' conContrasenia: 'Nova6'.
	usuario2 := Usuario conNombre: 'Ay No C' conContrasenia: 'Password'.
	topicos
		add: topico1;
		add: topico2.
	topicos2 add: topico1.
	pregunta := Pregunta
		conTopico: topicos
		conTitulo: 'Javascript vs PHP'
		conDescripcion:
			'The Chad Javascript vs the Oldie Php. Para mi el tema ya no tiene discusion'
]

{ #category : #tests }
PreguntaTest >> testAgregarRespuestaConTextoConUsuario [
	pregunta
		agregarRespuestaConTexto: 'Han domado, han domado'
		conUsuario: usuario1.
	self deny: pregunta obtenerRespuestas equals: nil.
	pregunta
		agregarRespuestaConTexto: 'Jeje ta bien'
		conUsuario: usuario1.
	self assert: pregunta obtenerRespuestas size equals: 2.
]

{ #category : #tests }
PreguntaTest >> testDevolverPuntosTotales [
	pregunta agregarLike: usuario1.
	pregunta agregarLike: usuario2.
	self assert: pregunta devolverPuntosTotales equals: 22
]

{ #category : #tests }
PreguntaTest >> testObtenerRespuestas [
	pregunta
		agregarRespuestaConTexto: 'Han domado, han domado'
		conUsuario: usuario1.
	pregunta
		agregarRespuestaConTexto: 'Aguante PHP kjjjj'
		conUsuario: usuario2.
	self deny: (pregunta obtenerRespuestas size) equals: 1.
	self assert: pregunta obtenerRespuestas size equals: 2
]

{ #category : #tests }
PreguntaTest >> testTieneTopicoBuscado [
	self assert: (pregunta tieneTopicoBuscado: topicos) equals: true.
	self assert: (pregunta tieneTopicoBuscado: topicos2) equals: true
]
