model PC3
variables:
boolean PC3
boolean Mainboard 
boolean Socket_1151 
boolean Socket_AM4 
boolean RAM 
boolean Power_Supply_Unit 
boolean Optical_Drive 
boolean CPU_Cooler 
boolean Socket_1151_compatible 
boolean Socket_AM4_compatible
integer A domain: 1..5
integer B domain: 5..10 
constraints:
C_PC3 : PC3 = 1
C1: PC3 = Mainboard
C3: Mainboard = RAM
C4: PC3 = Power_Supply_Unit
C6: PC3 = CPU_Cooler
C5: PC3 >= Optical_Drive
C8: Socket_AM4 => Socket_AM4_compatible
C9: Socket_1151 => Socket_1151_compatible
C2: (Socket_1151 => Mainboard) AND
(Socket_AM4 => Mainboard) AND
(Mainboard>= 1) => (Socket_1151+Socket_AM4 >= 1) AND
(Mainboard>= 1) => (Socket_1151+Socket_AM4 <= 1) 
C7: (Socket_1151_compatible => CPU_Cooler) AND
(Socket_AM4_compatible => CPU_Cooler) AND
(CPU_Cooler>= 1) => (Socket_1151_compatible+Socket_AM4_compatible >= 1) AND
(CPU_Cooler>= 1) => (Socket_1151_compatible+Socket_AM4_compatible <= 3) 
C20: A+B > 1
