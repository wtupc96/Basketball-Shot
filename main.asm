EXTERN DISPLAYMODULE:FAR

DATA SEGMENT
	MOUSE_X DW ?
	MOUSE_Y DW ?
DATA ENDS
STACK SEGMENT
STACK ENDS
CODE SEGMENT
MAIN PROC FAR
	ASSUME DS:DATA, SS:STACK, CS:CODE
	
	MOV AX,DATA
	MOV DS,AX
	
	;Change the video mode
	MOV AH,00
	MOV AL,04
	INT 10H
	
	CALL DISPLAYMODULE
	
	
	
	MOV AH,4CH
	INT 21H
MAIN ENDP
CODE ENDS
END MAIN