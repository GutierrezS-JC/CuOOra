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
	#category : #'CuOOra-Tests'
}

{ #category : #running }
UsuarioTest >> setUp [
	"Datos y objetos que usaremos en los metodos tests "

	"Creamos e inicializamos los objetos definidos en las VI"

	usuario := Usuario conNombre: 'Codubi' conContrasenia: '123456'.
	usuario2 := Usuario conNombre: 'Pepe' conContrasenia: '654321'.
	usuario3 := Usuario
		conNombre: 'Reznov'
		conContrasenia: '456TheNumbers654'.
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
		conUsuario: usuario
]

{ #category : #tests }
UsuarioTest >> testAgregarPreguntaConTopicosConTituloConDescripcion [
"Este test verifica que el usuario haya creado con exito una pregunta y se encuentre en su coleccion de preguntas realizadas"
	| preguntaNueva |
	preguntaNueva := usuario
		agregarPreguntaConTopicos: topicos
		conTitulo: 'Como declaro una variable en php?'
		conDescripcion: 'eso'.
	self assert: usuario obtenerPreguntasRealizadas size equals: 1.
	self
		assert: (usuario obtenerPreguntasRealizadas includes: preguntaNueva)
		equals: true
]

{ #category : #tests }
UsuarioTest >> testAgregarUsuarioEnSeguidos [
	self assert: usuario devolverSeguidos size equals: 0.
	usuario agregarUsuarioEnSeguidos: usuario2.
	self assert: usuario devolverSeguidos size equals: 1
]

{ #category : #tests }
UsuarioTest >> testDevolverMisRespuestasAMisPreguntas [
"Este test verifica que se devuelvan las respuestas de un usuario correspondientes a las preguntas que ese usuario realizo. Utilizado para la operacion de calculo de puntaje"
	| pregunta1 pregunta2 |
	pregunta1 := usuario
		agregarPreguntaConTopicos: topicos
		conTitulo: 'Php o Js?'
		conDescripcion: 'A ver, debatan'.
	pregunta2 := usuario
		agregarPreguntaConTopicos: topicos
		conTitulo: 'Como declarar variables en php?'
		conDescripcion: 'Eso.'.
	pregunta1
		agregarRespuesta: (Respuesta conContenido: 'Ay... no se' conUsuario: usuario).
	pregunta1
		agregarRespuesta: (Respuesta conContenido: 'Ya deberias saberlo' conUsuario: usuario).
	pregunta1
		agregarRespuesta:
			(Respuesta
				conContenido: 'Js por que es el futuro nene'
				conUsuario: usuario2).
	pregunta2
		agregarRespuesta:
			(Respuesta
				conContenido: 'Depende que variable pa'
				conUsuario: usuario3).
	pregunta2
		agregarRespuesta: (Respuesta conContenido: 'Con un $' conUsuario: usuario2).
	pregunta2
		agregarRespuesta:
			(Respuesta
				conContenido: 'io ke se no soi cientifiko'
				conUsuario: usuario).
	self
		assert: usuario devolverMisRespuestasAMisPreguntas size
		equals: 3
]

{ #category : #tests }
UsuarioTest >> testDevolverPreguntasConTopico [
	"Este test comprueba que se devuelven las preguntas de acuerdo a un o varios topicos especificados"

	| topicos2 preguntasConTopico |
	topicos2 := Set new.
	preguntasConTopico := OrderedCollection new.
	topicos2 add: topico3.
	preguntasConTopico
		add:
			(usuario
				agregarPreguntaConTopicos: topicos
				conTitulo: 'Como declaro una variable en php?'
				conDescripcion: 'Eso').
	"Agregamos un topico mas a la coleccion topicos que usamos para crear la pregunta. De esta forma se muestra que mientras los topicos de la pregunta contengan al topico buscado, se va a devolver igualmente"
	topicos add: topico2.
	preguntasConTopico
		add:
			(usuario
				agregarPreguntaConTopicos: topicos
				conTitulo:
					'Como puedo pedir datos desde Javascript a una API hecha en PHP con Laravel?'
				conDescripcion: 'Nada, eso').
	usuario
		agregarPreguntaConTopicos: topicos2
		conTitulo: 'Como descargo Ruby?'
		conDescripcion: 'Ni ganas de buscar en Google'.
	self
		assert: (usuario devolverPreguntasConTopico: topicos) size
		equals: 2.
	self
		assert:
			((usuario devolverPreguntasConTopico: topicos)
				includesAll: preguntasConTopico)
		equals: true
]

{ #category : #tests }
UsuarioTest >> testDevolverRespuestasDeSusPreguntas [
	"Este test comprueba que se devuelven todas las respuestas a las preguntas de un usuario"

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
		agregarRespuesta:
			(Respuesta
				conContenido: 'Han Domado, Repito, Han Domado a php'
				conUsuario: usuario2);
		agregarRespuesta: (Respuesta conContenido: 'Busca en google' conUsuario: usuario3).
	unaPreguntaDeUsuario := usuario obtenerPreguntasRealizadas last.
	unaPreguntaDeUsuario
		agregarRespuesta:
			(Respuesta
				conContenido:
					'Laravel, con muy poco esfuerzo levantas una app. Creo que es mas noob friendly'
				conUsuario: usuario2).
	self assert: usuario devolverRespuestasDeSusPreguntas size equals: 3
]

{ #category : #tests }
UsuarioTest >> testEliminarPregunta [
	| unaPregunta |
	unaPregunta := usuario
		agregarPreguntaConTopicos: topicos
		conTitulo: 'Como declaro una variable en php?'
		conDescripcion: 'Eso.'.
	self assert: usuario obtenerPreguntasRealizadas size equals: 1.
	self
		assert: (usuario obtenerPreguntasRealizadas includes: unaPregunta)
		equals: true.
	usuario eliminarPregunta: unaPregunta.
	self assert: usuario obtenerPreguntasRealizadas size equals: 0.
	self assert: (usuario obtenerPreguntasRealizadas includes: unaPregunta) equals: false
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
