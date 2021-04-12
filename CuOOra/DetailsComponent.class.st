Class {
	#name : #DetailsComponent,
	#superclass : #WAComponent,
	#instVars : [
		'header'
	],
	#category : #'CuOOra-UI-Seaside'
}

{ #category : #hooks }
DetailsComponent >> children [
	^ OrderedCollection with: header
]

{ #category : #callbacks }
DetailsComponent >> darDislikePost: post [
	post agregarDislike: self session user
]

{ #category : #callbacks }
DetailsComponent >> darLikePost: post [
	post agregarLike: self session user
]

{ #category : #initialization }
DetailsComponent >> initialize [
	super initialize.
	header:= CuOOraHeaderComponent new.
]

{ #category : #model }
DetailsComponent >> model [
	^ CuOOra soleInstance
]

{ #category : #rendering }
DetailsComponent >> renderBottomJumbotronOn: aCanvas [
	self subclassResponsibility 
]

{ #category : #rendering }
DetailsComponent >> renderCantLikesDislikesPostOn:aCanvas with: post [ 
	aCanvas paragraph
		style: 'margin-bottom:.3rem';
		with: [ aCanvas text: post cantidadLikes.
			aCanvas text: ' likes | '.
			aCanvas text: post cantidadDislikes.
			aCanvas text: ' dislikes' ] 
]

{ #category : #rendering }
DetailsComponent >> renderContentMainBoxOn: aCanvas [
	self subclassResponsibility 
]

{ #category : #rendering }
DetailsComponent >> renderContentOn: aCanvas [
	aCanvas render: header.
	aCanvas div
		class: 'container';
		style: 'margin-top:5rem';
		with: [ self renderJumbotronOn: aCanvas ].
	aCanvas div
		class: 'container';
		style: 'margin-bottom:5rem';
		with: [ self renderMainBoxOn: aCanvas ]
]

{ #category : #rendering }
DetailsComponent >> renderDislikePostButtonOn: aCanvas with: post [
	aCanvas anchor
		callback: [ self darDislikePost: post ];
		with: [ aCanvas button
				style: 'margin-left:5px';
				class: 'btn btn-outline-danger btn-sm';
				with: 'No me gusta' ]
]

{ #category : #rendering }
DetailsComponent >> renderJumbotronOn: aCanvas [
	aCanvas div
		class: 'jumbotron';
		with: [ self renderTopJumbotronOn: aCanvas.
			aCanvas horizontalRule.
			self renderMiddleJumbotronOn: aCanvas.
			self renderBottomJumbotronOn: aCanvas ]
]

{ #category : #rendering }
DetailsComponent >> renderLikePostButtonOn: aCanvas with: post [
	aCanvas anchor
		callback: [ self darLikePost: post ];
		with: [ aCanvas button
				class: 'btn btn-outline-success btn-sm';
				with: 'Me gusta' ]
]

{ #category : #rendering }
DetailsComponent >> renderMainBoxOn: aCanvas [
	aCanvas div
		class: 'answerBox';
		style: 'padding-top:2rem; padding-bottom:2rem';
		with: [ self renderContentMainBoxOn: aCanvas.
		
			self renderVolverButtonOn: aCanvas ]
]

{ #category : #rendering }
DetailsComponent >> renderMiddleJumbotronOn: aCanvas [
	self subclassResponsibility 
]

{ #category : #rendering }
DetailsComponent >> renderTopJumbotronOn: aCanvas [
	self subclassResponsibility 
]

{ #category : #rendering }
DetailsComponent >> renderVolverButtonOn: aCanvas [
	aCanvas anchor
		callback: [ self answer ];
		with: [ aCanvas button
				
				class: 'btn btn-danger';
				with: 'Volver' ]
]

{ #category : #styles }
DetailsComponent >> style [
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
	
	.btn-xsm{
			padding: .25rem .5rem;
			font-size: .5rem;
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

	.display-4 {
		margin-bottom:1.5rem;
   		font-size: 2rem;
  	  	font-weight: 600;
 	   line-height: 1.2;
	}
	/* The Modal (background) */
.modal {
  display: none; /* Hidden by default */
  position: fixed; /* Stay in place */
  z-index: 1; /* Sit on top */
  padding-top: 100px; /* Location of the box */
  left: 0;
  top: 0;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
  overflow: auto; /* Enable scroll if needed */
  background-color: rgb(0,0,0); /* Fallback color */
  background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}

/* Modal Content */
.modal-content {
  position: relative;
  background-color: #fefefe;
  max-width:800px;
  margin: auto;
  padding: 0;
  width: 80%;
  box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
  -webkit-animation-name: animatetop;
  -webkit-animation-duration: 0.4s;
  animation-name: animatetop;
  animation-duration: 0.4s
}

/* Add Animation */
@-webkit-keyframes animatetop {
  from {top:-300px; opacity:0} 
  to {top:0; opacity:1}
}

@keyframes animatetop {
  from {top:-300px; opacity:0}
  to {top:0; opacity:1}
}

/* The Close Button */
.close {
  color: white;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: #000;
  text-decoration: none;
  cursor: pointer;
}

.modal-header {
  padding: 1rem;
  background-color: #e9ecef;
}

.modal-body {/*padding: 2px 16px;*/ padding:1rem;}

.modal-footer {
  padding: 1rem;
  background-color: #e9ecef;
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
	textarea {
   			overflow: auto;
    		resize: vertical;
		font-family: -apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif,"Apple Color Emoji","Segoe 		UI Emoji","Segoe UI Symbol";
	}
'
]
