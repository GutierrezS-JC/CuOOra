Class {
	#name : #CuOOraTest,
	#superclass : #TestCase,
	#instVars : [
		'usuarios',
		'cuOOra',
		'topicos',
		'topicos2',
		'topico1',
		'topico2',
		'usuario',
		'usuario2',
		'usuario3',
		'usuario4',
		'preguntasUsuario'
	],
	#category : #'CuOOra-Tests'
}

{ #category : #running }
CuOOraTest >> setUp [
	"Datos y objetos que usaremos en los metodos tests "
	
	"Creamos e inicializamos los objetos definidos en las VI"
	cuOOra := CuOOra new.
	topicos := Set new.
	topicos2 := Set new.
	usuarios := Set new.
	"Creamos los topicos individuales"
	topico1 := Topico conNombre: 'Php' conDescripcion: 'Oldie but goldie'.
	topico2 := Topico
		conNombre: 'Ruby'
		conDescripcion: 'Shine like a gem'.
	"Cargamos los topicos en colecciones ya que nuestras preguntas esperan recibir una coleccion con n topicos"
	topicos add: topico1.
	topicos2 add: topico2.
	"Creamos los usuarios que usaremos en los tests"
	usuario := Usuario conNombre: 'Codubi' conContrasenia: 'Nova6'.
	usuario2 := Usuario conNombre: 'Pepe' conContrasenia: '123456'.
	usuario3 := Usuario conNombre: 'Ay no c' conContrasenia: '654321'.
	usuario4 := Usuario conNombre: 'Ay si c' conContrasenia: '1234567'.
	"Agregamos los usuarios al sistema"
	cuOOra agregarUsuario: usuario.
	cuOOra agregarUsuario: usuario2.
	cuOOra agregarUsuario: usuario3.
	cuOOra agregarUsuario: usuario4
]

{ #category : #tests }
CuOOraTest >> testCalcularPuntajeDeUsuario [
	"Para calcular el puntaje del usuario debemos esperar la sumatoria tanto de preguntas como respuestas realizadas y la diferencia entre likes y dislikes de sus interacciones. Se debe considerar el hecho de que un usuario no puede sumar puntos por responder a su misma pregunta"

	| pregunta1 pregunta2 pregunta3 pregunta4 |
	"Creacion de preguntas"
	pregunta1 := usuario
		agregarPreguntaConTopicos: topicos
		conTitulo: 'Php o Js?'
		conDescripcion: 'A ver, debatan'.
	pregunta2 := usuario
		agregarPreguntaConTopicos: topicos
		conTitulo: 'Como declarar variables en php?'
		conDescripcion: 'Eso.'.
	pregunta3 := usuario2
		agregarPreguntaConTopicos: topicos
		conTitulo: 'Como descargar php?'
		conDescripcion: 'Eso'.
	pregunta4 := usuario3
		agregarPreguntaConTopicos: topicos2
		conTitulo: 'Como subo un proyecto de RoR?'
		conDescripcion: 'Necesito ayuda'.
	"Agreamos respuestas a las preguntas previamente creadas"
	pregunta1
		agregarRespuesta: (Respuesta conContenido: 'Ay... no se' conUsuario: usuario2).
	pregunta1
		agregarRespuesta: (Respuesta conContenido: 'Js, el mas chad' conUsuario: usuario3).
	pregunta3
		agregarRespuesta:
			(Respuesta conContenido: 'Desde la pagina oficial' conUsuario: usuario).
	pregunta4
		agregarRespuesta:
			(Respuesta
				conContenido: 'En donde? Github? Git push, si es por hosting decinos en donde'
				conUsuario: usuario).
	pregunta4
		agregarRespuesta: (Respuesta conContenido: 'Bueno me calmo' conUsuario: usuario).
	"Verificamos las afirmaciones, notar que un usuario al agregar una respuesta a su misma pregunta no suma puntos"
	self assert: (cuOOra calcularPuntajeDeUsuario: usuario) equals: 190.
	pregunta2 agregarLike: usuario2.
	pregunta2 agregarLike: usuario3.
	pregunta1 agregarDislike: usuario3.
	pregunta3 obtenerRespuestas first agregarLike: usuario2.
	self assert: (cuOOra calcularPuntajeDeUsuario: usuario) equals: 192.
	pregunta1
		agregarRespuesta: (Respuesta conContenido: 'Prueba pregunta' conUsuario: usuario).
	self assert: (cuOOra calcularPuntajeDeUsuario: usuario) equals: 192
]

{ #category : #tests }
CuOOraTest >> testObtenerPreguntasDeTopico [
	"Obtiene todas las preguntas presentes en el sistema correspondientes a un topico"

	| pregunta |
	usuario
		agregarPreguntaConTopicos: topicos
			conTitulo: 'Como instalar php?'
			conDescripcion: 'Eso';
		agregarPreguntaConTopicos: topicos2
			conTitulo: 'Ruby en 2021?'
			conDescripcion: 'Garpa?'.
	pregunta := usuario2
		agregarPreguntaConTopicos: topicos
		conTitulo: 'Php vs JS?'
		conDescripcion: 'Cual es mejor?'.
	self
		assert: (cuOOra obtenerPreguntasDeTopico: topicos) size
		equals: 2.
	self
		assert: ((cuOOra obtenerPreguntasDeTopico: topicos) includes: pregunta)
		equals: true
]

{ #category : #tests }
CuOOraTest >> testObtenerPreguntasRelevantesDeUsuario [
	"Obtiene las preguntas reelvantes indicadas para un usuario. Esto es, obetener las preguntas de acuerdo a los usuarios y topicos que el usuario sigue"

	| usuarioRelevante preguntaRelevante |
	usuarioRelevante := Usuario
		conNombre: 'UserTest'
		conContrasenia: '1234567'.
	cuOOra agregarUsuario: usuarioRelevante.
	usuario2
		agregarPreguntaConTopicos: topicos
			conTitulo: 'Php o Js?'
			conDescripcion: 'A ver, debatan';
		agregarPreguntaConTopicos: topicos
			conTitulo: 'Como declarar variables en php?'
			conDescripcion: 'Eso.'.
	usuario3
		agregarPreguntaConTopicos: topicos
		conTitulo: 'Como descargar php?'
		conDescripcion: 'Eso'.
	preguntaRelevante := usuarioRelevante
		agregarPreguntaConTopicos: topicos2
		conTitulo: 'Como subo un proyecto de RoR?'
		conDescripcion: 'Necesito ayuda'.
	usuario
		agregarUsuarioEnSeguidos: usuario2;
		agregarUsuarioEnSeguidos: usuario3.
	usuario registrarTopicoInteres: topicos2.
	preguntasUsuario := cuOOra
		obtenerPreguntasRelevantesDeUsuario: usuario.
	self
		assert: (cuOOra obtenerPreguntasRelevantesDeUsuario: usuario) size
		equals: 4.
	self
		assert:
			((cuOOra obtenerPreguntasRelevantesDeUsuario: usuario)
				includes: preguntaRelevante)
		equals: true
]

{ #category : #tests }
CuOOraTest >> testObtenerRespuestasDeUsuario [
	| pregunta1 pregunta3 pregunta4 respuestaDeUsuario |
	pregunta1 := usuario
		agregarPreguntaConTopicos: topicos
		conTitulo: 'Php o Js?'
		conDescripcion: 'A ver, debatan'.
	pregunta3 := usuario2
		agregarPreguntaConTopicos: topicos
		conTitulo: 'Como descargar php?'
		conDescripcion: 'Eso'.
	pregunta4 := usuario3
		agregarPreguntaConTopicos: topicos2
		conTitulo: 'Como subo un proyecto de RoR?'
		conDescripcion: 'Necesito ayuda'.
	pregunta1
		agregarRespuesta: (Respuesta conContenido: 'Ay... no se' conUsuario: usuario2).
	pregunta1
		agregarRespuesta: (Respuesta conContenido: 'Js, el mas chad' conUsuario: usuario3).
	"Variable auxiliar para poder comprobar que el metodo devuelve preguntas del usuario"
	respuestaDeUsuario := Respuesta
		conContenido: 'Desde la pagina oficial'
		conUsuario: usuario.
	pregunta3 agregarRespuesta: respuestaDeUsuario.
	pregunta4
		agregarRespuesta:
			(Respuesta
				conContenido: 'En donde? Github? Git push, si es por hosting decinos en donde'
				conUsuario: usuario).
	self
		assert: (cuOOra obtenerRespuestasDeUsuario: usuario) size
		equals: 2.
	self
		assert:
			((cuOOra obtenerRespuestasDeUsuario: usuario)
				includes: respuestaDeUsuario)
		equals: true
]

{ #category : #tests }
CuOOraTest >> testObtenerRespuestasDeUsuarioParaPuntaje [
	"Devuelve las respuestas de un usuario, se usa para el calculo del puntaje. Esto es, no toma en cuenta las respuestas correspondientea a una misma pregunta "

	| pregunta1 pregunta2 respuestaDeUsuario |
	pregunta1 := usuario
		agregarPreguntaConTopicos: topicos
		conTitulo: 'Php o Js?'
		conDescripcion: 'A ver, debatan'.
	pregunta2 := usuario2
		agregarPreguntaConTopicos: topicos
		conTitulo: 'Como declarar variables en php?'
		conDescripcion: 'Eso.'.
	"Uso de variable auxiliar para poder guardar la respuesta y poder comprobar que el metodo devuelve preguntas del 	usuario"
	respuestaDeUsuario := Respuesta
		conContenido: 'Ay... no se'
		conUsuario: usuario.
	pregunta1 agregarRespuesta: respuestaDeUsuario.
	pregunta1
		agregarRespuesta:
			(Respuesta
				conContenido: 'Js por que es el futuro nene'
				conUsuario: usuario2).
	pregunta2
		agregarRespuesta:
			(Respuesta
				conContenido: 'Depende que variable pa'
				conUsuario: usuario3).
	pregunta2
		agregarRespuesta: (Respuesta conContenido: 'Con un $' conUsuario: usuario2).
	pregunta2
		agregarRespuesta:
			(Respuesta
				conContenido: 'io ke se no soi cientifiko'
				conUsuario: usuario).
	pregunta2
		agregarRespuesta:
			(Respuesta
				conContenido: 'solo se que no se debe poner const'
				conUsuario: usuario).
	pregunta2
		agregarRespuesta: (Respuesta conContenido: 'prueba de respuesta 4' conUsuario: usuario).
	self
		assert: (cuOOra obtenerRespuestasDeUsuarioParaPuntaje: usuario) size
		equals: 3.
	self
		assert:
			((cuOOra obtenerRespuestasDeUsuarioParaPuntaje: usuario)
				includes: respuestaDeUsuario)
		equals: false
]
