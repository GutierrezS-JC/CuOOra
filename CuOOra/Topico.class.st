Class {
	#name : #Topico,
	#superclass : #Object,
	#instVars : [
		'nombre',
		'descripcion'
	],
	#category : #CuOOra
}

{ #category : #'instance creation' }
Topico class >> conNombre: unNombre conDescripcion: unaDescripcion [ 
^self new conNombre: unNombre conDescripcion: unaDescripcion 
]

{ #category : #accessing }
Topico >> conNombre:unNombre conDescripcion:unaDescripcion [
nombre:=unNombre.
descripcion :=unaDescripcion 
]

{ #category : #accessing }
Topico >> descripcion [
^descripcion 
]

{ #category : #accessing }
Topico >> nombre [
^nombre
]
