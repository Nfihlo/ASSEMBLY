 A plain text message is transformed into an encrypted string called cipher text by XORing
 each of its characters with a character from a third string called a key. The intended viewer can
 use the key to decrypt the cipher text and produce the original plain text.

  We will demonstrate a simple program that uses symmetric encryption,
 a process by which the same key is used for both encryption and decryption. The following steps
 occur in order at runtime:

 The user enters the plain text. 

 The program uses a single-character key to encrypt the plain text, producing the cipher text,
 which is displayed on the screen.
 The program decrypts the cipher text, producing and displaying the original plain text. 
Here is sample output from the program