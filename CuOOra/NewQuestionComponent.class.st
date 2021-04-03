Class {
	#name : #NewQuestionComponent,
	#superclass : #WAComponent,
	#instVars : [
		'questionText',
		'header'
	],
	#category : #'CuOOra-UI-Seaside'
}

{ #category : #hooks }
NewQuestionComponent >> children [
	^ OrderedCollection with: header
]

{ #category : #initialize }
NewQuestionComponent >> initialize [
	super initialize.
	header := CuOOraHeaderComponent new.
]

{ #category : #accessing }
NewQuestionComponent >> questionText [
	^questionText 
]

{ #category : #accessing }
NewQuestionComponent >> questionText:aText [
questionText :=aText
]

{ #category : #rendering }
NewQuestionComponent >> renderContentOn: aCanvas [
	aCanvas render: header.
	aCanvas
		form: [ (aCanvas textArea on: #questionText of: self)
				columns: 80;
				rows: 5.
			aCanvas break.
			aCanvas submitButton
				callback: [  ];
				with: 'Preguntar' ]
]

{ #category : #styles }
NewQuestionComponent >> style [
	^ '
		*{
			margin:0;
			padding:0;
			box-sizing:border-box;
		}
	'
]
