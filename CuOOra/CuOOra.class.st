Class {
	#name : #CuOOra,
	#superclass : #Object,
	#instVars : [
		'usuarios',
		'topicos'
	],
	#category : #CuOOra
}

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

{ #category : #initialize }
CuOOra >> initialize [
	usuarios := OrderedCollection new.
	topicos := OrderedCollection new
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
