Class {
	#name : #AccessComponent,
	#superclass : #WAComponent,
	#instVars : [
		'usuario',
		'password',
		'header'
	],
	#category : #'CuOOra-UI-Seaside'
}

{ #category : #hooks }
AccessComponent >> children [
	^ OrderedCollection with: header
]

{ #category : #initialize }
AccessComponent >> initialize [
	super initialize.
	header := CuOOraHeaderComponent new.
]

{ #category : #model }
AccessComponent >> model [ 
^ CuOOra soleInstance
]

{ #category : #accessing }
AccessComponent >> password [
^password 
]

{ #category : #accessing }
AccessComponent >> password:aPassword [
password :=aPassword

]

{ #category : #private }
AccessComponent >> proceedWith: unUsuario [
	self session user: unUsuario.
	self call: HomeComponent new
]

{ #category : #rendering }
AccessComponent >> renderButtonsOn: aCanvas [
	self subclassResponsibility
]

{ #category : #rendering }
AccessComponent >> renderContentOn: aCanvas [
	aCanvas render:header.
	"aCanvas heading
		level: 3;
		with: self session user nombre."
	aCanvas paragraph: [ self model devolverUsuarios ].
	self renderInputElementsOn: aCanvas
]

{ #category : #rendering }
AccessComponent >> renderInputElementsOn: aCanvas [
	aCanvas div
		class: 'divLogin';
		with: [ aCanvas form
				class: 'formulario';
				with: [ aCanvas heading
						level: 2;
						with: '¡Bienvenido!'.
					aCanvas div
						class: 'form-group';
						with: [ aCanvas textInput
								on: #usuario of: self;
								class: 'form-control';
								placeholder: 'Usuario' ].
					aCanvas div
						class: 'form-group';
						with: [ aCanvas textInput
								on: #password of: self;
								type:'password';
								class: 'form-control';
								placeholder: 'Password' ].
					self renderButtonsOn: aCanvas ] ]
]

{ #category : #styles }
AccessComponent >> style [
	^ '
	*{
		margin:0;
		padding:0;
		box-sizing:border-box;
	}
	
	hr{
		margin: 1rem 0;
  	 	color: inherit;
   		background-color: currentColor;
    	border: 0;
    	opacity: 0.25;
    	height: 1px;
	}
	#registerP{
		margin-top:10px;
		margin-bottom:10px;
	}
	.divLogin{
		position:relative;
		width: 285px;
		text-align: center;
		background: #fff;
		margin: 50px auto;
	}
	.login-form{
 	 	padding: 40px;
 	 	box-shadow: 0 0 3px rgba(0,0,0,.3);
	}
	
	.login-form h2{
    	margin: 0 0 20px;
    	line-height: 1;
    	font-size: 18px;
    	font-weight: 400;
  	}
	.login-form input{
		outline: none;
    	display: block;
    	width: 100%;
    	margin: 0 0 20px;
    	padding: 10px 15px;
    	border: 1px solid #ccc;
	}
	.submit-button{
    	cursor: pointer;
    	font-size: 14px;
    	font-weight: 400;
	}
	.jumbotron h1{
		margin-bottom: .5rem;
		font-weight: 500;
		line-height: 1.2;
		font-size: 2.5rem;
		margin-top: 0;
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
	.form-control::placeholder {
   			color: #6c757d;
    		opacity: 1;
	}
	.form-group {
 	   		margin-bottom: 1rem;
	}
	.form-control:focus {
    		color: #495057;
   			background-color: #fff;
    		border-color: #80bdff;
    		outline: 0;
    		box-shadow: 0 0 0 .2rem rgba(0,123,255,.25);
	}
	.formulario{
			margin-top:2.5rem;
			padding: 3rem;
			background-color: #fafafa;
			box-shadow: 0 0 3px rgba(0,0,0,.3);
	}
	form h2{
		margin-bottom:1.5rem;
	}
	
'
]

{ #category : #accessing }
AccessComponent >> usuario [
	^ usuario
]

{ #category : #accessing }
AccessComponent >> usuario: unUsuario [
usuario:= unUsuario 
]
