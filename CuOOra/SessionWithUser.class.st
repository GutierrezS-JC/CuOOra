Class {
	#name : #SessionWithUser,
	#superclass : #WASession,
	#instVars : [
		'user'
	],
	#category : #'CuOOra-UI-Seaside'
}

{ #category : #accessing }
SessionWithUser >> user [ ^user
]

{ #category : #accessing }
SessionWithUser >> user: anObject [
	user := anObject
]
