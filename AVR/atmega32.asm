/*
Use an external 4MHz crystal. The internal crystal will run for a few seconds before it doesn't agree with the bus
*/

.device ATmega32
.include "m32def.inc"

/*******
General  Initialization
*******/
	.DEF	I2C_SCRATCH_A	= R24	; I2C scratch-pad where the error code is sent
	.DEF	I2C_SCRATCH_B	= R25	; I2C scratch-pad register that holds the data to write
	.DEF	LASER_HIGH	= R27	; High byte for the laser measurement. Also register that holds the data to write
	.DEF	LASER_LOW	= R26	; Low byte for the laser measurement. Also where the error code is sent

	ldi I2C_SCRATCH_A, high(RAMEND)
	out sph, I2C_SCRATCH_A
	ldi I2C_SCRATCH_A, low(RAMEND)
	out spl, I2C_SCRATCH_A            ; sets up the stack segment

	SER	LASER_LOW
	SER	LASER_HIGH
	OUT	DDRB, LASER_LOW
	OUT	PORTB, LASER_LOW
	OUT	DDRD, LASER_LOW
	OUT	PORTD, LASER_LOW

main:
	call TWI_FUNC
	out portB, LASER_HIGH
	out portD, LASER_LOW
	rjmp main

/*******
TWI Function
*******/
TWI_FUNC:
; Start up the bus and address the laser unit
	CALL	I2C_INIT
	CALL	I2C_START
	CPI	I2C_SCRATCH_A, 0X08	; TWSR == "START condition sent"
	BRNE	ERROR
	LDI	I2C_SCRATCH_B, 0xC4	; SLA (0x62<<1) + W (0)
	CALL	I2C_WRITE
	CPI	I2C_SCRATCH_A, 0X18	; TWSR == "SLA+W sent, ACK recieved"
	BRNE	ERROR

	LDI I2C_SCRATCH_B, 0x00	; Register to use
	CALL	I2C_WRITE
	CPI	I2C_SCRATCH_A, 0X28	; TWSR == "Data Byte sent, ACK recieved"
	BRNE	ERROR	; If no error by this time, we know we have a device on 
					; the line at the proper address, with the proper register
	LDI	I2C_SCRATCH_B, 0x04	; Data to be transmitted
	CALL	I2C_WRITE ; I2C_SCRATCH_A == 0X28 TWSR == "Data Byte sent, ACK recieved"

; Some configuration of the laser here
; - 0x08 sent to register 0x04 disables an early termination of the signal
; - 0xFF sent to register 0x02 sets maximum number of aquisitions

	LDI I2C_SCRATCH_B, 0x04	; Register to use
	CALL	I2C_WRITE
;	I2C_SCRATCH_A == 0X28	; TWSR == "Data Byte sent, ACK recieved"
	LDI	I2C_SCRATCH_B, 0x08	; Data to be transmitted
	CALL	I2C_WRITE ; I2C_SCRATCH_A == 0X28 TWSR == "Data Byte sent, ACK recieved"
	LDI I2C_SCRATCH_B, 0x02	; Register to use
	CALL	I2C_WRITE
;	I2C_SCRATCH_A == 0X28	; TWSR == "Data Byte sent, ACK recieved"
	LDI	I2C_SCRATCH_B, 0xFF	; Data to be transmitted
	CALL	I2C_WRITE ; I2C_SCRATCH_A == 0X28 TWSR == "Data Byte sent, ACK recieved"

; Init of device complete
; Begin taking measurements

	LDI	I2C_SCRATCH_B, 0x01	; Register to use
	CALL	I2C_WRITE	; I2C_SCRATCH_A == 0X28	; TWSR == "Data Byte sent, ACK recieved"
	CALL	I2C_START	; Send a restart condition (no stop was sent)
;	I2C_SCRATCH_A == 0X10	; TWSR == "START condition resent"
	LDI	I2C_SCRATCH_B, 0xC5	; SLA (0x62<<1) + R (1)
	CALL	I2C_WRITE	; I2C_SCRATCH_A == 0X40 TWSR == "SLA+R sent, ACK recieved"
Poll_Laser_Read_Register:
	CALL	I2C_READ	; I2C_SCRATCH_A == 0X58 TWSR == "Data Byte recieved, NACK sent"
	ANDI	I2C_SCRATCH_B, 0x01	; Mask out all but the LSB
	CPI	I2C_SCRATCH_B, 0x01	; re-read the register if the LSB is not low
	BRNE	Poll_Laser_Read_Register	; if this falls through, we have a measurement on registers 0x0F & 0x10
; End Poll_Laser_Read_Register loop
	CALL	I2C_START	; Send a restart condition (no stop was sent)
;	I2C_SCRATCH_A == 0X10	; TWSR == "START condition resent"
	LDI	I2C_SCRATCH_B, 0xC4	; SLA (0x62<<1) + W (0)
	CALL	I2C_WRITE	; I2C_SCRATCH_A == 0X18	TWSR == "SLA+W sent, ACK recieved"
				; register 0x0F has high-byte measurement
				; register 0x10 has low-byte measurement
	LDI	I2C_SCRATCH_B, 0x8F	; Register to use: 0x0F with auto-increment
	CALL	I2C_WRITE	; I2C_SCRATCH_A == 0X28 TWSR == "Data Byte sent, ACK recieved"
	CALL	I2C_START	; Send a restart condition (no stop was sent)
;	I2C_SCRATCH_A == 0X10	; TWSR == "START condition resent"
	LDI	I2C_SCRATCH_B, 0xC5	; SLA (0x62<<1) + R (1)
	CALL	I2C_WRITE	; I2C_SCRATCH_A == 0X40 TWSR == "SLA+R sent, ACK recieved"
	CALL	I2C_READ_MULTI	; Read the High-Byte
;	I2C_SCRATCH_A == 0X50	; TWSR == "Data Byte recieved, ACK sent"
	MOV	LASER_HIGH, I2C_SCRATCH_B
	CALL	I2C_READ	; Read the Low-Byte
;	I2C_SCRATCH_A == 0X58	; TWSR == "Data Byte recieved, NACK sent"
	MOV	LASER_LOW, I2C_SCRATCH_B
	CALL	I2C_STOP

/*******
RETURN TO PROGRAM HERE
HIGH/LOW BYTE MEASUREMENT IN LASER_HIGH/LOW REGISTERS
*/
	RET
/*******/

/*
ERROR CODE GOES HERE
*/
ERROR:
	LDI I2C_SCRATCH_A, 0XFF
	OUT	PORTD, I2C_SCRATCH_A
	OUT	PORTB, I2C_SCRATCH_A
	RJMP	HERE

TESTA:
	LDI LASER_HIGH, 0x0F
	OUT PORTB, LASER_HIGH
	OUT PORTD, I2C_SCRATCH_A
	RJMP here

TESTB:
	LDI LASER_HIGH, 0x0F
	OUT PORTB, LASER_HIGH
	OUT PORTD, I2C_SCRATCH_B
	RJMP here

HERE:	RJMP	HERE

/*
Initializes the TWI interface
- Clears out the Status Register and sets the prescaler to 0b00
- Sets the SCL clock line for 100KHz operation
- Starts the TWI interface going
*/
I2C_INIT:
	LDI	I2C_SCRATCH_A, 0X00
	OUT	TWSR, I2C_SCRATCH_A
	LDI I2C_SCRATCH_A, 0x0C	; SCL signal = clk / (16+2*TWBR*4^TWPS)
	OUT	TWBR, I2C_SCRATCH_A	; 100KHz = 4M / (16+2*12*4^0)
	LDI	I2C_SCRATCH_A, (1<<TWEN)
	OUT	TWCR, I2C_SCRATCH_A
	RET

/*
Starts communicating on the TWI bus. If sent before a stop has occured, a 
restart condition exists.
- Sends a START signal
- Waits until the signal is completely sent
- Checks for an error
*/
I2C_START:
;	LDI	I2C_SCRATCH_A, (1<<TWINT)|(1<<TWSTA)|(1<<TWEN)
	LDI I2C_SCRATCH_A, 0xFF	; <<<<< This is wrong???
	OUT	TWCR, I2C_SCRATCH_A
WAIT1:
	IN	I2C_SCRATCH_A, TWCR
	SBRS	I2C_SCRATCH_A, TWINT
	RJMP	WAIT1
	RCALL	I2C_READ_STATUS
	RET

/*
Reads a byte from the bus. Sends an ACK at the end, saying that it expects another byte
- Sends that it is ready to read
- Waits for the byte to be recieved
- Sends an ACK
- Checks for an error
*/
I2C_READ_MULTI:
	LDI	I2C_SCRATCH_A, (1<<TWINT)|(1<<TWEN)|(1<<TWEA)
	OUT	TWCR, I2C_SCRATCH_A
	RJMP	WAIT2

/*
Reads a byte from the bus. Sends an NACK at the end, saying that it will not listen to more data
- Sends that it is ready to read
- Waits for the byte to be recieved
- Puts the byte in the I2C_SCRATCH_B register
- Checks for an error
*/
I2C_READ:
	LDI	I2C_SCRATCH_A, (1<<TWINT)|(1<<TWEN)
	OUT	TWCR, I2C_SCRATCH_A
WAIT2:
	IN	I2C_SCRATCH_A, TWCR
	SBRS	I2C_SCRATCH_A, TWINT
	RJMP	WAIT2
	IN	I2C_SCRATCH_B, TWDR
	RCALL	I2C_READ_STATUS
	RET

/*
Writes a byte to the bus.
- Sends that it is ready to write
- Writes the byte that is in the I2C_SCRATCH_B register
- Checks for an error
*/
I2C_WRITE:
	OUT	TWDR, I2C_SCRATCH_B
	LDI	I2C_SCRATCH_A, (1<<TWINT)|(1<<TWEN)
	OUT	TWCR, I2C_SCRATCH_A
WAIT3:
	IN	I2C_SCRATCH_A, TWCR
	SBRS	I2C_SCRATCH_A, TWINT
	RJMP	WAIT3
	RCALL	I2C_READ_STATUS
	RET

/*
Sends a STOP signal to the bus, signalling that another device can use the bus
- Sends a STOP signal
*/
I2C_STOP:
	LDI I2C_SCRATCH_A, (1<<TWINT)|(1<<TWSTO)|(1<<TWEN)
	OUT	TWCR, I2C_SCRATCH_A
	RET

/*
Checks for an error with the last TWI operation
- Reads the TWI Status Register
- Masks off the 2 LSBs
*/
I2C_READ_STATUS:
	IN	I2C_SCRATCH_A, TWSR
	ANDI	I2C_SCRATCH_A, 0XF8
	RET
