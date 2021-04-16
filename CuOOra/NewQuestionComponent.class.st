Class {
	#name : #NewQuestionComponent,
	#superclass : #ElementCreationComponent,
	#instVars : [
		'questionText',
		'questionTitle'
	],
	#category : #'CuOOra-UI-Seaside'
}

{ #category : #callbacks }
NewQuestionComponent >> cargarPregunta [
	questionTitle ifEmpty: [ ^ self ].
	questionText ifEmpty: [ ^ self ].
	topicsSelected ifEmpty: [ ^ self ].

	self session user
		agregarPreguntaConTopicos: topicsSelected
		conTitulo: questionTitle
		conDescripcion: questionText.
	self answer
]

{ #category : #hooks }
NewQuestionComponent >> children [
	^ OrderedCollection with: header
]

{ #category : #initialize }
NewQuestionComponent >> initialize [
	super initialize
]

{ #category : #accessing }
NewQuestionComponent >> questionText [
	^questionText 
]

{ #category : #accessing }
NewQuestionComponent >> questionText:aText [
questionText :=aText
]

{ #category : #accessing }
NewQuestionComponent >> questionTitle [
^questionTitle 
]

{ #category : #accessing }
NewQuestionComponent >> questionTitle:aText [
	questionTitle:= aText.
]

{ #category : #rendering }
NewQuestionComponent >> renderBottomSelectTopicOn: aCanvas [
	aCanvas div
		with: [ topicsSelected
				ifNotEmpty: [ aCanvas paragraph
						style: 'margin-top:.5rem';
						with: [ aCanvas text: 'Topicos Seleccionados'.
							aCanvas unorderedList
								style: 'margin-left:2.5rem';
								with: [ topicsSelected do: [ :topico | aCanvas listItem: topico nombre ] ] ] ] ]
]

{ #category : #rendering }
NewQuestionComponent >> renderMainContentOn: aCanvas [
	aCanvas div
		class: 'form-group';
		with: [ aCanvas heading
				level: 3;
				with: 'Titulo'.
			aCanvas textInput
				on: #questionTitle of: self;
				class: 'form-control';
				id: 'titulo' ].
	self renderTextAreaOn: aCanvas.
	self renderPreguntarButtonOn: aCanvas.
]

{ #category : #rendering }
NewQuestionComponent >> renderPreguntarButtonOn: aCanvas [
	aCanvas anchor
		with: [ aCanvas button
				callback: [ self cargarPregunta ];
				class: 'btn btn-success';
				with: 'Preguntar' ]
]

{ #category : #rendering }
NewQuestionComponent >> renderTextAreaOn: aCanvas [
	aCanvas div
		class: 'form-group';
		with: [ aCanvas heading
				level: 3;
				with: 'Descripcion'.
			(aCanvas textArea class: 'form-control'; on: #questionText of: self)
				columns: 80;
				rows: 5 ]
]

{ #category : #rendering }
NewQuestionComponent >> renderTopicosButtonsDisplayOn: aCanvas with: topico [
	(topicsSelected includes: topico)
		ifTrue: [ self renderDeleteFromSelectedButtonOn: aCanvas with: topico ]
		ifFalse: [ self renderAddToSelectedButtonOn: aCanvas with: topico ]

]
