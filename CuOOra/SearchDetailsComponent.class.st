Class {
	#name : #SearchDetailsComponent,
	#superclass : #DetailsComponent,
	#instVars : [
		'userSearched'
	],
	#category : #'CuOOra-UI-Seaside'
}

{ #category : #'instance creation' }
SearchDetailsComponent class >> withSearchInput: aUserSearched [
	^ self new withSearchInput: aUserSearched
]

{ #category : #initialize }
SearchDetailsComponent >> initialize [ 
^super initialize
]

{ #category : #rendering }
SearchDetailsComponent >> renderBottomJumbotronOn: aCanvas [
	aCanvas paragraph: ''.
]

{ #category : #rendering }
SearchDetailsComponent >> renderContentMainBoxOn: aCanvas [
	userSearched ifEmpty: [ ^ self ].
	aCanvas paragraph
		class: 'display-4';
		with: '''' , userSearched , ''''.
	self renderResultadosDeBusquedaOn: aCanvas.
	aCanvas horizontalRule
]

{ #category : #rendering }
SearchDetailsComponent >> renderMiddleJumbotronOn: aCanvas [
	aCanvas paragraph
		class: 'topicosDePregunta';
		with:
			'Asumiendo que no rompiste nuestro humilde buscador con espacios en blanco'
]

{ #category : #rendering }
SearchDetailsComponent >> renderResultadosDeBusquedaOn: aCanvas [
	| usuarios |
	usuarios := self model usersMatchingNamePart: userSearched.
	usuarios
		ifEmpty: [ aCanvas strong: '¿Mejor solo... que mal acompañado?'.
			aCanvas
				paragraph:
					'No puede ser, no hay nadie en el sistema que coincida con tu busqueda.' ]
		ifNotEmpty: [ self renderUsuariosBusqueda: usuarios on: aCanvas ]
]

{ #category : #rendering }
SearchDetailsComponent >> renderTopJumbotronOn: aCanvas [
	aCanvas heading
		level: 1;
		with: 'Busqueda'.
	aCanvas
		paragraph:
			'Bueno, esta bien hacer nuevos amigos. A continuacion, los resultados de tu busqueda'
]

{ #category : #rendering }
SearchDetailsComponent >> renderUsuariosBusqueda: usuarios on: aCanvas [
	aCanvas
		unorderedList: [ usuarios
				do: [ :usuario | 
					aCanvas
						listItem: [ aCanvas anchor
								callback: [ self call: (UserDetailsComponent conUsuario: usuario) ];
								with: [ aCanvas text: usuario nombre ] ] ] ]
]

{ #category : #accessing }
SearchDetailsComponent >> userSearched [
	^userSearched
]

{ #category : #accessing }
SearchDetailsComponent >> userSearched: aText [
	userSearched  := aText
]

{ #category : #accessing }
SearchDetailsComponent >> withSearchInput:aUserSearched [
userSearched :=aUserSearched .
]
