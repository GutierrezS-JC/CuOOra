Class {
	#name : #PublicacionTest,
	#superclass : #TestCase,
	#instVars : [
		'pregunta',
		'pregunta2',
		'respuesta',
		'respuesta2',
		'topicos',
		'topico1',
		'usuario1',
		'usuario2'
	],
	#category : #'CuOOra-Tests'
}

{ #category : #running }
PublicacionTest >> setUp [
	"Datos y objetos que usaremos en los metodos tests "

	"Creamos e inicializamos los objetos definidos en las VI"

	topico1 := Topico
		conNombre: 'Javascript'
		conDescripcion: 'El lenguaje de la web'.
	usuario1 := Usuario conNombre: 'Codubi' conContrasenia: 'Nova6'.
	usuario2 := Usuario conNombre: 'Pepe' conContrasenia: 'Pepe123'.
	topicos := OrderedCollection new.
	topicos add: topico1.
	pregunta := Pregunta
		conTopico: topicos
		conTitulo: 'Javascript vs PHP'
		conDescripcion:
			'The Chad Javascript vs the Oldie Php. Para mi el tema ya no tiene discusion'
		conUsuario: usuario1.
	pregunta2 := Pregunta
		conTopico: topicos
		conTitulo: 'Javascript es muy confuso?'
		conDescripcion: 'Nada, solo eso'
		conUsuario: usuario2.
	respuesta := Respuesta
		conContenido: 'Han domado, han domado'
		conUsuario: usuario1.
	respuesta2 := Respuesta
		conContenido: 'No Han domado, no han domado'
		conUsuario: usuario2
]

{ #category : #tests }
PublicacionTest >> testAgregarDislike [
	"Este test permite verificar si se realizo con exito el agregar un like o un dislike a una publicacion (tanto pregunta como respuesta)"

	pregunta agregarLike: usuario1.
	pregunta agregarDislike: usuario1.
	pregunta2
		agregarDislike: usuario1;
		agregarDislike: usuario2.
	respuesta agregarDislike: usuario1.
	respuesta agregarDislike: usuario2.
	self assert: pregunta cantidadDislikes equals: 1.
	self assert: pregunta2 cantidadDislikes equals: 2.
	self assert: respuesta cantidadLikes equals: 0.
	self assert: respuesta cantidadDislikes equals: 2
]

{ #category : #tests }
PublicacionTest >> testAgregarLike [
	pregunta agregarDislike: usuario1.
	pregunta agregarLike: usuario1.
	pregunta2
		agregarLike: usuario1;
		agregarLike: usuario2.
	respuesta agregarLike: usuario1.
	respuesta agregarLike: usuario2.
	self assert: pregunta cantidadLikes equals: 1.
	self assert: pregunta2 cantidadLikes equals: 2.
		self assert: respuesta cantidadDislikes equals: 0.
	self assert: respuesta cantidadLikes equals: 2
]

{ #category : #tests }
PublicacionTest >> testBuscarDislikeYBorrar [
	"Un usuario no puede tener simultaneamente tanto like como dislike en una publicacion. Este test verifica que un usuario al agregar un like despues de haber agregado un dislike, elimine a este ultimo y agrega la nueva reaccion"

	pregunta agregarDislike: usuario1.
	pregunta agregarDislike: usuario2.
	self assert: pregunta cantidadDislikes equals: 2.
	pregunta agregarLike: usuario1.
	self assert: pregunta cantidadDislikes equals: 1
]

{ #category : #tests }
PublicacionTest >> testBuscarLikeYBorrar [
	"Un usuario no puede tener simultaneamente tanto like como dislike en una publicacion. Este test verifica que un usuario al agregar un dislike despues de haber agregado un like, elimine a este ultimo y agrega la nueva reaccion"

	pregunta agregarLike: usuario1.
	pregunta agregarLike: usuario2.
	self assert: pregunta cantidadLikes equals: 2.
	pregunta agregarDislike: usuario1.
	self assert: pregunta cantidadLikes equals: 1
]

{ #category : #tests }
PublicacionTest >> testCalcularPuntaje [
	"Este test verifica el puntaje total de una publicacion. El calculo se realiza sacando la diferencia entre likes y 	dislikes"

	pregunta agregarDislike: usuario1.
	pregunta agregarLike: usuario1.
	pregunta2
		agregarLike: usuario1;
		agregarLike: usuario2.
	respuesta agregarDislike: usuario1.
	respuesta2
		agregarLike: usuario1;
		agregarLike: usuario2.
	self assert: pregunta calcularPuntaje equals: 1.
	self assert: pregunta2 calcularPuntaje equals: 2.
	self assert: respuesta calcularPuntaje equals: -1.
	self assert: respuesta2 calcularPuntaje equals: 2
]
