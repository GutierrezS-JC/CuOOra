Class {
	#name : #UsuarioTest,
	#superclass : #TestCase,
	#instVars : [
		'usuario',
		'usuario2',
		'usuario3',
		'topicos',
		'topico1',
		'topico2',
		'topico3',
		'pregunta'
	],
	#category : #CuOOra
}

{ #category : #running }
UsuarioTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."

	usuario := Usuario conNombre: 'Codubi' conContrasenia: '123456'.
	usuario2 := Usuario conNombre: 'Pepe' conContrasenia: '654321'.
	usuario3 := Usuario conNombre: 'Reznov' conContrasenia: '456TheNumbers654'.
	topicos := Set new.
	topico1 := Topico conNombre: 'PHP' conDescripcion: 'Oldie but goldie'.
	topico2 := Topico
		conNombre: 'Javascript'
		conDescripcion: 'The weird one'.
	topico3 := Topico
		conNombre: 'Ruby On Rails'
		conDescripcion: 'Shine like a gem'.
	topicos add: topico1.
	pregunta := Pregunta
		conTopico: topicos
		conTitulo: 'Como declaro una variable en php?'
		conDescripcion: 'Eso.'
]

{ #category : #tests }
UsuarioTest >> testAgregarPreguntaConTopicosConTituloConDescripcion [
	usuario
		agregarPreguntaConTopicos: topicos
		conTitulo: 'Como declaro una variable en php?'
		conDescripcion: 'eso'.
	self assert: usuario obtenerPreguntasRealizadas size equals: 1
]

{ #category : #tests }
UsuarioTest >> testAgregarUsuarioEnSeguidos [
	self assert: usuario devolverSeguidos size equals: 0.
	usuario agregarUsuarioEnSeguidos: usuario2.
	self assert: usuario devolverSeguidos size equals: 1
]

{ #category : #tests }
UsuarioTest >> testDevolverPreguntasConTopico [
	| topicos2 |
	topicos2 := Set new.
	topicos2 add: topico3.
	usuario
		agregarPreguntaConTopicos: topicos
		conTitulo: 'Como declaro una variable en php?'
		conDescripcion: 'Eso'.
	topicos add: topico2.
	usuario
		agregarPreguntaConTopicos: topicos
		conTitulo:
			'Como puedo pedir datos desde Javascript a una API hecha en PHP con Laravel?'
		conDescripcion: 'Nada, eso'.
	usuario
		agregarPreguntaConTopicos: topicos2
		conTitulo: 'Como descargo Ruby?'
		conDescripcion: 'Ni ganas de buscar en Google'.
	self
		assert: (usuario devolverPreguntasConTopico: topicos) size
		equals: 2
]

{ #category : #tests }
UsuarioTest >> testDevolverRespuestasDeSusPreguntas [
	| unaPreguntaDeUsuario |
	usuario
		agregarPreguntaConTopicos: topicos
			conTitulo: 'Como declaro una variable en php?'
			conDescripcion: 'Eso';
		agregarPreguntaConTopicos: topicos
			conTitulo: 'PHP con Laravel o con Simfony?'
			conDescripcion: 'Quiero empezar un nuevo proyecto pero no se que Framework elegir'.
	unaPreguntaDeUsuario := usuario obtenerPreguntasRealizadas first.
	unaPreguntaDeUsuario
		agregarRespuestaConTexto: 'Han Domado, Repito, Han Domado a php'
			conUsuario: usuario2;
		agregarRespuestaConTexto: 'Busca en google' conUsuario: usuario3.
	unaPreguntaDeUsuario := usuario obtenerPreguntasRealizadas last.
	unaPreguntaDeUsuario
		agregarRespuestaConTexto:
			'Laravel, con muy poco esfuerzo levantas una app. Creo que es mas noob friendly'
		conUsuario: usuario2.
	self assert: usuario devolverRespuestasDeSusPreguntas size  equals: 3
]

{ #category : #tests }
UsuarioTest >> testEliminarPregunta [
	| unaPregunta |
	usuario
		agregarPreguntaConTopicos: topicos
		conTitulo: 'Como declaro una variable en php?'
		conDescripcion: 'Eso.'.
	unaPregunta := usuario obtenerPreguntasRealizadas first.
	self assert: usuario obtenerPreguntasRealizadas size equals: 1.
	usuario eliminarPregunta: unaPregunta.
	self assert: usuario obtenerPreguntasRealizadas size equals: 0
]

{ #category : #tests }
UsuarioTest >> testRegistrarTopicoInteres [
	self assert: usuario devolverTopicosInteres size equals: 0.
	topicos add: topico2.
	usuario registrarTopicoInteres: topicos.
	self assert: usuario devolverTopicosInteres size equals: 2.
	topicos add: topico3.
	usuario registrarTopicoInteres: topicos.
	self assert: usuario devolverTopicosInteres size equals: 3.
	self assert: usuario devolverTopicosInteres equals: topicos
]
