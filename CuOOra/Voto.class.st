Class {
	#name : #Voto,
	#superclass : #Object,
	#instVars : [
		'fecha',
		'hora',
		'usuario'
	],
	#category : #CuOOra
}

{ #category : #'instance creation' }
Voto class >> conUsuario: unUsuario [
^self new conUsuario: unUsuario 
]

{ #category : #accessing }
Voto >> conUsuario: unUsuario [
	usuario := unUsuario.
	fecha := Date today.
	hora:= Time now.
]

{ #category : #accessing }
Voto >> realizadoPor:unUsuario [
^  usuario == unUsuario
]
