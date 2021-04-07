Class {
	#name : #NewTopicComponent,
	#superclass : #WAComponent,
	#instVars : [
		'header',
		'topicsSelected'
	],
	#category : #'CuOOra-UI-Seaside'
}

{ #category : #callbacks }
NewTopicComponent >> addToSelected: topico [
	topicsSelected add: topico
]

{ #category : #callbacks }
NewTopicComponent >> cargarTopicos [
	self session user registrarTopicoInteres: topicsSelected.
	self answer
]

{ #category : #hooks }
NewTopicComponent >> children [
	^ OrderedCollection with: header
]

{ #category : #callbacks }
NewTopicComponent >> deleteFromInterest: topico [
	self session user eliminarTopicoInteres: topico
]

{ #category : #callbacks }
NewTopicComponent >> deleteFromSelected: topico [
	topicsSelected remove: topico
]

{ #category : #initialize }
NewTopicComponent >> initialize [
	super initialize.
		header := CuOOraHeaderComponent new.
	topicsSelected := OrderedCollection new
]

{ #category : #model }
NewTopicComponent >> model [ 
^	CuOOra soleInstance
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
NewTopicComponent >> renderAddToSelectedButtonOn: aCanvas with: topico [
	aCanvas anchor
		callback: [ self addToSelected: topico ];
		with: [ aCanvas button
				bePush;
				style: 'margin-right:5px';
				class: 'btn btn-outline-primary btn-sm';
				with: topico nombre ]
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
NewTopicComponent >> renderContentOn: aCanvas [
	aCanvas render:header.
	aCanvas div
		class: 'container';
		with: [ aCanvas form
				class: 'formulario';
				with: [ self renderSelectTopicButtonOn: aCanvas.
					self renderAddTopicButtonOn: aCanvas.
					self renderVolverAHomeButtonOn: aCanvas ] ]
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
NewTopicComponent >> renderDeleteFromSelectedButtonOn: aCanvas with: topico [
	aCanvas anchor
		callback: [ self deleteFromSelected: topico ];
		with: [ aCanvas button
				bePush;
				style: 'margin-right:5px';
				class: 'btn btn-primary btn-sm';
				with: topico nombre ]
]

{ #category : #rendering }
NewTopicComponent >> renderDisableButtonOn: aCanvas with: topico [
	aCanvas button
		class: 'btn btn-sm disabled';
		disabled;
		with: topico nombre
]

{ #category : #rendering }
NewTopicComponent >> renderLogoutButtonOn: aCanvas [
	aCanvas anchor
		callback: [ self answer ];
		with: [ aCanvas button
				class: 'btn btn-danger username';
				with: 'Logout' ]
]

{ #category : #rendering }
NewTopicComponent >> renderSelectTopicButtonOn: aCanvas [
	aCanvas div
		class: 'form-group';
		with: [ aCanvas heading
				level: 3;
				with: 'Topicos'.
			self model devolverTopicos
				do: [ :topico | 
					(self session user devolverTopicosInteres includes: topico)
						ifTrue: [ self renderDisableButtonOn: aCanvas with: topico ]
						ifFalse: [ (topicsSelected includes: topico)
								ifTrue: [ self renderDeleteFromSelectedButtonOn: aCanvas with: topico ]
								ifFalse: [ self renderAddToSelectedButtonOn: aCanvas with: topico ] ] ].
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
										with: [ topicsSelected do: [ :topico | aCanvas listItem: topico nombre ] ] ] ] ] ]
]

{ #category : #rendering }
NewTopicComponent >> renderVolverAHomeButtonOn: aCanvas [
	aCanvas anchor
		callback: [ self answer ];
		with: [ aCanvas button
				bePush;
				style: 'margin-left:5px';
				class: 'btn btn-danger';
				with: 'Volver' ]
]

{ #category : #styles }
NewTopicComponent >> style [
	^ '*{
			margin:0;
			padding:0;
			box-sizing:border-box;
		}
		hr{
			margin: .6rem 0;
  	 		color: inherit;
   			background-color: currentColor;
    		border: 0;
    		opacity: 0.25;
  	  		height: 1px;
		}
		.navbar {
  			position: relative;
  			display: flex;
  			flex-wrap: wrap;
  			align-items: center;
  			justify-content: space-between;
  			padding-top: 0.5rem;
  			padding-bottom: 0.5rem;
		}
		.navbar-expand-lg{
			-webkit-box-orient:horizontal;
			-webkit-box-direction: normal;
			flex-flow:row nowrap;
			-webkit-box-pack:start;
			justify-content:flex-start;
		}
		.navbar-brand{
			display:inline-block;
			padding-top:.3125rem;
			padding-bottom:.3125rem;
			margin-right:1rem;
			margin-left:10px;
			font-size:1.5rem;
			line-height:inherit;
			white-space:nowrap;
			color: #fff;
		}
		.bg-dark{
			background-color: #343a40 !important;
		}
		.navbar ul{
			list-style-type:none;
			margin-right:20px;
		}
		.justify-content-between{
			-webkit-box-pack: justify !important;
			justify-content: space-between !important;
		}
		body{
			font-family: -apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif,"Apple Color 			Emoji","Segoe 			UI Emoji","Segoe UI Symbol";
			font-size: 1rem;
			font-weight: 400;
			line-height: 1.5;
			color: #212529;
			text-align: left;
			background-color: #fff;
		}
		.formulario{
			margin-top:2.5rem;
			padding: 3rem;
			background-color: #fafafa;
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
			transition: color .15s ease-in-out,background-color .15s ease-in-out,border-color .15s ease-in-out,box-shadow .15s 			ease-in-out;
			cursor:pointer;
			font-family: -apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif,"Apple Color 			Emoji","Segoe 		UI Emoji","Segoe UI Symbol";
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
	.btn-outline-primary {
  	 		color: #007bff;
    		background-color: transparent;
    		background-image: none;
    		border-color: #007bff;
	}
	.btn-primary:hover{
			color: #fff;
  	 	 	background-color: #0069d9;
   			border-color: #0062cc;
	}
	.btn-outline-primary:hover {
    		color: #fff;
   	 		background-color: #007bff;
  		 	border-color: #007bff;
			text-decoration: none;
	}
	
	.btn-sm{
			padding: .25rem .5rem;
			font-size: .875rem;
			line-height: 1.5;
			border-radius: .2rem;
	}
	.btn-xsm{
			padding: .25rem .5rem;
			font-size: .5rem;
			line-height: 1.5;
			border-radius: .2rem;
	}
	.form-control {
    		display: block;
    		width: 100%;
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
	.form-control::placeholder {
   			color: #6c757d;
    		opacity: 1;
	}
	.form-group {
 	   		margin-bottom: 1rem;
	}
	.form-group h3{
			margin-bottom: .7rem;
	}	
	.btn.disabled, .btn:disabled {
   		opacity: .65;
	 	cursor: inherit;
	 	color: #fff;
		background-color: #007bff;
	 	border-color: #007bff;
		margin-right:5px;
	}
	.btn-disabled:hover {
    	color: inherit;
   		background-color: '';
    	border-color: '';
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
'
]
