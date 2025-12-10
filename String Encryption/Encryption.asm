INCLUDE Irvine32.inc
 KEY = 239
 BUFMAX = 128
 ; any value between 1-255
 ; maximum buffer size
 .data
 sPrompt  BYTE "Enter the plain text:",0
 sEncrypt BYTE "Cipher text:
 ",0
 sDecrypt BYTE "Decrypted:
 buffer   BYTE BUFMAX+1 DUP(0)
 bufSize  DWORD ?
 .code
 main PROC
 call InputTheString
 call TranslateBuffer
 ",0
 ; input the plain text
 ; encrypt the buffer
 mov edx,OFFSET sEncrypt ; display encrypted message
 call DisplayMessage
 call TranslateBuffer  
; decrypt the buffer
 mov edx,OFFSET sDecrypt ; display decrypted message
 call DisplayMessage
 exit
 main ENDP
 ;----------------------------------------------------
InputTheString PROC
 ;
 ; Prompts user for a plaintext string. Saves the string 
; and its length.
 ; Receives: nothing
 ; Returns: nothing
 ;----------------------------------------------------
pushad
 ; save 32-bit registers
 mov edx,OFFSET sPrompt ; display a prompt
 call WriteString
 mov ecx,BUFMAX
 ; maximum character count
 mov edx,OFFSET buffer   
call ReadString         
mov bufSize,eax        
call Crlf
 popad
 ret
 InputTheString ENDP
 ; point to the buffer
 ; input the string
 ; save the length
 ;----------------------------------------------------
DisplayMessage PROC
 ;
 ; Displays the encrypted or decrypted message.
 ; Receives: EDX points to the message
 ; Returns:  nothing
 ;----------------------------------------------------
208
 Chapter 6  •  Conditional Processing
 pushad
 call WriteString
 mov edx,OFFSET buffer
 call WriteString
 call Crlf
 call Crlf
 popad
 ret
 DisplayMessage ENDP
 ; display the buffer
 ;----------------------------------------------------
TranslateBuffer PROC
 ;
 ; Translates the string by exclusive-ORing each
 ; byte with the encryption key byte.
 ; Receives: nothing
 ; Returns: nothing
 ;----------------------------------------------------
pushad
 mov ecx,bufSize
 mov esi,0
 L1:
 xor buffer[esi],KEY
 inc esi
 loop L1
 popad
 ret
 TranslateBuffer ENDP
 END main