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

{ #category : #accessing }
UserDetailsComponent >> conUsuario:unUsuario [
usuario:=unUsuario .
]

{ #category : #callbacks }
UserDetailsComponent >> deleteQuestion:pregunta [
self session user eliminarPregunta:pregunta

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
	usuario == self session user
		ifFalse: [ (self session user sigueA: usuario)
				ifTrue: [ self renderUnfollowButtonOn: aCanvas ]
				ifFalse: [ self renderFollowButtonOn: aCanvas ] ]
]

{ #category : #rendering }
UserDetailsComponent >> renderContentMainBoxOn: aCanvas [
	aCanvas heading
		level: 2;
		class: 'display-4';
		with: 'Preguntas de ' , usuario nombre.
	usuario obtenerPreguntasRealizadas
		ifEmpty: [aCanvas paragraph: 'Tan... vacio.'.
	aCanvas
		paragraph:
			'Esta bien que no tengas dudas, dice mucho de vos. Sin embargo todos en algun momento necesitamos de la ayuda de alguien con mas experiencia. No dudes en preguntar cuando lo consideres necesario :)'.
	aCanvas paragraph: [ aCanvas strong: 'Atentamente, los Modz' ].
	aCanvas horizontalRule ]
		ifNotEmpty: [ self renderPreguntasRealizadasOn: aCanvas ]
]

{ #category : #rendering }
UserDetailsComponent >> renderContentQuestionOn:aCanvas with:pregunta [
aCanvas
						paragraph: [ aCanvas
								strong: [ aCanvas anchor
										callback: [ self call: (QuestionDetailsComponent conPregunta: pregunta) ];
										with: pregunta titulo ].
							pregunta devolverUsuarioCreador = self session user
								ifTrue: [ self renderDeleteQuestionButtonOn: aCanvas with: pregunta ] ].
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
]

{ #category : #rendering }
UserDetailsComponent >> renderDeleteQuestionButtonOn: aCanvas with: pregunta [
	aCanvas anchor
		style: 'margin-left:10px';
		callback: [ self deleteQuestion: pregunta ];
		with: [ aCanvas button
				class: 'btn btn-outline-danger btn-xsm';
				with: 'X' ]
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
UserDetailsComponent >> renderPreguntasRealizadasOn: aCanvas [
	usuario obtenerPreguntasRealizadas
		do: [ :pregunta | 
			aCanvas div
				class: 'pregunta';
				with: [ self renderContentQuestionOn: aCanvas with:pregunta. 
					self renderLikePostButtonOn: aCanvas with: pregunta.
					self renderDislikePostButtonOn: aCanvas with: pregunta.
					aCanvas horizontalRule ] ]
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
