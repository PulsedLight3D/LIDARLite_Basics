#ifndef I2C_INIT_H
#define I2C_INIT_H

//Initializing function for I2C1
void InitI2C1(void);

// Read function for I2C1
uint16_t I2CReceive(uint16_t,uint16_t, uint8_t);

//Write to I2C1
uint16_t I2CSend(uint16_t , uint8_t , uint8_t);

#endif

