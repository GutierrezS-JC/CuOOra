Class {
	#name : #QuestionDetailsComponent,
	#superclass : #WAComponent,
	#instVars : [
		'pregunta',
		'header'
	],
	#category : #'CuOOra-UI-Seaside'
}

{ #category : #'instance creation' }
QuestionDetailsComponent class >> conPregunta: unaPregunta [
	^ self new conPregunta: unaPregunta
]

{ #category : #callbacks }
QuestionDetailsComponent >> addAnswer [
^pregunta
"Falta implementar"
]

{ #category : #hooks }
QuestionDetailsComponent >> children [
	^ OrderedCollection with: header
]

{ #category : #acessing }
QuestionDetailsComponent >> conPregunta: unaPregunta [
pregunta:=unaPregunta.
]

{ #category : #callbacks }
QuestionDetailsComponent >> darDislike [
	pregunta agregarDislike: self session user
]

{ #category : #callbacks }
QuestionDetailsComponent >> darDislikeAnswer: respuesta [
	respuesta agregarDislike: self session user
]

{ #category : #callbacks }
QuestionDetailsComponent >> darLike [
	pregunta agregarLike: self session user
]

{ #category : #callbacks }
QuestionDetailsComponent >> darLikeAnswer: respuesta [
	respuesta agregarLike: self session user
]

{ #category : #initialization }
QuestionDetailsComponent >> initialize [
	super initialize.
	header := CuOOraHeaderComponent new
]

{ #category : #model }
QuestionDetailsComponent >> model [
	^ CuOOra soleInstance
]

{ #category : #rendering }
QuestionDetailsComponent >> renderAnswerBoxOn: aCanvas [
	aCanvas div
		class: 'answerBox';
		style: 'padding-top:2rem; padding-bottom:2rem';
		with: [ pregunta obtenerRespuestas
				do: [ :respuesta | 
					aCanvas div
						class: 'pregunta';
						with: [ aCanvas
								paragraph: [ aCanvas
										strong: [ aCanvas anchor
												callback: [ self ];
												with: respuesta creadaPor nombre ] ].
							aCanvas paragraph: respuesta contenido.
							self renderCantLikesDislikesAnswerOn: aCanvas with: respuesta.
							self renderLikeAnswerButtonOn: aCanvas with: respuesta.
							self renderDislikeAnswerButtonOn: aCanvas with: respuesta.
							aCanvas horizontalRule ] ].
			self renderNewQuestionButtonOn: aCanvas.
			self renderVolverButtonOn: aCanvas ]
]

{ #category : #rendering }
QuestionDetailsComponent >> renderCantLikesDislikesAnswerOn: aCanvas with: respuesta [
	aCanvas paragraph
										style: 'margin-bottom:.3rem';
										with: [ aCanvas text: respuesta cantidadLikes.
											aCanvas text: ' likes | '.
											aCanvas text: respuesta cantidadDislikes.
											aCanvas text: ' dislikes' ].
]

{ #category : #rendering }
QuestionDetailsComponent >> renderCantLikesDislikesOn: aCanvas [
	aCanvas paragraph
				style: 'margin-bottom:.3rem';
				with: [ aCanvas text: pregunta cantidadLikes.
					aCanvas text: ' likes | '.
					aCanvas text: pregunta cantidadDislikes.
					aCanvas text: ' dislikes' ].
]

{ #category : #rendering }
QuestionDetailsComponent >> renderContentOn: aCanvas [
	aCanvas render: header.
	aCanvas div
		class: 'container';
		style: 'margin-top:5rem';
		with: [ self renderJumbotronOn: aCanvas ].
	aCanvas div
		class: 'container';
		style: 'margin-bottom:5rem';
		with: [ self renderAnswerBoxOn: aCanvas.]
]

{ #category : #rendering }
QuestionDetailsComponent >> renderDislikeAnswerButtonOn: aCanvas with: respuesta [
	aCanvas anchor
		callback: [ self darDislikeAnswer: respuesta ];
		with: [ aCanvas button
				style: 'margin-left:5px';
				class: 'btn btn-outline-danger btn-sm';
				with: 'No me gusta' ]
]

{ #category : #rendering }
QuestionDetailsComponent >> renderDislikeButtonOn: aCanvas [
	aCanvas anchor
		callback: [ self darDislike ];
		with: [ aCanvas button
				style: 'margin-left:5px';
				class: 'btn btn-outline-danger';
				with: 'No me gusta' ]
]

{ #category : #rendering }
QuestionDetailsComponent >> renderJumbotronOn: aCanvas [
	aCanvas div
		class: 'jumbotron';
		with: [ aCanvas heading
				level: 1;
				with: pregunta titulo.
			aCanvas paragraph: pregunta devolverDescripcion.
			aCanvas horizontalRule.
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
			aCanvas
				paragraph: [ aCanvas text: 'Realizada por '.
					aCanvas
						strong: [ aCanvas anchor
								callback: [ self ];
								with: pregunta devolverUsuarioCreador nombre ] ].
			self renderCantLikesDislikesOn: aCanvas.
			self renderLikeButtonOn: aCanvas.
			self renderDislikeButtonOn: aCanvas ]
]

{ #category : #rendering }
QuestionDetailsComponent >> renderLikeAnswerButtonOn: aCanvas with: respuesta [
	aCanvas anchor
		callback: [ self darLikeAnswer: respuesta ];
		with: [ aCanvas button
				class: 'btn btn-outline-success btn-sm';
				with: 'Me gusta' ].
]

{ #category : #rendering }
QuestionDetailsComponent >> renderLikeButtonOn: aCanvas [
	aCanvas anchor
		callback: [ self darLike ];
		with: [ aCanvas button
				class: 'btn btn-outline-success';
				with: 'Me gusta' ]
]

{ #category : #rendering }
QuestionDetailsComponent >> renderNewQuestionButtonOn: aCanvas [
	aCanvas anchor
		callback: [ self ];
		with: [ aCanvas button
				class: 'btn btn-primary';
				with: 'Agregar Respuesta' ]
]

{ #category : #rendering }
QuestionDetailsComponent >> renderVolverButtonOn: aCanvas [
	aCanvas anchor
		callback: [ self answer ];
		with: [ aCanvas button
				style: 'margin-left:10px';
				class: 'btn btn-danger';
				with: 'Volver' ]
]

{ #category : #styles }
QuestionDetailsComponent >> style [
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
	.btn-primary{
		color:#fff;
		background-color:#007bff;
		border-color:#007bff;
	}
	.btn-primary:focus{
		box-shadow: 0 0 0 .2rem rgba(38,143,255,.5);
		outline:0;
	}
	.btn-primary:hover{
		color: #fff;
    	background-color: #0069d9;
   		border-color: #0062cc;
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
'
]
