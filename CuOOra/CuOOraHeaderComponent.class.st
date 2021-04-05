Class {
	#name : #CuOOraHeaderComponent,
	#superclass : #WAComponent,
	#category : #'CuOOra-UI-Seaside'
}

{ #category : #rendering }
CuOOraHeaderComponent >> renderContentOn: aCanvas [
	aCanvas header
		class: 'navbar navbar-expand-lg bg-dark justify-content-between';
		with: [ aCanvas heading
				class: 'navbar-brand';
				level: 1;
				with: 'CuOOra'.
			aCanvas div
				with: [ self session user
						ifNotNil: [ aCanvas unorderedList
								with: [ aCanvas listItem with: [ self renderLogoutButtonOn: aCanvas ] ] ] ] ]
]

{ #category : #rendering }
CuOOraHeaderComponent >> renderLogoutButtonOn: aCanvas [
	aCanvas anchor
		callback: [ self answer ];
		with: [ aCanvas button
				class: 'btn btn-danger username';
				with: 'Logout' ]
]

{ #category : #styles }
CuOOraHeaderComponent >> style [
	^ '
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
'
]
