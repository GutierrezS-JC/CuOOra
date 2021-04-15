Class {
	#name : #Publicacion,
	#superclass : #Object,
	#instVars : [
		'fechaYHora',
		'likes',
		'dislikes',
		'usuario'
	],
	#category : #'CuOOra-Model'
}

{ #category : #'instance creation' }
Publicacion class >> conUsuario: unUsuario [
	^ self new conUsuario: unUsuario
]

{ #category : #accessing }
Publicacion >> agregarDislike: unUsuario [
	
	self buscarLikeYBorrar: unUsuario.
	dislikes
		detect: [ :each | each realizadoPor: unUsuario ]
		ifNone: [ dislikes add: (Voto conUsuario: unUsuario) ]

]

{ #category : #accessing }
Publicacion >> agregarLike:unUsuario [

	self buscarDislikeYBorrar: unUsuario.
	likes detect: [ :voto | voto realizadoPor:  unUsuario ]
		ifNone: [likes add: (Voto conUsuario: unUsuario) ].
]

{ #category : #accessing }
Publicacion >> buscarDislikeYBorrar: unUsuario [
	 dislikes
		detect: [ :voto | voto realizadoPor: unUsuario ]
		ifFound: [ :dislike | dislikes remove: dislike ]
]

{ #category : #accessing }
Publicacion >> buscarLikeYBorrar: unUsuario [
	 likes
		detect: [ :voto | voto realizadoPor: unUsuario ]
		ifFound: [ :like | likes remove: like ]
]

{ #category : #accessing }
Publicacion >> calcularPuntaje [
	^ self cantidadLikes - self cantidadDislikes
]

{ #category : #accessing }
Publicacion >> cantidadDislikes [
	^ dislikes size
]

{ #category : #accessing }
Publicacion >> cantidadLikes [
	^ likes size
]

{ #category : #accessing }
Publicacion >> devolverPuntosTotales [
	^ self subclassResponsibility
]

{ #category : #accessing }
Publicacion >> devolverUsuarioCreador [
	^ usuario
]

{ #category : #accessing }
Publicacion >> fechaYHora [
^fechaYHora 
]

{ #category : #initialize }
Publicacion >> initialize [
	likes := OrderedCollection new.
	dislikes := OrderedCollection new.
	fechaYHora := DateAndTime now
]
