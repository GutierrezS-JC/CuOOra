Class {
	#name : #UserDetailsComponent,
	#superclass : #WAComponent,
	#instVars : [
		'header',
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
UserDetailsComponent >> darDislike: pregunta [
	pregunta agregarDislike: self session user
]

{ #category : #callbacks }
UserDetailsComponent >> darLike:pregunta [ 
pregunta agregarLike: self session user.
]

{ #category : #callbacks }
UserDetailsComponent >> follow [
	self session user agregarUsuarioEnSeguidos: usuario
]

{ #category : #initialization }
UserDetailsComponent >> initialize [
	super initialize.
	header := CuOOraHeaderComponent new.
]

{ #category : #model }
UserDetailsComponent >> model [
	^ CuOOra soleInstance
]

{ #category : #rendering }
UserDetailsComponent >> renderCantLikesDislikesQuestionOn: aCanvas with: pregunta [
	aCanvas paragraph
		style: 'margin-bottom:.3rem';
		with: [ aCanvas text: pregunta cantidadLikes.
			aCanvas text: ' likes | '.
			aCanvas text: pregunta cantidadDislikes.
			aCanvas text: ' dislikes' ]
]

{ #category : #rendering }
UserDetailsComponent >> renderContentOn: aCanvas [
	aCanvas render: header.
	aCanvas div
		class: 'container';
		style: 'margin-top:5rem';
		with: [ self renderJumbotronOn: aCanvas ].
	aCanvas div
		class: 'container';
		style: 'margin-bottom:5rem';
		with: [ 
			self renderQuestionBoxOn: aCanvas ]
]

{ #category : #rendering }
UserDetailsComponent >> renderDislikeQuestionButtonOn: aCanvas with: pregunta [
	aCanvas anchor
		callback: [ self darDislike: pregunta ];
		with: [ aCanvas button
				style: 'margin-left:5px';
				class: 'btn btn-outline-danger btn-sm';
				with: 'No me gusta' ]
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
UserDetailsComponent >> renderJumbotronOn: aCanvas [
	aCanvas div
		class: 'jumbotron';
		with: [ aCanvas heading
				level: 1;
				with: usuario nombre.
			aCanvas horizontalRule.
			aCanvas paragraph
				class: 'topicosDePregunta';
				with: [ "self renderCantLikesDislikesOn: aCanvas.
			self renderLikeButtonOn: aCanvas.
			self renderDislikeButtonOn: aCanvas "
					aCanvas emphasis: 'Topicos de Interes: '.
					usuario devolverTopicosInteres
						do: [ :topico | 
							aCanvas emphasis
								class: 'topico';
								with: topico nombre.
							aCanvas space ].
					aCanvas horizontalRule ].
		(self session user devolverSeguidos includes: usuario) ifTrue: [self renderUnfollowButtonOn: aCanvas ] ifFalse: [ self renderFollowButtonOn:aCanvas ]]
]

{ #category : #rendering }
UserDetailsComponent >> renderLikeQuestionButtonOn: aCanvas with: pregunta [
	aCanvas anchor
		callback: [ self darLike: pregunta ];
		with: [ aCanvas button
				class: 'btn btn-outline-success btn-sm';
				with: 'Me gusta' ]
]

{ #category : #rendering }
UserDetailsComponent >> renderQuestionBoxOn: aCanvas [
	aCanvas div
		class: 'answerBox';
		style: 'padding-top:2rem; padding-bottom:2rem';
		with: [ aCanvas heading
				level: 2;
				class: 'display-4';
				with: 'Preguntas de ' , self session user nombre.
			usuario obtenerPreguntasRealizadas
				do: [ :pregunta | 
					aCanvas div
						class: 'pregunta';
						with: [ aCanvas
								paragraph: [ aCanvas
										strong: [ aCanvas anchor
												callback: [ self call: (QuestionDetailsComponent conPregunta: pregunta) ];
												with: pregunta titulo ] ].
							aCanvas paragraph: pregunta devolverDescripcion.
							self renderCantLikesDislikesQuestionOn: aCanvas with: pregunta.
							self renderLikeQuestionButtonOn: aCanvas with: pregunta.
							self renderDislikeQuestionButtonOn: aCanvas with: pregunta.
							aCanvas horizontalRule ] ].
			self renderVolverButtonOn: aCanvas ]
]

{ #category : #rendering }
UserDetailsComponent >> renderUnfollowButtonOn: aCanvas [
	aCanvas anchor
		callback: [ self unfollow];
		with: [ aCanvas button
				class: 'btn btn-danger';
				with: 'Dejar de Seguir' ]
]

{ #category : #rendering }
UserDetailsComponent >> renderVolverButtonOn: aCanvas [
	aCanvas anchor
		callback: [ self answer ];
		with: [ aCanvas button
				class: 'btn btn-danger';
				with: 'Volver' ]
]

{ #category : #styles }
UserDetailsComponent >> style [
	^ '
	*{
		margin:0;
		padding:0;
		box-sizing:border-box;
	}
	body{
		font-family: -apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif,"Apple Color Emoji","Segoe 		UI Emoji","Segoe UI Symbol";
		font-size: 1rem;
		font-weight: 400;
		line-height: 1.5;
		color: #212529;
		text-align: left;
		background-color: #fff;
	}
	.jumbotron{
		padding: 4rem 2rem;
		margin-bottom:2rem;
		background-color:#e9ecef;
	}
	.jumbotron-fluid{
		padding-right:0;
		padding-left:0;
		border-radius:0;
	}
	.jumbotron h1{
		margin-bottom: .5rem;
		font-weight: 500;
		line-height: 1.2;
		font-size: 2.5rem;
		margin-top: 0;
	}
	hr{
		margin: 1rem 0;
  	 	color: inherit;
   		background-color: currentColor;
    	border: 0;
    	opacity: 0.25;
    	height: 1px;
	}
	.answerBox div:last-child hr{
		display:none;
	}
	.container .answerBox{
		background-color:#f5f8fc;
    	padding-right: 2rem;
    	padding-left: 2rem;
	}
	.container {
  		padding-right: 15px;
  		padding-left: 15px;
  		margin-right: auto;
  		margin-left: auto;
	}
	
	@media (min-width: 768px) {
 	.container {
   		width: 750px;
 	}
	}
	@media (min-width: 992px) {
  	.container {
    	width: 970px;
  	}
	}
	@media (min-width: 1200px) {
  	.container {
   		width: 1170px;
  	}
	}
	
	.btn{
		display:inline-block;
		font-weight:400;
		text-align:center;
		vertical-align:middle;
		border:1px solid #0000;
		padding: .375rem .75rem;
		font-size:1rem;
		line-height:1.5;
		border-radius:.25rem;
		transition: color .15s ease-in-out,background-color .15s ease-in-out,border-color .15s ease-in-out,box-shadow .15s 		ease-in-out;
		cursor:pointer;
		font-family: -apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif,"Apple Color 		Emoji","Segoe 		UI Emoji","Segoe UI Symbol";
	}
	.btn-sm{
		padding: .25rem .5rem;
		font-size: .875rem;
		line-height: 1.5;
		border-radius: .2rem;
	}
	
	.btn-danger{
		color:#fff;
		background-color:#dc3545;
		border-color:#dc3545;
	}
	.btn-danger:hover{
		color:#fff;
		background-color:#c82333;
		border-color:#bd2130;
	}
	.btn-success{
		color:#fff;
		background-color:#28a745;
		border-color:#28a745;
	}
	.btn-success:hover{
		color:#fff;
		background-color:#218838;
		border-color:#1e7e34;
	}
	.btn-outline-danger{
		color: #dc3545;
		background-color: transparent;
		background-image: none;
		border-color: #dc3545;
	}
	.btn-outline-danger:hover{
		color: #fff;
		background-color: #dc3545;
		border-color: #dc3545;
	}
	.btn-outline-success{
		color: #28a745;
		background-color: transparent;
		background-image: none;
		border-color: #28a745;
	}
	.btn-outline-success:hover{
		color: #fff;
		background-color: #28a745;
		border-color: #28a745;
	}	
	.topicosDePregunta{
		color: #6c757dab !important;
		font-weight:650;
	}
	strong a{
		color: inherit;
		text-decoration:none;
	}
	.topicosDePregunta .topico{
		margin-right:.5rem;
	}
	.display-4 {
		margin-bottom:1.5rem;
   		font-size: 2rem;
  	  	font-weight: 600;
 	   line-height: 1.2;
	}
'
]

{ #category : #callbacks }
UserDetailsComponent >> unfollow [
	self session user eliminarUsuarioEnSeguidos: usuario
]
