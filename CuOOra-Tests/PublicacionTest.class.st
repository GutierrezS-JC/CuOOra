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
	"Hooks that subclasses may override to define the fixture of test."

	topico1 := Topico
		conNombre: 'Javascript'
		conDescripcion: 'El lenguaje de la web'.
	usuario1 := Usuario conNombre: 'Codubi' conContrasenia: 'Nova6'.
	usuario2 := Usuario conNombre: 'Pepe' conContrasenia: 'Pepe123'.
	topicos:= OrderedCollection new.
	topicos add: topico1.
	pregunta := Pregunta
		conTopico: topicos
		conTitulo: 'Javascript vs PHP'
		conDescripcion:
			'The Chad Javascript vs the Oldie Php. Para mi el tema ya no tiene discusion'.
	pregunta2 := Pregunta
		conTopico: topicos
		conTitulo: 'Javascript es muy confuso?'
		conDescripcion: 'Nada, solo eso'.
	respuesta := Respuesta
		conContenido: 'Han domado, han domado'
		conUsuario: usuario1.
	respuesta2 := Respuesta
		conContenido: 'No Han domado, no han domado'
		conUsuario: usuario2
]

{ #category : #tests }
PublicacionTest >> testAgregarDislike [
	pregunta agregarLike: usuario1.
	pregunta agregarDislike: usuario1.
	pregunta2
		agregarDislike: usuario1;
		agregarDislike: usuario2.
	self assert: pregunta cantidadDislikes equals: 1.
	self assert: pregunta2 cantidadDislikes equals: 2
]

{ #category : #tests }
PublicacionTest >> testAgregarLike [
	pregunta agregarDislike: usuario1.
	pregunta agregarLike: usuario1.
	pregunta2
		agregarLike: usuario1;
		agregarLike: usuario2.
	self assert:  pregunta cantidadLikes equals: 1 .
	self assert: pregunta2 cantidadLikes equals: 2
]

{ #category : #tests }
PublicacionTest >> testBuscarDislikeYBorrar [
	pregunta agregarDislike: usuario1.
	pregunta agregarDislike: usuario2.
	self assert: (pregunta buscarDislikeYBorrar: usuario1) size equals: 1
]

{ #category : #tests }
PublicacionTest >> testBuscarLikeYBorrar [
	pregunta agregarLike: usuario1.
	self assert: (pregunta buscarLikeYBorrar: usuario1) size equals: 0
]

{ #category : #tests }
PublicacionTest >> testCalcularPuntaje [
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
