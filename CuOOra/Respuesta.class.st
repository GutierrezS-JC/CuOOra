Class {
	#name : #Respuesta,
	#superclass : #Publicacion,
	#instVars : [
		'contenido',
		'usuario'
	],
	#category : #'CuOOra-Model'
}

{ #category : #'instance creation' }
Respuesta class >> conContenido: unContenido conUsuario: unUsuario [
	^ self new conContenido: unContenido conUsuario: unUsuario
]

{ #category : #accessing }
Respuesta >> conContenido: unContenido conUsuario: unUsuario [
	contenido := unContenido.
	usuario := unUsuario.
]

{ #category : #accessing }
Respuesta >> contenido [
^contenido
]

{ #category : #accessing }
Respuesta >> devolverPuntosTotales [
	^ self calcularPuntaje  + 50
]

{ #category : #accessing }
Respuesta >> perteneceA: unUsuario [
	^ unUsuario = usuario
]
