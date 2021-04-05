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

{ #category : #callbacks }
HomeComponent >> darDislike: pregunta [
	pregunta agregarDislike: self session user
]

{ #category : #callbacks }
HomeComponent >> darLike: pregunta [
	pregunta agregarLike: (self session user).
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
HomeComponent >> renderAddTopicButtonOn: aCanvas [
	aCanvas anchor
		callback: [ self ];
		with: [ aCanvas button
				class: 'btn btn-success';
				with: 'Agregar Topico de Interes' ]
]

{ #category : #rendering }
HomeComponent >> renderBuscadorOn: aCanvas [
	aCanvas form
		class: 'form-inline';
		with: [ aCanvas textInput
				class: 'form-control mr-sm-2';
				placeholder: 'Buscar usuarios'.
			aCanvas button
				class: 'btn btn-outline-success my-2 my-sm-0';
				with: 'Buscar' ]
]

{ #category : #rendering }
HomeComponent >> renderContentOn: aCanvas [
	aCanvas render: header.
	aCanvas div
		class: 'jumbotron jumbotron-fluid';
		with: [ aCanvas div
				class: 'container';
				with: [ aCanvas heading: 'Bienvenido ' , self session user nombre.
					aCanvas div
						with: [ self renderNewQuestionButtonOn: aCanvas.
							aCanvas space.
							self renderAddTopicButtonOn: aCanvas ].
					aCanvas div
						style: 'margin-top:15px';
						with: [ self renderBuscadorOn: aCanvas ] ] ].
	aCanvas div
		style: 'margin-top:20px; margin-bottom:50px';
		class: 'container';
		with: [ aCanvas heading
				level: 2;
				with: 'Preguntas'.
			self renderQuestionsOn: aCanvas ]
]

{ #category : #rendering }
HomeComponent >> renderDislikeButtonOn: aCanvas with: pregunta [
	aCanvas anchor
		callback: [ self darDislike: pregunta ];
		with: [ aCanvas button
				style: 'margin-left:5px';
				class: 'btn btn-outline-danger btn-sm';
				with: 'No me gusta' ]
]

{ #category : #rendering }
HomeComponent >> renderLikeButtonOn: aCanvas with: pregunta [
	aCanvas anchor
		callback: [ self darLike:pregunta ];
		with: [ aCanvas button
				class: 'btn btn-outline-success btn-sm';
				with: 'Me gusta' ]
]

{ #category : #rendering }
HomeComponent >> renderLogoutButtonOn: aCanvas [
	 aCanvas anchor
				callback: [ self answer ];
				with: [ aCanvas button
						class: 'btn btn-danger';
						with: 'Logout' ] .
]

{ #category : #rendering }
HomeComponent >> renderNewQuestionButtonOn: aCanvas [
aCanvas anchor
		callback: [ self createQuestion ];
		with: [ aCanvas button
				class: 'btn btn-primary';
				with: 'Nueva Pregunta' ].
]

{ #category : #rendering }
HomeComponent >> renderQuestionsOn: aCanvas [
	self model devolverUsuarios
		do: [ :each | 
			each obtenerPreguntasRealizadas
				do: [ :pregunta | 
					aCanvas
						paragraph: [ aCanvas text: pregunta titulo.
							aCanvas
								paragraph: [ aCanvas text: 'Realizada por '.
									aCanvas text: each nombre.
									aCanvas text: ' | '.
									aCanvas text: pregunta obtenerRespuestas size.
									aCanvas text: ' respuestas' ].
							aCanvas paragraph
								style: 'margin-bottom:.3rem';
								with: [ aCanvas text: pregunta cantidadLikes.
									aCanvas text: ' likes | '.
									aCanvas text: pregunta cantidadDislikes.
									aCanvas text: ' dislikes' ] ].
					self renderLikeButtonOn: aCanvas with: pregunta.
					self renderDislikeButtonOn: aCanvas with: pregunta.
					aCanvas horizontalRule ] ]
]

{ #category : #styles }
HomeComponent >> style [
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
		transition: color .15s ease-in-out,background-color .15s ease-in-out,border-color .15s ease-in-out,box-shadow .15s ease-in-out;
		cursor:pointer;
		font-family: -apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif,"Apple Color Emoji","Segoe 		UI Emoji","Segoe UI Symbol";
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
	.btn-sm{
		padding: .25rem .5rem;
		font-size: .875rem;
		line-height: 1.5;
		border-radius: .2rem;
	}
	.form-inline{
		display: flex;
		-webkit-box-orient: horizontal;
		-webkit-box-direction: normal;
		flex-flow: row wrap;
		-webkit-box-align: center;
		align-items: center;
	}
	.form-inline .form-Control{
		display: inline-block;
		width: auto;
	}
	.form-control{
		padding: .375rem .75rem;
		font-size: 1rem;
		line-height: 1.5;
		color: #495057;
		background-color: #fff;
		background-clip: padding-box;
		border: 1px solid #ced4da;
		border-radius: .25rem;
		transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out;
	}
	.form-control:focus {
    	color: #495057;
    	background-color: #fff;
    	border-color: #80bdff;
    	outline: 0;
    	box-shadow: 0 0 0 .2rem rgba(0,123,255,.25);
	}
	.form-control::placeholder{
		color: #6c757d;
		opacity:1;
	}
	.mr-sm-2, .mx-sm-2{
		margin-right:.5rem !important;
	}
'
]
