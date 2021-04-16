"
app := WAAdmin register: CuOOraComponent asApplicationAt: 'cuoora'.
app sessionClass: SessionWithUser
"
Class {
	#name : #CuOOraComponent,
	#superclass : #AccessComponent,
	#instVars : [
		'cuoora'
	],
	#category : #'CuOOra-UI-Seaside'
}

{ #category : #initialize }
CuOOraComponent class >> initialize [
	| app |
	app := WAAdmin register: self asApplicationAt: 'cuoora'.
	app sessionClass: SessionWithUser.
]

{ #category : #initialization }
CuOOraComponent >> initialize [
	super initialize.
	cuoora := CuOOra soleInstance
]

{ #category : #callbacks }
CuOOraComponent >> login [
(self model iniciarSesionConNombre: usuario conContrasenia: password) ifNotNil: [:user | self proceedWith: user ].
usuario:=nil.
password:=nil.
]

{ #category : #callbacks }
CuOOraComponent >> registrarNuevoUsuario [
self call: RegisterComponent new.
]

{ #category : #rendering }
CuOOraComponent >> renderButtonsOn: aCanvas [
	self renderSignInButtonOn: aCanvas.
	aCanvas horizontalRule.
	aCanvas paragraph id:'registerP';with: '¿No tenes una cuenta?'.
	self renderSignUpButtonOn: aCanvas
]

{ #category : #rendering }
CuOOraComponent >> renderSignInButtonOn: aCanvas [
	aCanvas submitButton
		class: 'btn btn-success';
		callback: [ self login ];
		with: 'Iniciar Sesion'
]

{ #category : #rendering }
CuOOraComponent >> renderSignUpButtonOn: aCanvas [
	aCanvas submitButton
		class: 'btn btn-primary';
		callback: [ self registrarNuevoUsuario ];
		with: 'Registrarme'
]
