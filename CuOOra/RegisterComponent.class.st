Class {
	#name : #RegisterComponent,
	#superclass : #AccessComponent,
	#category : #'CuOOra-UI-Seaside'
}

{ #category : #rendering }
RegisterComponent >> registerYLogin [
	| nuevoUsuario |
	nuevoUsuario:= Usuario conNombre: usuario conContrasenia: password.
	self model agregarUsuario: nuevoUsuario.
	self proceedWith: nuevoUsuario
]

{ #category : #rendering }
RegisterComponent >> renderButtonsOn: aCanvas [
self renderSignUpButtonOn:aCanvas
]

{ #category : #rendering }
RegisterComponent >> renderInputElementsOn: aCanvas [
	super renderInputElementsOn: aCanvas
]

{ #category : #rendering }
RegisterComponent >> renderSignUpButtonOn:aCanvas [
	aCanvas submitButton 
	callback: [ self registerYLogin ];
	with: 'Registrarme'
]
