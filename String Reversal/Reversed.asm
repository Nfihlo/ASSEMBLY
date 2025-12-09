Include irvine32.inc
.data
    Mystr byte "Do not be anxious about anything", 0

    strlen = ($ - Mystr - 1) / TYPE Mystr

    ; allocate one extra byte for the terminating 0
    Reversed byte strlen dup (?)

.code
main PROC
        
call PushChars
 
call PopChars

call DisplaString

    exit

 main ENDP

 PushChars PROC
    mov esi,offset Mystr          ; Load address of original string
    mov ecx,strlen               ; Set counter to string length

pushloop:                   

   
    mov al,[esi]                     ; Load byte from original string
   
    push eax                      ; Push byte onto stack
    
    inc esi

    loop pushloop                     ; Repeat for all characters

   ret

 PushChars ENDP

 PopChars PROC
    mov edi,offset Reversed           ; Load address of reversed string
    mov ecx,strlen                    ; Set counter to string length

poploop:
    pop eax                          ; Pop byte from stack    
    mov [edi],al                     ; Store byte in reversed string
    ; move to next position in reversed string (1 byte)
    inc edi
    loop poploop                     ; Repeat for all characters
    
    ret
 PopChars ENDP

 DisplaString PROC
    mov edx,offset Reversed      ; Load address of reversed string
    mov ecx,strlen               ; Set length of the string
    call WriteString             ; Display the reversed string
    ret
 displaString ENDP

END main         