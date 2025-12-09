MASM Assembly Assignment: Hotel and Restaurant Booking System 
Create a MASM Assembly language project to implement a comprehensive hotel and restaurant 
booking system that interacts with users through console input and output. The program should 
allow users to choose from multiple hotel room types (e.g., Standard, Deluxe, Suite) and 
restaurant meal options (e.g., Breakfast, Lunch, Dinner), each with predefined prices. Users must 
be able to make multiple bookings for both rooms and meals, with the system storing and 
updating the totals accordingly. To maintain clean structure and modularity, design the system 
using separate procedures for displaying menus, processing input, calculating costs, validating 
entries, and generating the booking summary. The program should detect and handle invalid 
inputs by prompting users again, and finally present a detailed summary showing each booking 
and the total cost. 
Requirements & Details: 

1. Hotel Booking Module 

• Room types: 
➢ Single Room — 500 per night 
➢ Double Room — 900 per night 
➢ Suite — 1500 per night 
• User inputs: 
➢ Room type choice (1, 2, or 3) 
➢ Number of nights (1–30) 
• Calculate cost = price × nights 

2. Restaurant Booking Module 

• Meal types: 
➢ Breakfast — 150 per meal 
➢ Lunch — 250 per meal 
➢ Dinner — 400 per meal 
• User inputs: 
➢ Meal type choice (1, 2, or 3) 
➢ Number of meals (1–20) 
• Calculate cost = price × quantity 


3. Booking Summary 

• Display number of hotel rooms booked and total hotel cost 
• Display number of meals booked and total meal cost 
• Display grand total cost 

4. Additional Requirements 

• Use keyboard input (INT 21h) to read user choices and quantities 
• Validate inputs; reject invalid options and re-prompt 
• Use procedures for: 
➢ Reading input 
➢ Hotel booking calculations 
➢ Restaurant booking calculations 
➢ Display summary 
• Use arrays or memory variables to keep track of bookings 
• Use loops for multiple bookings (ask user if they want to add another booking) 
• Display currency amounts as decimal numbers 
• Use string output for menus and prompts 

5. Suggested Structure 

• Main menu: Choose Hotel Booking, Restaurant Booking, or Exit 
• For hotel booking: 
➢ Show room types and prices 
➢ Read choice and nights 
➢ Calculate and store cost & count 
• For restaurant booking: 
➢ Show meal types and prices 
➢ Read choice and quantity 
➢ Calculate and store cost & count 
• After each booking, ask if user wants to book more 
• On exit, display booking summary and totals 

6. Difficulty Highlights 

• Managing multiple bookings with cumulative totals 
• Validating numeric input in assembly (convert ASCII to number) 
• Displaying decimal numbers (implement integer to string conversion) 
• Modular procedures with parameter passing on stack 
• Repeating menus and conditional branching 
• String manipulations for menus and prompts 

7. Deliverables 

• MASM .asm source file fully commented 
• Clear modular design with procedures 
• Sample input/output session as comments 
• Explanation of approach and challenges encountered 

8. Optional Bonus 

• Add cancellation of bookings (subtract from totals) 
• Add discounts based on total amount (e.g., 10% off if total > 5000) 
• Implement saving and loading booking data from file (if environment supports) 