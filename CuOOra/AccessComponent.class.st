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
				class: 'login-form';
				with: [ aCanvas heading
						level: 2;
						with: '¡Bienvenido!'.
					aCanvas paragraph: [ aCanvas textInput on: #usuario of: self ].
					aCanvas paragraph: [ aCanvas textInput on: #password of: self ].
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
'
]

{ #category : #accessing }
AccessComponent >> usuario [
	^ usuario
]

{ #category : #accessing }
AccessComponent >> usuario:unUsuario [
usuario:=unUsuario 
]
