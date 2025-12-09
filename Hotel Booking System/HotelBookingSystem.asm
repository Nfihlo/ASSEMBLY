; Hotel and Restaurant Booking System
INCLUDE Irvine32.inc
.data
; Main menu
mainMenu       BYTE "===== MAIN MENU =====", 0Dh, 0Ah
               BYTE "1. Hotel Booking", 0Dh, 0Ah
               BYTE "2. Restaurant Booking", 0Dh, 0Ah
               BYTE "3. Cancel Booking", 0Dh, 0Ah
               BYTE "4. View Booking Summary", 0Dh, 0Ah
               BYTE "5. Exit", 0Dh, 0Ah
               BYTE "Enter your choice (1-5): ", 0

; Hotel room types and prices
hotelMenu      BYTE "======= HOTEL BOOKING =======", 0Dh, 0Ah
               BYTE "1. Single Room - 500 per night", 0Dh, 0Ah
               BYTE "2. Double Room - 900 per night", 0Dh, 0Ah
               BYTE "3. Suite - 1500 per night", 0Dh, 0Ah
               BYTE "Enter your choice (1-3): ", 0               
hotelPrices    DWORD 500, 900, 1500
hotelCounts    DWORD 0, 0, 0         ; Track bookings per room type

; Restaurant meal types and prices
restaurantMenu BYTE "===== RESTAURANT BOOKING =====", 0Dh, 0Ah
               BYTE "1. Breakfast - 150 per meal", 0Dh, 0Ah
               BYTE "2. Lunch - 250 per meal", 0Dh, 0Ah
               BYTE "3. Dinner - 400 per meal", 0Dh, 0Ah
               BYTE "Enter your choice (1-3): ", 0
mealPrices     DWORD 150, 250, 400
mealCounts     DWORD 0, 0, 0         ; Track bookings per meal type

; Prompts and messages
promptNights   BYTE "Enter number of nights (1-30): ", 0
promptMeals    BYTE "Enter number of meals (1-20): ", 0
promptCancel   BYTE "Which Booking would You like to cancel", 0Dh, 0Ah
               BYTE "1. Hotel Booking", 0Dh, 0Ah
               BYTE "2. Restaurant Booking", 0Dh, 0Ah
               BYTE "Enter your choice (1-2): ", 0
promptRoomType BYTE "======= HOTEL BOOKING =======", 0Dh, 0Ah
               BYTE "1. Single Room - 500 per night", 0Dh, 0Ah
               BYTE "2. Double Room - 900 per night", 0Dh, 0Ah
               BYTE "3. Suite - 1500 per night", 0Dh, 0Ah
               BYTE "Enter room type to cancel (1-3): ", 0
promptMealType BYTE "===== RESTAURANT BOOKING =====", 0Dh, 0Ah
               BYTE "1. Breakfast - 150 per meal", 0Dh, 0Ah
               BYTE "2. Lunch - 250 per meal", 0Dh, 0Ah
               BYTE "3. Dinner - 400 per meal", 0Dh, 0Ah
               BYTE "Enter meal type to cancel (1-3): ", 0
promptCancelQty BYTE "Enter no. of rooms you'd like to cancel: ", 0
promptContinue BYTE "Would you like to make another booking? (1=Yes, 2=No): ", 0
invalidChoice  BYTE "Invalid choice! Please try again.", 0Dh, 0Ah, 0
summaryTitle   BYTE "================== BOOKING SUMMARY ==================", 0Dh, 0Ah, 0
hotelSummary   BYTE "Hotel: ", 0
roomsBooked    BYTE " rooms booked. ",0Dh, 0Ah
               BYTE "Total is : R", 0
restSummary    BYTE "Restaurant: ", 0
mealsBooked    BYTE " meals booked. ",0Dh, 0Ah
               BYTE "Total is: R", 0
subtotalMsg    BYTE "Subtotal: R", 0
grandTotalMsg  BYTE "Grand Total: ", 0
discountMsg    BYTE "Discount applied: -R",0
farewell       BYTE "THANK YOU FOR VISITING US!!! PLEASE COME BACK AGAIN",0
newLine        BYTE 0Dh, 0Ah, 0

; Booking counters and totals
totalRooms     DWORD 0
totalHotelCost DWORD 0
totalMeals     DWORD 0
totalMealCost  DWORD 0

.code
; ----------------------------------------------------------------------------------------
; MAIN PROCEDURE
; Description:
;   Main program loop. Displays the main menu, receives user input,
;   and calls the hotelbooking and resturant booking, cancellation, or summary procedures.
;   Handles repeated bookings and program exit.
;-----------------------------------------------------------------------------------------
MAIN PROC
    call Clrscr

MainLoop:
    ;Displays main menu
    mov edx, OFFSET mainMenu    
    call WriteString
    
    ;Gets users choice
    call ReadInt
    call Crlf
    
    ;Process choice
    cmp eax, 1                      ;Compares users choice with 1
    je HotelBooking                 ;If users choice is 1 then Jump to HotelBooking
    cmp eax, 2
    je RestaurantBooking            ;If users choice is 2 then Jump to RestaurantBooking
    cmp eax, 3
    je CancelBooking               ;If users choice is 3 then Jump to CancelBooking
    cmp eax, 4
    je ShowSummary                  ;If users choice is 3 then Jump to ShowSummary
    cmp eax, 5
    je ExitProgram                  ;If users choice is 4 then Jump to ExitProgram
    
    ;Invalid choice
    mov edx, OFFSET invalidChoice
    call WriteString
    jmp MainLoop                    ;Jumps back to MainLoop to show menu again

HotelBooking:
    ;procedure to handle hotel bookings
    call ProcessHotelBooking        ;Calls ProcessHotelBooking procedure
    jmp AskContinue                 ;Jumps to AskContinue to ask user if they want to continue

RestaurantBooking:
    ;procedure to handle restaurant bookings
    call ProcessRestaurantBooking   ;Calls ProcessRestaurantBooking procedure
    jmp AskContinue                 ;Jumps to AskContinue to ask user if they want to continue

CancelBooking:
    ;procedure to handle booking cancellations
    call ProcessCancelBooking       ;Calls ProcessCancelBooking procedure   
    jmp AskContinue                 ;Jumps to AskContinue to ask user if they want to continue

ShowSummary:
    ;procedure to display booking summary
    call DisplaySummary             ;Calls DisplaySummary procedure
    jmp MainLoop                    ;Jumps back to MainLoop to show menu again

AskContinue:
    mov edx, OFFSET promptContinue
    call WriteString
    call ReadInt
    call Crlf
    cmp eax, 1
    je MainLoop          ;If user enters 1, jump back to MainLoop
    cmp eax, 2
    je ExitProgram      ;Else jump to ExitProgram

    mov edx, OFFSET invalidChoice
    call WriteString
    jmp AskContinue     ;Jumps back to AskContinue to try again
    
ExitProgram:
    call DisplaySummary        ;Displays summary before exiting
    mov edx, OFFSET farewell
    call WriteString
    call Crlf
    INVOKE ExitProcess, 0
main ENDP

; --------------------------------------------------------------------------------------------
; ProcessHotelBooking PROCEDURE
; Description:
;   Handles hotel room booking. Displays hotel menu, receives user input for room type
;   and number of nights, validates input, calculates cost, and updates booking totals.
;   Tracks bookings per room type for summary and cancellation.
; Receive:
;   User input for room type (1-3) and number of nights (1-30).
; Return:
;   Updates totalRooms, totalHotelCost, and hotelCounts array.
;   If input is invalid, displays error and re-prompts.
; Require:
;   hotelPrices and hotelCounts arrays initialized; totalRooms and totalHotelCost variables.
;--------------------------------------------------------------------------------------------
ProcessHotelBooking PROC
    ; Display hotel menu
    mov edx, OFFSET hotelMenu
    call WriteString
    
    ; Get room choice
    call ReadInt
    call Crlf
    cmp eax, 1                  ;Compares user input with 1
    jl InvalidHotel             ;If less than 1 jump to InvalidHotel
    cmp eax, 3                  ;Compares user input with 3
    jg InvalidHotel             ;If greater than 3 jump to InvalidHotel

    mov ecx, eax                ; Save choice in ECX

    ;If Valid choice then get number of nights from user
    mov edx, OFFSET promptNights
    call WriteString
    call ReadInt
    cmp eax, 1              ;Compares user input with 1
    jl InvalidHotel         ;If less than 1 jump to InvalidHotel
    cmp eax, 30             ;Compares user input with 30
    jg InvalidHotel         ;If greater than 30 jump to InvalidHotel

    mov ebx, eax            ;Save Number of nights in EBX

    ; Calculate cost
    dec ecx                             ;Convert to 0-based index to use array 
    mov eax, hotelPrices[ecx*4]         ;Get price from array
    imul eax, ebx                       ;EAX = price * nights
    
    ; Update totals
    add totalHotelCost, eax         ;Add cost to total hotel cost
    add totalRooms, ebx             ;Add nights to total rooms booked
    mov esi, OFFSET hotelCounts     ;Get address of hotelCounts array
    add [esi + ecx*4], ebx          ;Track per room type
    ret    
;If user input is invalid
InvalidHotel:
    mov edx, OFFSET invalidChoice
    call WriteString
    jmp ProcessHotelBooking ;Jumps back to start of ProcessHotelBooking to try again

ProcessHotelBooking ENDP

; ----------------------------------------------------------------------------------------------
; ProcessRestaurantBooking PROCEDURE
; Description:
;   Handles restaurant meal booking. Displays restaurant menu, receives user input for meal type
;   and number of meals, validates input, calculates cost, and updates booking totals.
;   Tracks bookings per meal type for summary and cancellation.
; Receive:
;   User input for meal type (1-3) and number of meals (1-20).
; Return:
;   Updates totalMeals, totalMealCost, and mealCounts array.
;   If input is invalid, displays error and re-prompts.
; Require:
;   mealPrices and mealCounts arrays initialized; totalMeals and totalMealCost variables.
;----------------------------------------------------------------------------------------------
ProcessRestaurantBooking PROC
    ; Display restaurant menu
    mov edx, OFFSET restaurantMenu
    call WriteString
    
    ; Get meal choice
    call ReadInt
    call Crlf

    cmp eax, 1  
    jl InvalidRestaurant        ;If less than 1 jump to InvalidRestaurant
    cmp eax, 3
    jg InvalidRestaurant        ;If greater than 3 jump to InvalidRestaurant
    mov ecx, eax        ; Save choice in ECX

    ; Valid choice, get number of meals
    mov edx, OFFSET promptMeals
    call WriteString
    call ReadInt
    cmp eax, 1
    jl InvalidRestaurant        ;If less than 1 jump to InvalidRestaurant
    cmp eax, 20
    jg InvalidRestaurant        ;If greater than 20 jump to InvalidRestaurant
     
    mov ebx, eax        ;Saves number of meals in EBX

    ; Calculate cost
    dec ecx                ;Convert to 0-based index   
    mov eax, mealPrices[ecx * 4]   ;Get price from array
    imul eax, ebx                 ;EAX = price * meals
    
    ; Update totals
    add totalMealCost, eax      ;Add cost to total meal cost
    add totalMeals, ebx         ;Add meals to total meals booked
    mov esi, OFFSET mealCounts     ;Get address of mealCounts array
    add [esi + ecx*4], ebx         ;Track per meal type
    ret

;If user input is invalid
InvalidRestaurant:
    mov edx, OFFSET invalidChoice
    call WriteString
    jmp ProcessRestaurantBooking    ;Jumps back to start of ProcessRestaurantBooking to try again
ProcessRestaurantBooking ENDP

; -----------------------------------------------------------------------
; ProcessCancelBooking PROCEDURE
; Description:
;   Handles cancellation of hotel or restaurant bookings.
;   Allows the user to select which booking type (hotel or restaurant),
;   then choose the specific room or meal type and quantity to cancel.
;   Validates that enough bookings exist before cancelling and updates
;   all relevant totals and per-type counters.
; Receive:
;   User input for booking type (1=Hotel, 2=Restaurant),
;   room/meal type (1-3), and quantity to cancel.
; Return:
;   Updates booking counters and totals if cancellation is valid.
;   Displays error message if cancellation is invalid.
; Require:
;   hotelCounts and mealCounts arrays must be initialized and updated
;   during booking; totalRooms, totalHotelCost, totalMeals, totalMealCost
;   must reflect current state.
; -----------------------------------------------------------------------
ProcessCancelBooking PROC
    mov edx, OFFSET promptCancel
    call WriteString
    call ReadInt
    cmp eax, 1
    je CancelHotel          ;If user input is 1 jump to CancelHotel
    cmp eax, 2
    je CancelRestaurant     ;If user input is 2 jump to CancelRestaurant

    jmp InvalidCancel       ;If user input is invalid jump to InvalidCancel
  
CancelHotel:
    mov edx, OFFSET promptRoomType
    call WriteString
    call ReadInt
    cmp eax, 1
    jl InvalidCancel        ;If less than 1 jump to InvalidCancel
    cmp eax, 3
    jg InvalidCancel        ;If greater than 3 jump to InvalidCancel
    mov ecx, eax            ; Save choice in ECX
    dec ecx                 ;Convert to 0-based index to use array  

    mov esi, OFFSET hotelCounts     ;Get address of hotelCounts array
    mov eax, [esi + ecx*4]          ;Get current bookings for selected room type
    cmp eax, 1                      
    jl NoCancel                     ;If less than 1 jump to NoCancel

    mov edx, OFFSET promptCancelQty
    call WriteString
    call ReadInt
    cmp eax, 1          
    jl InvalidCancel        ;If less than 1 jump to InvalidCancel
    mov ebx, eax            ;Saves quantity to cancel in EBX
    mov eax, [esi + ecx*4]        ;Get current bookings for selected room type
    cmp ebx, eax                  ;Compares quantity to cancel with current bookings
    jg InvalidCancel              ;If quantity to cancel is greater than current bookings jump to InvalidCancel

    mov eax, hotelPrices[ecx*4]     ;Get price from array
    imul eax, ebx                   ;EAX = price * quantity to cancel
    sub totalHotelCost, eax         ;Subtract cancelled cost from total hotel cost
    sub totalRooms, ebx             ;Subtract cancelled nights from total rooms booked
    sub [esi + ecx*4], ebx          ;Update per room type bookings
    ret
    
CancelRestaurant:
    mov edx, OFFSET promptMealType
    call WriteString
    call ReadInt
    cmp eax, 1
    jl InvalidCancel        ;If less than 1 jump to InvalidCancel
    cmp eax, 3
    jg InvalidCancel        ;If greater than 3 jump to InvalidCancel
    mov ecx, eax        ; Save choice in ECX
    dec ecx             ;Convert to 0-based index to use array

    mov esi, OFFSET mealCounts      ;Get address of mealCounts array
    mov eax, [esi + ecx*4]          ;Get current bookings for selected meal type
    cmp eax, 1             ;compares current bookings with 1
    jl NoCancel            ;If less than 1 jump to NoCancel

    mov edx, OFFSET promptCancelQty
    call WriteString
    call ReadInt
    cmp eax, 1  
    jl InvalidCancel        ;If less than 1 jump to InvalidCancel
    mov ebx, eax            ;Saves quantity to cancel in EBX
    mov eax, [esi + ecx*4]        ;Get current bookings for selected meal type
    cmp ebx, eax                  ;Compares quantity to cancel with current bookings
    jg InvalidCancel              ;If quantity to cancel is greater than current bookings jump to InvalidCancel

    mov eax, mealPrices[ecx*4]    ;Get price from array 
    imul eax, ebx                 ;EAX = price * quantity to cancel   
    sub totalMealCost, eax        ;Subtract cancelled cost from total meal cost
    sub totalMeals, ebx           ;Subtract cancelled meals from total meals booked
    sub [esi + ecx*4], ebx        ;Update per meal type bookings
    ret

;If user input is invalid
InvalidCancel:
    mov edx, OFFSET invalidChoice
    call WriteString
    ret

;If there are no bookings to cancel
NoCancel:
    mov edx, OFFSET invalidChoice
    call WriteString
    ret
ProcessCancelBooking ENDP

; -----------------------------------------------------------------------------
; DisplaySummary PROCEDURE
; Description:
;   Displays a summary of all hotel and restaurant bookings.
;   Shows total rooms booked and hotel cost, total meals booked and meal cost,
;   and calculates the grand total. If the grand total exceeds 5000,
;   applies a 10% discount and displays the discounted amount.
; Receive:
;   None (uses global booking counters and totals).
; Return:
;   Outputs the booking summary and totals to the console.
; Require:
;   totalRooms, totalHotelCost, totalMeals, totalMealCost must be up-to-date.
;------------------------------------------------------------------------------
DisplaySummary PROC
    mov edx, OFFSET summaryTitle
    call WriteString
    call Crlf

    ; Display hotel summary
    mov edx, OFFSET hotelSummary
    call WriteString
    mov eax, totalRooms     
    call WriteDec               ;Display total rooms booked
    mov edx, OFFSET roomsBooked

    call WriteString    
    mov eax, totalHotelCost
    call WriteDec               ;Display total hotel cost
    call Crlf   
    call Crlf

    ; Display restaurant summary
    mov edx, OFFSET restSummary
    call WriteString
    mov eax, totalMeals         ;Display total meals booked
    call WriteDec
    mov edx, OFFSET mealsBooked
    call WriteString
    mov eax, totalMealCost
    call WriteDec               ;Display total meal cost
    call Crlf
    call Crlf
    
    mov eax, totalHotelCost     ; Calculate grand total
    add eax, totalMealCost      ; EAX = grand total
    mov ebx, eax            ;store original

    mov edx, OFFSET subtotalMsg     
    call WriteString
    call WriteDec               ;Display subtotal
    call Crlf

    cmp eax, 4999           ;If grand total > 4999  apply discount
    jle NoDiscount          ;If less than or equal to 5000 jump to NoDiscount
    
    ;If greater than 4999 apply 20% discount
    mov edx, OFFSET discountMsg
    call WriteString
    mov ecx, eax        ; total in ecx
    ; calculate 10% of total (eax)
    mov eax, ecx        ; total in eax
    mov ebx, 5         ; divisor
    xor edx, edx        ; clear edx before div
    div ebx             ; eax = total/5
    call WriteDec       ; display discount
    call Crlf
    
    sub ecx, eax           ;discounted total
    mov eax, ecx           ;move discounted total to eax
    jmp PrintGrand         ;Jump to PrintGrand
;If <= 4999  
NoDiscount:
    mov eax, ebx

PrintGrand:
    mov edx, OFFSET grandTotalMsg
    call WriteString
    call WriteDec
    call Crlf
    call Crlf
    ret
DisplaySummary ENDP

END main