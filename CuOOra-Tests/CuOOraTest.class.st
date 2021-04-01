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
	"Hooks that subclasses may override to define the fixture of test."

	cuOOra := CuOOra new.
	topicos := Set new.
	topicos2 := Set new.
	usuarios := Set new.
	topico1 := Topico conNombre: 'Php' conDescripcion: 'Oldie but goldie'.
	topico2 := Topico
		conNombre: 'Ruby'
		conDescripcion: 'Shine like a gem'.
	topicos add: topico1.
	topicos2 add: topico2.
	usuario := cuOOra
		crearUsuarioConNombre: 'Codubi'
		conContrasenia: 'Nova6'.
	usuario2 := cuOOra crearUsuarioConNombre: 'Pepe' conContrasenia: '123456'.
	usuario3 := cuOOra crearUsuarioConNombre: 'Ay no c' conContrasenia: '654321'.
	usuario4 := cuOOra crearUsuarioConNombre: 'Ay si c' conContrasenia: '1234567'
]

{ #category : #tests }
CuOOraTest >> testCalcularPuntajeDeUsuario [
	| pregunta1 pregunta2 pregunta3 pregunta4 |
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
	pregunta1
		agregarRespuestaConTexto: 'Ay... no se'
		conUsuario: usuario2.
	pregunta1
		agregarRespuestaConTexto: 'Js, el mas chad'
		conUsuario: usuario3.
	pregunta3
		agregarRespuestaConTexto: 'Desde la pagina oficial'
		conUsuario: usuario.
	pregunta4
		agregarRespuestaConTexto: 'En donde? Github? Git push, si es por hosting decinos en donde'
		conUsuario: usuario.
	self assert: (cuOOra calcularPuntajeDeUsuario: usuario) equals: 140.
	pregunta2 agregarLike: usuario2.
	pregunta2 agregarLike: usuario3.
	pregunta1 agregarDislike: usuario3.
	pregunta3 obtenerRespuestas first agregarLike: usuario2.
	self assert: (cuOOra calcularPuntajeDeUsuario: usuario) equals: 142
]

{ #category : #tests }
CuOOraTest >> testObtenerPreguntasDeTopico [
	usuario
		agregarPreguntaConTopicos: topicos
			conTitulo: 'Como instalar php?'
			conDescripcion: 'Eso';
		agregarPreguntaConTopicos: topicos2
			conTitulo: 'Ruby en 2021?'
			conDescripcion: 'Garpa?'.
	usuario2
		agregarPreguntaConTopicos: topicos
		conTitulo: 'Php vs JS?'
		conDescripcion: 'Cual es mejor?'.
	self
		assert: (cuOOra obtenerPreguntasDeTopico: topicos) size
		equals: 2
]

{ #category : #tests }
CuOOraTest >> testObtenerPreguntasRelevantesDeUsuario [
	| usuarioT |
	usuarioT := cuOOra
		crearUsuarioConNombre: 'UserTest'
		conContrasenia: '1234567'.
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
	usuarioT
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
		equals: 4
]

{ #category : #tests }
CuOOraTest >> testObtenerRespuestasDeUsuario [
	| pregunta1 pregunta2 pregunta3 pregunta4 |
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
	pregunta1
		agregarRespuestaConTexto: 'Ay... no se'
		conUsuario: usuario2.
	pregunta1
		agregarRespuestaConTexto: 'Js, el mas chad'
		conUsuario: usuario3.
	pregunta3
		agregarRespuestaConTexto: 'Desde la pagina oficial'
		conUsuario: usuario.
	pregunta4
		agregarRespuestaConTexto: 'En donde? Github? Git push, si es por hosting decinos en donde'
		conUsuario: usuario.
	self assert: (cuOOra obtenerRespuestasDeUsuario: usuario) size equals: 2
]
