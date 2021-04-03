Class {
	#name : #CuOOraHeaderComponent,
	#superclass : #WAComponent,
	#category : #'CuOOra-UI-Seaside'
}

{ #category : #rendering }
CuOOraHeaderComponent >> renderContentOn: aCanvas [
	aCanvas
		header: [ aCanvas
				unorderedList: [ aCanvas
						listItem: [ aCanvas heading
								level: 1;
								with: 'CuOOra' ].
					(self session user)
						ifNotNil: [ aCanvas listItem
								class: 'username';
								with: [ aCanvas anchor
										callback: [ self ];
										with: [ aCanvas heading
												level: 3;
												with: self session user nombre ] ] ] ] ]
]

{ #category : #styles }
CuOOraHeaderComponent >> style [
	^ '
	header ul {
 		list-style-type: none;
		height:50px;
 		margin: 0;
 		padding: 0;
  		overflow: hidden;
  		background-color: #282828;
	}
	li h1{
		margin-top:5px;
		margin-left:20px;
		color:red;
	}
	li {
 		float: left;
	}

	li a {
  		display: block;
  		color: white;
  		text-align: center;
  		padding: 14px 16px;
  		text-decoration: none;
	}

	li a:hover {
 	 	background-color: #333;
	}
	.username{
		float:right
	}
'
]
