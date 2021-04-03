Class {
	#name : #Pregunta,
	#superclass : #Publicacion,
	#instVars : [
		'titulo',
		'descripcion',
		'respuestas',
		'topicos'
	],
	#category : #'CuOOra-Model'
}

{ #category : #'instance creation' }
Pregunta class >> conTopico: unTopico conTitulo: unTitulo conDescripcion: unaDescripcion [ 
^ self new conTopico: unTopico conTitulo:unTitulo  conDescripcion: unaDescripcion 
]

{ #category : #accessing }
Pregunta >> agregarRespuestaConTexto: unTexto conUsuario: unUsuario [
	| nuevaRespuesta |
	nuevaRespuesta := Respuesta
		conContenido: unTexto
		conUsuario: unUsuario.
	respuestas add:nuevaRespuesta .
	^ nuevaRespuesta
]

{ #category : #accessing }
Pregunta >> conTopico: unTopico conTitulo: unTitulo conDescripcion: unaDescripcion [
	topicos addAll: unTopico.
	titulo := unTitulo.
	descripcion := unaDescripcion
]

{ #category : #accessing }
Pregunta >> devolverPuntosTotales [
	^ self calcularPuntaje  + 20
]

{ #category : #initialize }
Pregunta >> initialize [
	super initialize.
	topicos := Set new.
	respuestas := OrderedCollection new
]

{ #category : #accessing }
Pregunta >> obtenerRespuestas [
	^ respuestas
		asSortedCollection: [ :a :b | a calcularPuntaje > b calcularPuntaje]
]

{ #category : #accessing }
Pregunta >> tieneTopicoBuscado: unosTopicos [
	^ topicos includesAny: unosTopicos
]

{ #category : #accessing }
Pregunta >> titulo [
^titulo
]
