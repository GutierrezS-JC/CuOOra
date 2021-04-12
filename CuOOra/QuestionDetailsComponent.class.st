Class {
	#name : #QuestionDetailsComponent,
	#superclass : #DetailsComponent,
	#instVars : [
		'pregunta',
		'answerText'
	],
	#category : #'CuOOra-UI-Seaside'
}

{ #category : #'instance creation' }
QuestionDetailsComponent class >> conPregunta: unaPregunta [
	^ self new conPregunta: unaPregunta
]

{ #category : #callbacks }
QuestionDetailsComponent >> addAnswer [
	| nuevaRespuesta |
	answerText ifEmpty:[^self].
	nuevaRespuesta := Respuesta
		conContenido: answerText
		conUsuario: self session user.
	pregunta agregarRespuesta: nuevaRespuesta.
]

{ #category : #acessing }
QuestionDetailsComponent >> answerText [
	^ answerText
]

{ #category : #acessing }
QuestionDetailsComponent >> answerText: aText [
answerText := aText
]

{ #category : #hooks }
QuestionDetailsComponent >> children [
	^ OrderedCollection with: header
]

{ #category : #acessing }
QuestionDetailsComponent >> conPregunta: unaPregunta [
pregunta:=unaPregunta.
]

{ #category : #initialization }
QuestionDetailsComponent >> initialize [
	super initialize.
]

{ #category : #rendering }
QuestionDetailsComponent >> renderAgregarRespuestaButtonOn: aCanvas [
	aCanvas anchor
		with: [ aCanvas button
				id:'buttonAddAnswer';
				callback: [ self addAnswer ];
				class: 'btn btn-success';
				with: 'Responder' ]
]

{ #category : #rendering }
QuestionDetailsComponent >> renderBottomJumbotronOn: aCanvas [
	self renderCantLikesDislikesPostOn: aCanvas with: pregunta.
	self renderLikePostButtonOn: aCanvas with:pregunta.
	self renderDislikePostButtonOn: aCanvas with:pregunta.
]

{ #category : #rendering }
QuestionDetailsComponent >> renderContentMainBoxOn: aCanvas [
	pregunta obtenerRespuestas
		do: [ :respuesta | 
			aCanvas div
				class: 'pregunta';
				with: [ aCanvas
						paragraph: [ aCanvas
								strong: [ aCanvas anchor
										callback: [ self call: (UserDetailsComponent conUsuario: respuesta creadaPor) ];
										with: respuesta creadaPor nombre ] ].
					aCanvas paragraph: respuesta contenido.
					self renderCantLikesDislikesPostOn: aCanvas with: respuesta.
					self renderLikePostButtonOn: aCanvas with: respuesta.
					self renderDislikePostButtonOn: aCanvas with: respuesta.
					aCanvas horizontalRule ] ].
	self renderNewQuestionButtonOn: aCanvas.
	self renderNewModalOn:aCanvas .
]

{ #category : #rendering }
QuestionDetailsComponent >> renderMiddleJumbotronOn: aCanvas [
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
						callback: [ self
								call: (UserDetailsComponent conUsuario: pregunta devolverUsuarioCreador) ];
						with: pregunta devolverUsuarioCreador nombre ] ].
]

{ #category : #rendering }
QuestionDetailsComponent >> renderNewModalOn: aCanvas [
	aCanvas div
		id: 'myModal';
		class: 'modal';
		with: [ aCanvas div
				class: 'modal-content';
				with: [ aCanvas div
						class: 'modal-header';
						with: [ aCanvas span class: 'close'.
							aCanvas heading
								level: 2;
								with: 'Respuesta' ].
					aCanvas form
					
						class: 'formulario';
						with: [ aCanvas div
								class: 'modal-body';
								with: [ self renderTextAreaOn: aCanvas ].
							aCanvas div
								class: 'modal-footer';
								with: [ aCanvas heading
										level: 3;
										with: [ self renderAgregarRespuestaButtonOn: aCanvas ] ] ] ] ]
]

{ #category : #rendering }
QuestionDetailsComponent >> renderNewQuestionButtonOn: aCanvas [
	aCanvas anchor
		with: [ aCanvas button
				id: 'myBtn';
				bePush;
				style: 'margin-right:10px';
				class: 'btn btn-primary';
				with: 'Agregar Respuesta' ]
]

{ #category : #rendering }
QuestionDetailsComponent >> renderTextAreaOn: aCanvas [
	aCanvas div
		class: 'form-group';
		with: [ aCanvas heading
				level: 3;
				with: 'Escriba su respuesta'.
			(aCanvas textArea
				id: 'textAreaAnswer';
				class: 'form-control';
				on: #answerText of: self)
				columns: 80;
				rows: 5 ]
]

{ #category : #rendering }
QuestionDetailsComponent >> renderTopJumbotronOn: aCanvas [
	aCanvas heading
				level: 1;
				with: pregunta titulo.
			aCanvas paragraph: pregunta devolverDescripcion.
]

{ #category : #scripts }
QuestionDetailsComponent >> script [
	^ '
	 document.addEventListener("DOMContentLoaded", function(event) {
			// Get the modal
				var modal = document.getElementById(''myModal''); 
	
			// Get the button that opens the modal
				var btn = document.getElementById(''myBtn'');

			// Get the <span> element that closes the modal
				let span = document.getElementsByClassName(''close'');
		

			// When the user clicks on the button, open the modal
				btn.onclick = function() {
  					modal.style.display = "block";
				}

			// When the user clicks on <span> (x), close the modal
				span.onclick = function() {
  					modal.style.display = "none";
				}

			// When the user clicks anywhere outside of the modal, close it
				window.onclick = function(event) {
  					if (event.target == modal) {
    					modal.style.display = "none";
  					}
				}	 
			
			//Trim for checking blank spaces
				function trimfield(str) { 
    				return str.replace(/^\s+|\s+$/g,''''); 
				}
			
			//Check if answer if empty or not jeje
				var btnAddAnswer = document.getElementById(''buttonAddAnswer'');
				buttonAddAnswer.onclick = function() {
     				var tArea = document.getElementById(''textAreaAnswer'');
         				if(trimfield(tArea.value) == '''') {      
              			alert("Increible, pero me hiciste poner esta alerta para obligarte a no enviar espacios en blanco");
              			tArea.focus();
              			return false;       
         				}
         				else
           				return true;
				}				
	
	})
'
]
