Class {
	#name : #HomeComponent,
	#superclass : #WAComponent,
	#instVars : [
		'header'
	],
	#category : #'CuOOra-UI-Seaside'
}

{ #category : #rendering }
HomeComponent class >> renderContentOn: aCanvas [
	aCanvas heading: 'Welcome ' , self session user name.
]

{ #category : #hooks }
HomeComponent >> children [
^ OrderedCollection with: header
]

{ #category : #callbacks }
HomeComponent >> createQuestion [
	self call: NewQuestionComponent new.
]

{ #category : #initialize }
HomeComponent >> initialize [
	super initialize.
	header := CuOOraHeaderComponent new
]

{ #category : #model }
HomeComponent >> model [
^CuOOra soleInstance
]

{ #category : #rendering }
HomeComponent >> renderContentOn: aCanvas [
	aCanvas render: header.
	aCanvas heading: 'Welcome ' , self session user nombre.
	self renderQuestionsOn: aCanvas.
	self renderLogoutButtonOn: aCanvas
]

{ #category : #rendering }
HomeComponent >> renderLogoutButtonOn: aCanvas [
	aCanvas
		paragraph: [ aCanvas anchor
				callback: [ self answer ];
				with: [ aCanvas button with: 'Logout' ] ]
]

{ #category : #rendering }
HomeComponent >> renderQuestionsOn: aCanvas [
	aCanvas heading
		level: 2;
		with: 'Preguntas'.
	self model devolverUsuarios
		do: [ :each | 
			each obtenerPreguntasRealizadas
				do: [ :pregunta | 
					aCanvas
						paragraph: [ aCanvas text: pregunta titulo.
							aCanvas
								paragraph: [ aCanvas text: 'Realizada por'.
									aCanvas space.
									aCanvas text: each nombre.
									aCanvas space.
									aCanvas text: '|'.
									aCanvas space.
									aCanvas text: pregunta obtenerRespuestas size.
									aCanvas space.
									aCanvas text: 'respuestas' ].
							aCanvas
								paragraph: [ aCanvas text: pregunta cantidadLikes.
									aCanvas space.
									aCanvas text: 'likes | '.
									aCanvas text: pregunta cantidadDislikes.
									aCanvas text: ' dislikes' ] ].
					aCanvas horizontalRule ] ].
	aCanvas
		unorderedList: [ (self model obtenerPreguntasRelevantesDeUsuario: self session user)
				do: [ :each | aCanvas listItem: each text ] ].
	aCanvas anchor
		callback: [ self createQuestion ];
		with: [ aCanvas button: 'Nueva Pregunta' ]
]

{ #category : #styles }
HomeComponent >> style [ 
^'
	*{
		margin:0;
		padding:0;
		box-sizing:border-box;
	}
'
]
