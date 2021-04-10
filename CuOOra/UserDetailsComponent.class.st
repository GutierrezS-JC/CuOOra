Class {
	#name : #UserDetailsComponent,
	#superclass : #DetailsComponent,
	#instVars : [
		'usuario'
	],
	#category : #'CuOOra-UI-Seaside'
}

{ #category : #'instance creation' }
UserDetailsComponent class >> conUsuario: unUsuario [
	^self new conUsuario: unUsuario.
]

{ #category : #hooks }
UserDetailsComponent >> children [
	^ OrderedCollection with: header
]

{ #category : #accessing }
UserDetailsComponent >> conUsuario:unUsuario [
usuario:=unUsuario .
]

{ #category : #callbacks }
UserDetailsComponent >> follow [
	self session user agregarUsuarioEnSeguidos: usuario
]

{ #category : #initialization }
UserDetailsComponent >> initialize [
	super initialize
]

{ #category : #rendering }
UserDetailsComponent >> renderBottomJumbotronOn: aCanvas [
"Envidia"
			(self session user devolverSeguidos includes: usuario)
				ifTrue: [ self renderUnfollowButtonOn: aCanvas ]
				ifFalse: [ self renderFollowButtonOn: aCanvas ] 
]

{ #category : #rendering }
UserDetailsComponent >> renderContentMainBoxOn: aCanvas [
	aCanvas heading
		level: 2;
		class: 'display-4';
		with: 'Preguntas de ' , usuario nombre.
	usuario obtenerPreguntasRealizadas
		do: [ :pregunta | 
			aCanvas div
				class: 'pregunta';
				with: [ aCanvas
						paragraph: [ aCanvas
								strong: [ aCanvas anchor
										callback: [ self call: (QuestionDetailsComponent conPregunta: pregunta) ];
										with: pregunta titulo ] ].
					aCanvas paragraph
						class: 'topicosDePregunta';
						with: [ aCanvas
								emphasis: [ aCanvas small
										style: 'margin-right:2px';
										with: 'Topicos: ' ].
							pregunta devolverTopicos
								do: [ :topico | 
									aCanvas emphasis
										class: 'topico';
										with: [ aCanvas small: topico nombre ].
									aCanvas space ] ].
					aCanvas paragraph: pregunta devolverDescripcion.
					self renderCantLikesDislikesPostOn: aCanvas with: pregunta.
					self renderLikePostButtonOn: aCanvas with: pregunta.
					self renderDislikePostButtonOn: aCanvas with: pregunta.
					aCanvas horizontalRule ] ]
]

{ #category : #rendering }
UserDetailsComponent >> renderFollowButtonOn: aCanvas [
	aCanvas anchor
		callback: [ self follow ];
		with: [ aCanvas button
				class: 'btn btn-success';
				with: 'Seguir' ]
]

{ #category : #rendering }
UserDetailsComponent >> renderMiddleJumbotronOn: aCanvas [
aCanvas paragraph
				class: 'topicosDePregunta';
				with: [ usuario devolverTopicosInteres
						ifNotEmpty: [ aCanvas emphasis: 'Topicos de Interes: '.
							usuario devolverTopicosInteres
								do: [ :topico | 
									aCanvas emphasis
										class: 'topico';
										with: topico nombre.
									aCanvas space ] ]
						ifEmpty: [ aCanvas emphasis
								class: 'topico';
								with: 'Increible pero este usuario no tiene topicos de interes, un aburrido' ].
					aCanvas horizontalRule ].
]

{ #category : #rendering }
UserDetailsComponent >> renderTopJumbotronOn: aCanvas [
aCanvas heading
				level: 1;
				with: usuario nombre.
]

{ #category : #rendering }
UserDetailsComponent >> renderUnfollowButtonOn: aCanvas [
	aCanvas anchor
		callback: [ self unfollow];
		with: [ aCanvas button
				class: 'btn btn-danger';
				with: 'Dejar de Seguir' ]
]

{ #category : #callbacks }
UserDetailsComponent >> unfollow [
	self session user eliminarUsuarioEnSeguidos: usuario
]
