;EXTERN DISPLAYMODULE:FAR

DATA SEGMENT
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
	
	;CALL DISPLAYMODULE
	
	MOV AX,0
	INT 33H
	MOV AX,01
	INT 33H

NEXT:
	MOV AX,03
	INT 33H
	
	
	MOV AX,CX
	MOV BX,8
	DIV BX
	MOV CX,AX
	
	MOV AX,DX
	DIV BX
	MOV DX,AX
	 
	MOV DH,DL
	MOV DL,CL
	MOV AH,02
	INT 10H
	
	MOV AH,09
	MOV BH,00
	MOV AL,09
	MOV CX,1
	MOV BL,0F0H
	INT 10H
	
	JMP NEXT
	
	
	MOV AH,4CH
	INT 21H
MAIN ENDP
CODE ENDS
END MAIN