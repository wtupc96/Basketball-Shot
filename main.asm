EXTERN DRAW_BACKBOARD:FAR

DATA SEGMENT
	HORIZONTAL_DIRECTION DW 0
	VERTICAL_DIRECTION DW 1

	X_COORDINATE1 DW 10
	Y_COORDINATE1 DW 10
	X_COORDINATE2 DW 200
	Y_COORDINATE2 DW 10
	X_COORDINATE3 DW 10
	Y_COORDINATE3 DW 80
	X_COORDINATE4 DW 200
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
	
	MOV AX,DATA
	MOV DS,AX

	;Clear the screen
	MOV AX,0600H
	MOV BH,07
	MOV CX,0000
	MOV DX,184FH
	INT 10H
	
	;Change the video mode
	MOV AH,00
	MOV AL,06
	INT 10H
	
	
	;Begin
	PUSH_COORDINATE X_COORDINATE1,Y_COORDINATE1,X_COORDINATE2,HORIZONTAL_DIRECTION
	PUSH_COORDINATE X_COORDINATE1,Y_COORDINATE1,Y_COORDINATE3,VERTICAL_DIRECTION
	PUSH_COORDINATE X_COORDINATE3,Y_COORDINATE3,X_COORDINATE4,HORIZONTAL_DIRECTION
	PUSH_COORDINATE X_COORDINATE2,Y_COORDINATE2,Y_COORDINATE4,VERTICAL_DIRECTION
	
	MOV AH,07H
	INT 21H
	
	MOV AH,4CH
	INT 21H
MAIN ENDP
CODE ENDS
END MAIN