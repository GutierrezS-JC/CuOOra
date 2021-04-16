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
Pregunta class >> conTopico: unTopico conTitulo: unTitulo conDescripcion: unaDescripcion conUsuario:unUsuario [
	^ self new
		conTopico: unTopico
		conTitulo: unTitulo
		conDescripcion: unaDescripcion
		conUsuario: unUsuario
]

{ #category : #accessing }
Pregunta >> agregarRespuesta: unaRespuesta [
	 respuestas add: unaRespuesta
]

{ #category : #accessing }
Pregunta >> conTopico: unosTopicos conTitulo: unTitulo conDescripcion: unaDescripcion conUsuario: unUsuario [
	topicos addAll: unosTopicos.
	titulo := unTitulo.
	descripcion := unaDescripcion.
	usuario := unUsuario
]

{ #category : #accessing }
Pregunta >> devolverDescripcion [
^descripcion 
]

{ #category : #accessing }
Pregunta >> devolverPuntosTotales [
	^ self calcularPuntaje  + 20
]

{ #category : #accessing }
Pregunta >> devolverTopicos [ 
^topicos
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
