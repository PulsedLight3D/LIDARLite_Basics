/* 
http://pulsedlight3d.com
This sketch demonstrates getting distance with the LIDAR-Lite Sensor
It utilizes the 'Arduino Wire Library'
(tidied up by Mark Harrison, mh@pixar.com)
*/

#include <Wire.h>
#define LIDARLite_ADDRESS 0x62  // Default I2C Address of LIDAR-Lite.
#define RegisterMeasure   0x00  // Register to write to initiate ranging.
#define MeasureValue      0x04  // Value to initiate ranging.
#define RegisterHighLowB  0x8f  // Register to get both High and Low bytes in 1 call.

int reading = 0;

void setup()
{
  Wire.begin();       // join i2c bus
  Serial.begin(9600); // start serial communication
}

void loop()
{
  Wire.beginTransmission(LIDARLite_ADDRESS); // transmit to LIDAR-Lite
  Wire.write(RegisterMeasure);               // set register pointer to 0x00  
  Wire.write(MeasureValue);                  // set register pointer to 0x00  
  Wire.endTransmission();                    // stop transmitting

  delay(20);                                 // Wait 20ms for transmit

  Wire.beginTransmission(LIDARLite_ADDRESS); // transmit to LIDAR-Lite
  Wire.write(RegisterHighLowB);              // set register pointer to 0x8f
  Wire.endTransmission();                    // stop transmitting

  delay(20);                                 // Wait 20ms for transmit

  Wire.requestFrom(LIDARLite_ADDRESS, 2);    // request 2 bytes from LIDAR-Lite

  if(Wire.available() >= 2)  // if two bytes were received
  {
    reading = Wire.read();   // receive high byte (overwrites previous reading)
    reading = reading << 8;  // shift high byte to be high 8 bits
    reading |= Wire.read();  // receive low byte as lower 8 bits
    Serial.println(reading); // print the reading
  }
}
