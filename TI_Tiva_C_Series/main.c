#include <stdbool.h>
#include <stdint.h>
#include "driverlib/debug.h"
#include "driverlib/sysctl.h"
#include "I2C_init.h"


uint16_t LidarWriteAddr = 0xc4;
uint16_t LidarReadAddr = 0xc5;
uint16_t Lidar2ByteRead = 0x8f;


int16_t ReadDistance()
{
	// Integer to store data
	uint16_t Dist = 0;

	// Prepare Lidar for reading
	I2CSend(LidarWriteAddr,0x00,0x04);

	//wait for 20 ms
	SysCtlDelay(SysCtlClockGet() / (160));

	// Read Data
	Dist =  I2CReceive(LidarReadAddr,LidarWriteAddr,Lidar2ByteRead);

    return Dist;
}


void main(void)
{
    // Set the clocking to run directly from the external crystal/oscillator.
    SysCtlClockSet(SYSCTL_SYSDIV_5 | SYSCTL_USE_PLL | SYSCTL_OSC_INT | SYSCTL_XTAL_16MHZ);

    // 16 bit integer to store reading in.
    uint16_t Distance;

    // Initilize I2C protocoll
    InitI2C1();

    // Prepare Lidar for higher sample-rate, less accurate.
    I2CSend(LidarWriteAddr,0x00,0x04);

    // Infite while-loop
    while(1)
    {
    	// Distance
    	Distance=ReadDistance();

    };
}

