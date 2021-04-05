Class {
	#name : #Usuario,
	#superclass : #Object,
	#instVars : [
		'nombre',
		'contrasenia',
		'fechaCreacion',
		'horaCreacion',
		'seguidos',
		'topicosInteres',
		'preguntas'
	],
	#category : #'CuOOra-Model'
}

{ #category : #'instance creation' }
Usuario class >> conNombre: unNombre conContrasenia: unaContrasenia [
	^ self new
		conNombre: unNombre
		conContrasenia: unaContrasenia; yourself
]

{ #category : #accessing }
Usuario >> agregarPregunta:unaPregunta [
preguntas add:unaPregunta.
]

{ #category : #accessing }
Usuario >> agregarPreguntaConTopicos: topicos conTitulo: unTitulo conDescripcion: unaDescripcion [
	| preguntaNueva |
	preguntaNueva := Pregunta
		conTopico: topicos
		conTitulo: unTitulo
		conDescripcion: unaDescripcion.
	preguntas add: preguntaNueva.
	^preguntaNueva.
]

{ #category : #accessing }
Usuario >> agregarUsuarioEnSeguidos:unUsuario [
seguidos add: unUsuario .
]

{ #category : #accessing }
Usuario >> conNombre: unNombre conContrasenia: unaContrasenia [
	nombre := unNombre.
	contrasenia := unaContrasenia
]

{ #category : #accessing }
Usuario >> contrasenia [
^contrasenia 
]

{ #category : #accessing }
Usuario >> devolverPreguntasConTopico: unosTopicos [
	^ (self obtenerPreguntasRealizadas
		select: [ :pregunta | pregunta tieneTopicoBuscado: unosTopicos ])
]

{ #category : #accessing }
Usuario >> devolverRespuestasDeSusPreguntas [
	^ (self obtenerPreguntasRealizadas
		flatCollect: [ :pregunta | pregunta obtenerRespuestas ])
]

{ #category : #accessing }
Usuario >> devolverSeguidos [
^ seguidos
]

{ #category : #accessing }
Usuario >> devolverTopicosInteres [
^topicosInteres
]

{ #category : #accessing }
Usuario >> eliminarPregunta: unaPregunta [
	"aca hay que hacer algo en preguntas para eliminar las respuestas"
	preguntas remove: unaPregunta
]

{ #category : #initialize }
Usuario >> initialize [
	seguidos := OrderedCollection new.
	preguntas := OrderedCollection new.
	topicosInteres := Set new
]

{ #category : #accessing }
Usuario >> nombre [
^nombre
]

{ #category : #accessing }
Usuario >> obtenerPreguntasRealizadas [
	^ preguntas asSortedCollection: [ :a :b | a hora < b hora ]
]

{ #category : #accessing }
Usuario >> registrarTopicoInteres: topicos [
	 topicosInteres addAll: topicos
]
