Class {
	#name : #CuOOra,
	#superclass : #Object,
	#instVars : [
		'usuarios',
		'topicos'
	],
	#classInstVars : [
		'soleInstance'
	],
	#category : #'CuOOra-Model'
}

{ #category : #'instance creation' }
CuOOra class >> clearSoleInstance [
	soleInstance := nil
]

{ #category : #'instance creation' }
CuOOra class >> soleInstance [
	^ soleInstance ifNil: [ soleInstance := self new ]
]

{ #category : #accessing }
CuOOra >> agregarTopicoConNombre: unNombre conDescripcion: unaDescripcion [
	| nuevoTopico |
	nuevoTopico := Topico
		conNombre: unNombre
		conDescripcion: unaDescripcion.
	topicos add: nuevoTopico.
	^nuevoTopico.
]

{ #category : #accessing }
CuOOra >> agregarTopicos: unaColeccionDeTopicos [
	topicos addAll:unaColeccionDeTopicos .
]

{ #category : #accessing }
CuOOra >> agregarUsuario:unUsuario [
usuarios add:unUsuario .
]

{ #category : #accessing }
CuOOra >> calcularPuntajeDeUsuario: unUsuario [
	| preguntasUsuario respuestasUsuario |
	preguntasUsuario := unUsuario obtenerPreguntasRealizadas.
	respuestasUsuario := self obtenerRespuestasDeUsuario: unUsuario.
	^ (preguntasUsuario
		sumNumbers: [ :pregunta | pregunta devolverPuntosTotales  ])
		+
			(respuestasUsuario
				sumNumbers: [ :respuesta | respuesta devolverPuntosTotales  ])
]

{ #category : #accessing }
CuOOra >> crearUsuarioConNombre: unNombre conContrasenia: unaContrasenia [
	| usuarioNuevo |
	usuarioNuevo := Usuario
		conNombre: unNombre
		conContrasenia: unaContrasenia.
	usuarios add: usuarioNuevo.
	^usuarioNuevo
]

{ #category : #accessing }
CuOOra >> devolverPreguntas [
	^ ((usuarios
		flatCollect: [ :usuario | usuario obtenerPreguntasRealizadas ])
		asSortedCollection: [ :a :b | a fecha > b fecha ])
		asSortedCollection: [ :a :b | a hora > b hora ]
]

{ #category : #accessing }
CuOOra >> devolverTopicos [
^topicos
]

{ #category : #accessing }
CuOOra >> devolverUsuarios [
^usuarios
]

{ #category : #accessing }
CuOOra >> iniciarSesionConNombre: unNombre conContrasenia: unaContrasenia [
	^ usuarios
		detect:
			[ :usuario | usuario nombre = unNombre & (usuario contrasenia = unaContrasenia) ]
		ifNone: [ nil ]
]

{ #category : #initialize }
CuOOra >> initialize [
	usuarios := OrderedCollection new.
	topicos := OrderedCollection new.
	self initializeWithQuestions.
]

{ #category : #initialize }
CuOOra >> initializeWithQuestions [
	| usuario1 usuario2 usuario3 topicos1 topicos2 topicos3 coleccionTopicos |
	"Inicializacion de colecciones"
	coleccionTopicos := OrderedCollection new.
	topicos1 := OrderedCollection new.
	topicos2 := OrderedCollection new.
	topicos3 := OrderedCollection new.
	"Agregar topicos"
	topicos1
		add: (Topico conNombre: 'Php' conDescripcion: 'Oldie but goldie').
	topicos2
		add: (Topico conNombre: 'Javascript' conDescripcion: 'Chad web language').
	topicos3
		add: (Topico conNombre: 'Ruby on Rails' conDescripcion: 'Like a gem').
	"Usarios"
	usuario1 := Usuario conNombre: 'Codubi' conContrasenia: '123456'.
	usuario2 := Usuario conNombre: 'Ay no c' conContrasenia: '654321'.
	usuario3 := Usuario conNombre: 'Jeje ta bien' conContrasenia: '7890'.
	"Creacion de preguntas"
	usuario1
		agregarPreguntaConTopicos: topicos1
		conTitulo: 'Como declarar una variable en php?'
		conDescripcion: 'Eso. Aguante php'.
	usuario2
		agregarPreguntaConTopicos: topicos2
		conTitulo: 'Por que Javascript es el mejor lenguaje de programacion'
		conDescripcion: 'Para mi el tema ya no tiene discusion'.
	usuario3
		agregarPreguntaConTopicos: topicos3
		conTitulo: 'Como puedo hacer una API en RoR?'
		conDescripcion: 'Eso.'.
	self agregarUsuario: usuario1.
	self agregarUsuario: usuario2.
	self agregarUsuario: usuario3.
	topicos1 do: [ :topico | coleccionTopicos add: topico ].
	topicos2 do: [ :topico | coleccionTopicos add: topico ].
	topicos3 do: [ :topico | coleccionTopicos add: topico ].
	self agregarTopicos: coleccionTopicos
]

{ #category : #accessing }
CuOOra >> obtenerPreguntasDeTopico: unosTopicos [
	^ usuarios
		flatCollect: [ :usuario | usuario devolverPreguntasConTopico: unosTopicos ]
]

{ #category : #accessing }
CuOOra >> obtenerPreguntasRelevantesDeUsuario: unUsuario [
	| preguntasDeInteres topicosInteres |
	preguntasDeInteres := OrderedCollection new.
	preguntasDeInteres
		addAll:
			((unUsuario devolverSeguidos
				flatCollect: [ :usuario | usuario obtenerPreguntasRealizadas ])).
	topicosInteres := unUsuario devolverTopicosInteres.
	preguntasDeInteres
		addAll: (self obtenerPreguntasDeTopico: topicosInteres).
	^ preguntasDeInteres
]

{ #category : #accessing }
CuOOra >> obtenerRespuestasDeUsuario: unUsuario [
	| respuestasTotales |
	respuestasTotales := OrderedCollection new.
	respuestasTotales
		addAll:
			((usuarios
				flatCollect: [ :usuario | usuario devolverRespuestasDeSusPreguntas ])
				).
	^ respuestasTotales
		select: [ :respuesta | respuesta perteneceA: unUsuario ]
]
