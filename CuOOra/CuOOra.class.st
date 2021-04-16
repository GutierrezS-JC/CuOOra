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
	^ soleInstance
		ifNil: [  soleInstance := self new initializeWithQuestions ]
]

{ #category : #'instance creation' }
CuOOra class >> soleInstanceNoData [
	^ soleInstance ifNil: [ soleInstance:=self new. ]

]

{ #category : #accessing }
CuOOra >> agregarTopicos: unaColeccionDeTopicos [
	topicos addAll:unaColeccionDeTopicos .
]

{ #category : #accessing }
CuOOra >> agregarUsuario: unUsuario [
	^ usuarios
		detect:
			[ :usuario | usuario nombre = unUsuario nombre ]
		ifFound: [ nil ] ifNone:[ usuarios add:unUsuario ].

]

{ #category : #accessing }
CuOOra >> calcularPuntajeDeUsuario: unUsuario [
	| preguntasUsuario respuestasUsuario |
	preguntasUsuario := unUsuario obtenerPreguntasRealizadas.
	respuestasUsuario := self obtenerRespuestasDeUsuarioParaPuntaje: unUsuario.
	^ (preguntasUsuario
		sumNumbers: [ :pregunta | pregunta devolverPuntosTotales ])
		+
			(respuestasUsuario
				sumNumbers: [ :respuesta | respuesta devolverPuntosTotales ])
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
	usuarios := Set new.
	topicos := Set new
]

{ #category : #initialize }
CuOOra >> initializeWithQuestions [
	| usuarioPedro usuarioDiego usuarioJuan usuarioGonza usuarioAyNoC topicos1 topicos2 topicos3 topicoOO1 topicoTest topicoSmalltalk topicoJs topicoPhp coleccionTopicos preguntaDummyPedro preguntaDummyDiego preguntaDummyGonza |
	"Inicializacion de colecciones"
	coleccionTopicos := Set new.
	topicos1 := OrderedCollection new.
	topicos2 := OrderedCollection new.
	topicos3 := OrderedCollection new.

	"Creando Topicos"
	topicoOO1 := Topico
		conNombre: 'OO1'
		conDescripcion: 'Orientacion a Objetos 1'.
	topicoTest := Topico
		conNombre: 'Test de unidad'
		conDescripcion: 'Para testear'.
	topicoSmalltalk := Topico
		conNombre: 'Smalltalk'
		conDescripcion: 'Don`t ask me, Im just an Object'.
	topicoJs:=Topico conNombre: 'Javascript' conDescripcion: 'ChadScript'.
	topicoPhp :=Topico conNombre: 'PHP' conDescripcion: 'Oldie but goldie'.
	"Agregar topicos"
	topicos1 add:topicoOO1;add:topicoTest.
	topicos2 add: topicoOO1;add:topicoSmalltalk.
	topicos3 add:topicoJs; add:topicoPhp.
	"Usarios"
	usuarioPedro := Usuario
		conNombre: 'pedro@cuoora.com'
		conContrasenia: 'pedro@cuoora.com'.
	usuarioDiego := Usuario
		conNombre: 'diego@cuoora.com'
		conContrasenia: 'diego@cuoora.com'.
	usuarioJuan := Usuario
		conNombre: 'juan@cuoora.com'
		conContrasenia: 'juan@cuoora.com'.
	usuarioGonza := Usuario
		conNombre: 'Gonza_Chad'
		conContrasenia: '123gonza321'.
	usuarioAyNoC := Usuario
		conNombre: 'Ay_no_C'
		conContrasenia: '123aynoce321'.

	"Relacion de seguir"
	usuarioJuan agregarUsuarioEnSeguidos: usuarioPedro.
	usuarioPedro agregarUsuarioEnSeguidos: usuarioJuan.

	"Creacion de preguntas"
	preguntaDummyPedro := usuarioPedro
		agregarPreguntaConTopicos: topicos1
		conTitulo: '¿Para que sirve el metodo SetUp?'
		conDescripcion: 'Eso. '.
	preguntaDummyDiego := usuarioDiego
		agregarPreguntaConTopicos: topicos2
		conTitulo: '¿Que significa #messageNoUndertood?'
		conDescripcion:
			'Estoy aprendiendo a usar Smalltalk, usando Pharo 8. Viendo el tutorial que subio el profe mas o menos pude entender las cuestiones basicas de la sintaxis del lenguaje. 
		Despues de eso no entiendo nada. Podria ser que este intentando pasar algun mensaje que no entiende el objeto receptor? Intente con otras clases pero me paso lo mismo o el resultado no era el esperado. En los comentarios dejo el codigo.'.
	preguntaDummyGonza := usuarioGonza
		agregarPreguntaConTopicos: topicos3
		conTitulo: 'Urgente, necesito ayuda con PHP por favor!!!!'
		conDescripcion:
			'Rapido! Llamen a una ambulancia para PHP. Ni siquiera con ayuda de Laravel pudieron parar a Javascript y su amigo Node.'.
	"Algunas respuestas dummy"
	preguntaDummyPedro 
		agregarRespuesta: (Respuesta conContenido: 'Sirve para instanciar los objetos que son evaluados por el test en un unico metodo y que se ejecute siempre antes de cada test' conUsuario: usuarioDiego ).
	preguntaDummyDiego
		agregarRespuesta: (	
			Respuesta conContenido: 'Significa que el objeto que recibio el mensaje no encontro ningun metodo para ejecutar en respuesta' conUsuario: usuarioPedro).

	preguntaDummyGonza
		agregarRespuesta: (	Respuesta conContenido: 'Desde las profundidades de mi ser, lo único que puedo atinar a pensar, es que tus palabras poseen una calidad de veracidad y rigurosidad inmensamente grandes, mi cuerpo lo único que puede hacer es postrarse ante tu superioridad intelectual, no sin antes haberme percatado que vos, sin dudas has trascendido aquél dilema de los antiguos filósofos escépticos que pensaban que la verdad carecía de existencia.

Porque no existe ser en esta tierra que pueda repudiar tus dichos con ningún argumento tan válido como el tuyo, es evidente que has acertado al centro de la diana, liberándonos de los tiempos tan oscuros que nublaban nuestro ser y nos enmudecían, hoy la humanidad puede gritar al unísono:

GRACIAS POR TANTA VERDAD' conUsuario: usuarioAyNoC ).

	preguntaDummyGonza
		agregarRespuesta: (Respuesta conContenido: 'Disculpen, pero este es un foro serio. Dejemos el offtopic para otra ocasion. Comportense o voy a tener que llamar a los MOOODZ!' conUsuario: usuarioPedro ).
	self
		agregarUsuario: usuarioPedro;
		agregarUsuario: usuarioDiego;
		agregarUsuario: usuarioJuan;
		agregarUsuario: usuarioGonza;
		agregarUsuario: usuarioAyNoC.
	coleccionTopicos
		addAll: topicos1;
		addAll: topicos2;
		addAll: topicos3.
	self agregarTopicos: coleccionTopicos
]

{ #category : #accessing }
CuOOra >> obtenerPreguntasDeTopico: unosTopicos [
	^ (usuarios
		flatCollect: [ :usuario | usuario devolverPreguntasConTopico: unosTopicos ])asSortedCollection: [ :a :b | a fechaYHora > b fechaYHora ]
]

{ #category : #accessing }
CuOOra >> obtenerPreguntasRelevantesDeUsuario: unUsuario [
	| preguntasDeInteres topicosInteres |
	preguntasDeInteres := OrderedCollection new.
	preguntasDeInteres
		addAll:
			(unUsuario devolverSeguidos
				flatCollect: [ :usuario | usuario obtenerPreguntasRealizadas ]).
	topicosInteres := unUsuario devolverTopicosInteres.
	preguntasDeInteres
		addAll: (self obtenerPreguntasDeTopico: topicosInteres).
	preguntasDeInteres size <= 4
		ifTrue: [ ^ self ordenarPreguntas: preguntasDeInteres ]
		ifFalse: [ ^ (self ordenarPreguntas: preguntasDeInteres) first: 5 ]
]

{ #category : #accessing }
CuOOra >> obtenerRespuestasDeUsuario: unUsuario [
	| respuestasTotales |
	respuestasTotales := OrderedCollection new.
	respuestasTotales
		addAll:
			(usuarios
				flatCollect: [ :usuario | usuario devolverRespuestasDeSusPreguntas ]).
	^ respuestasTotales
		select: [ :respuesta | respuesta perteneceA: unUsuario ]
]

{ #category : #accessing }
CuOOra >> obtenerRespuestasDeUsuarioParaPuntaje: unUsuario [
	| respuestasTotales |
	respuestasTotales := OrderedCollection new.
	respuestasTotales
		addAll:
			(usuarios
				flatCollect: [ :usuario | usuario devolverRespuestasDeSusPreguntas ]).
	respuestasTotales
		removeAllFoundIn: unUsuario devolverMisRespuestasAMisPreguntas.
	^ respuestasTotales
		select: [ :respuesta | respuesta perteneceA: unUsuario ].
]

{ #category : #private }
CuOOra >> ordenarPreguntas: coleccionPreguntas [
	^ coleccionPreguntas
		asSortedCollection: [ :a :b | a fechaYHora > b fechaYHora ]
]

{ #category : #accessing }
CuOOra >> usersMatchingNamePart: stringABuscar [
	^ usuarios
		select:
			[ :each | each nombre asLowercase includesSubstring: stringABuscar  asLowercase ]
]
