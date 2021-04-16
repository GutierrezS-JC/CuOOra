Class {
	#name : #NewTopicComponent,
	#superclass : #ElementCreationComponent,
	#category : #'CuOOra-UI-Seaside'
}

{ #category : #callbacks }
NewTopicComponent >> cargarTopicos [
	topicsSelected ifEmpty: [ ^ self ].
	self session user registrarTopicoInteres: topicsSelected.
	self answer
]

{ #category : #callbacks }
NewTopicComponent >> deleteFromInterest: topico [
	self session user eliminarTopicoInteres: topico
]

{ #category : #initialize }
NewTopicComponent >> initialize [
	super initialize
]

{ #category : #rendering }
NewTopicComponent >> renderActualTopicsOfInterestOn: aCanvas [
	self session user devolverTopicosInteres
		ifNotEmpty: [ aCanvas div
				style: 'margin-top:1.2rem';
				with: [ aCanvas heading
						level: 4;
						with: 'Actualmente de su interes'.
					self session user devolverTopicosInteres
						do: [ :topico | 
							aCanvas paragraph
								with: [ aCanvas text: topico nombre.
									aCanvas space.
									self renderDeleteFromInterestButtonOn: aCanvas with: topico ] ] ].
			aCanvas horizontalRule ]
]

{ #category : #rendering }
NewTopicComponent >> renderAddTopicButtonOn: aCanvas [
	aCanvas anchor
		with: [ aCanvas button
				callback: [ self cargarTopicos ];
				class: 'btn btn-success';
				with: 'Agregar' ]
]

{ #category : #rendering }
NewTopicComponent >> renderBottomSelectTopicOn: aCanvas [
	self renderActualTopicsOfInterestOn: aCanvas.
			aCanvas div
				with: [ topicsSelected
						ifNotEmpty: [ aCanvas paragraph
								style: 'margin-top:.5rem';
								with: [ aCanvas heading
										level: 4;
										with: 'Topicos Seleccionados'.
									aCanvas unorderedList
										style: 'margin-left:2.5rem';
										with: [ topicsSelected do: [ :topico | aCanvas listItem: topico nombre ] ] ] ] ]
]

{ #category : #rendering }
NewTopicComponent >> renderDeleteFromInterestButtonOn: aCanvas with: topico [
	aCanvas anchor
		callback: [ self deleteFromInterest: topico ];
		with: [ aCanvas button
				bePush;
				class: 'btn btn-xsm btn-outline-danger';
				with: 'X' ]
]

{ #category : #rendering }
NewTopicComponent >> renderDisableButtonOn: aCanvas with: topico [
	aCanvas button
		class: 'btn btn-sm disabled';
		disabled;
		with: topico nombre
]

{ #category : #rendering }
NewTopicComponent >> renderMainContentOn: aCanvas [
	self renderAddTopicButtonOn: aCanvas
]

{ #category : #rendering }
NewTopicComponent >> renderTopicosButtonsDisplayOn: aCanvas with: topico [
	(self session user devolverTopicosInteres includes: topico)
		ifTrue: [ self renderDisableButtonOn: aCanvas with: topico ]
		ifFalse: [ (topicsSelected includes: topico)
				ifTrue: [ self renderDeleteFromSelectedButtonOn: aCanvas with: topico ]
				ifFalse: [ self renderAddToSelectedButtonOn: aCanvas with: topico ] ]
]
