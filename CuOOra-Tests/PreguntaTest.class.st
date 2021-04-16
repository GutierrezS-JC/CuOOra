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
	"Datos y objetos que usaremos en los metodos tests "

	"Creamos e inicializamos los objetos definidos en las VI"

	topicos := OrderedCollection new.
	topicos2 := OrderedCollection new.
	"Creamos los topicos individuales"
	topico1 := Topico
		conNombre: 'Javascript'
		conDescripcion: 'El lenguaje de la web'.
	topico2 := Topico conNombre: 'PHP' conDescripcion: 'Goldie'.
	"Creamos los usuarios que usaremos en los tests"
	usuario1 := Usuario conNombre: 'Codubi' conContrasenia: 'Nova6'.
	usuario2 := Usuario conNombre: 'Ay No C' conContrasenia: 'Password'.
	"Cargamos los topicos en colecciones ya que nuestras preguntas esperan recibir una coleccion con n topicos"
	topicos
		add: topico1;
		add: topico2.
	topicos2 add: topico1.
	"Creamos una pregunta"
	pregunta := Pregunta
		conTopico: topicos
		conTitulo: 'Javascript vs PHP'
		conDescripcion:
			'The Chad Javascript vs the Oldie Php. Para mi el tema ya no tiene discusion'
		conUsuario: usuario1
]

{ #category : #tests }
PreguntaTest >> testAgregarRespuesta [
	"Verificamos que la respuesta sea correctamente agregada en una pregunta"
	| respuesta |
	respuesta := Respuesta
		conContenido: 'Han domado, han domado'
		conUsuario: usuario1.
	pregunta agregarRespuesta: respuesta.
	self deny: pregunta obtenerRespuestas equals: nil.
	self
		assert: (pregunta obtenerRespuestas includes: respuesta)
		equals: true
]

{ #category : #tests }
PreguntaTest >> testDevolverPuntosTotales [
	pregunta agregarLike: usuario1.
	pregunta agregarLike: usuario2.
	self assert: pregunta devolverPuntosTotales equals: 22
]

{ #category : #tests }
PreguntaTest >> testObtenerRespuestas [
	"Este test verifica que se obtengan todas las respuestas de una pregunta en especifico"
	| respuestasDePregunta respuesta1 respuesta2 |
	respuestasDePregunta := OrderedCollection new.
	respuesta1 := Respuesta
		conContenido: 'Han domado, han domado'
		conUsuario: usuario1.
	respuesta2 := Respuesta
		conContenido: 'Aguante PHP kjjjj'
		conUsuario: usuario2.
	pregunta agregarRespuesta: respuesta1.
	pregunta agregarRespuesta: respuesta2.
	respuestasDePregunta
		add: respuesta1;
		add: respuesta2.
	self deny: pregunta obtenerRespuestas size equals: 1.
	self assert: pregunta obtenerRespuestas size equals: 2.
	self
		assert: (pregunta obtenerRespuestas includesAll: respuestasDePregunta)
]

{ #category : #tests }
PreguntaTest >> testTieneTopicoBuscado [
	self assert: (pregunta tieneTopicoBuscado: topicos) equals: true.
	self assert: (pregunta tieneTopicoBuscado: topicos2) equals: true
]
