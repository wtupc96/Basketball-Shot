EXTERN DRAW_BACKBOARD:FAR

DATA SEGMENT
	HORIZONTAL_DIRECTION DW 0
	VERTICAL_DIRECTION DW 1

	X_COORDINATE1 DW 10
	Y_COORDINATE1 DW 10
	X_COORDINATE2 DW 100
	Y_COORDINATE2 DW 10
	X_COORDINATE3 DW 10
	Y_COORDINATE3 DW 80
	X_COORDINATE4 DW 100
	Y_COORDINATE4 DW 80
DATA ENDS
STACK SEGMENT
STACK ENDS
CODE SEGMENT
MAIN PROC FAR
	ASSUME DS:DATA, SS:STACK, CS:CODE
	
PUSH_COORDINATE	MACRO  X,Y,TAR,DIRECTION
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH SI
	
	SUB AX,AX
	SUB BX,BX
	SUB CX,CX
	SUB DX,DX
	
	MOV SI,OFFSET DIRECTION
	MOV AX,[SI]
	MOV SI,OFFSET X
	MOV BX,[SI]
	MOV SI,OFFSET Y
	MOV CX,[SI]
	MOV SI,OFFSET TAR
	MOV DX,[SI]
	
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	CALL DRAW_BACKBOARD
	
	POP SI
	POP DX
	POP CX
	POP BX
	POP AX
ENDM

CLEAR_SCREEN MACRO 
	PUSH AX
	MOV AX,0600H
	MOV BH,07
	MOV CX,0000
	MOV DX,184FH
	INT 10H
	POP AX
ENDM

MOVE_BACKBOARD MACRO
	PUSH AX
	PUSH SI
	
	MOV SI,OFFSET X_COORDINATE1
	MOV AX,[SI]
	INC AX
	MOV [SI],AX
	MOV SI,OFFSET X_COORDINATE2
	MOV AX,[SI]
	INC AX
	MOV [SI],AX
	MOV SI,OFFSET X_COORDINATE3
	MOV AX,[SI]
	INC AX
	MOV [SI],AX
	MOV SI,OFFSET X_COORDINATE4
	MOV AX,[SI]
	INC AX
	MOV [SI],AX
	
	POP SI
	POP AX
ENDM
	
	MOV AX,DATA
	MOV DS,AX

	;Clear the screen
	CLEAR_SCREEN
	
	;Change the video mode
	MOV AH,00
	MOV AL,04
	INT 10H
	
	MOV AL, 100
	PUSH AX
	
DOO:	
	;Begin
	;PUSH_CLEAR_COORDINATE X_COORDINATE1,Y_COORDINATE1,Y_COORDINATE3
	;CALL CLEAR_BACKBOARD
	
	
	
	
	;PUSH_CLEAR_COORDINATE X_COORDINATE2,Y_COORDINATE2,Y_COORDINATE4
	;CALL CLEAR_BACKBOARD
	
	

	PUSH SI
	PUSH AX
	
	MOV SI,OFFSET Y_COORDINATE3
	MOV AX,[SI]
	MOV SI,OFFSET Y_COORDINATE1
	PUSH AX
	MOV AX,10
	MOV [SI],AX
	POP AX
DRAW:
	
	PUSH_COORDINATE X_COORDINATE1,Y_COORDINATE1,X_COORDINATE2,HORIZONTAL_DIRECTION
	;PUSH_COORDINATE X_COORDINATE3,Y_COORDINATE3,X_COORDINATE4,HORIZONTAL_DIRECTION
	
	;PUSH_COORDINATE X_COORDINATE1,Y_COORDINATE1,Y_COORDINATE3,VERTICAL_DIRECTION
	;PUSH_COORDINATE X_COORDINATE2,Y_COORDINATE2,Y_COORDINATE4,VERTICAL_DIRECTION
	

	
	PUSH AX
	MOV AX,[SI]
	INC AX
	MOV [SI],AX
	POP AX
	CMP AX,[SI]
	JNZ DRAW
	POP AX
	POP SI
	MOVE_BACKBOARD
	
	POP AX
	DEC AL
	JNZ DOO
		
	MOV AH,07H
	INT 21H
	
	MOV AH,4CH
	INT 21H
MAIN ENDP
CODE ENDS
END MAIN