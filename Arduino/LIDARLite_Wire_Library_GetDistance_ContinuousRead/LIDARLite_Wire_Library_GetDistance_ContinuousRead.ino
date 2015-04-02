
/* 

http://pulsedlight3d.com

This sketch demonstrates getting distance with the LIDAR-Lite Sensor

It utilizes the 'Arduino Wire Library'

*/

#include <Wire.h>
#define    LIDARLite_ADDRESS   0x62          // Default I2C Address of LIDAR-Lite.
#define    RegisterMeasure     0x00          // Register to write to initiate ranging.
#define    MeasureValue        0x04          // Value to initiate ranging.
#define    RegisterHighLowB    0x8f          // Register to get both High and Low bytes in 1 call.

int reading = 0;

void setup()
{
  delay(2000);
  Wire.begin(); // join i2c bus
  Serial.begin(9600); // start serial communication at 9600bps
  Serial.println("<start>");
}

void loop()
{
//  Serial.println("> loop - 01");
  Wire.beginTransmission((int)LIDARLite_ADDRESS); // transmit to LIDAR-Lite
  Wire.write((int)RegisterMeasure); // sets register pointer to  (0x00)  
  Wire.write((int)MeasureValue); // sets register pointer to  (0x00)  
  Wire.endTransmission(); // stop transmitting
//  Serial.println("> loop - 02");

  delay(20); // Wait 20ms for transmit

//  Serial.println("> loop - 03");
  Wire.beginTransmission((int)LIDARLite_ADDRESS); // transmit to LIDAR-Lite
  Wire.write((int)RegisterHighLowB); // sets register pointer to (0x8f)
  Wire.endTransmission(); // stop transmitting
//  Serial.println("> loop - 04");

  delay(20); // Wait 20ms for transmit

//  Serial.println("> loop - 05");
  Wire.requestFrom((int)LIDARLite_ADDRESS, 2); // request 2 bytes from LIDAR-Lite
//  Serial.println("> loop - 06");

  if(2 <= Wire.available()) // if two bytes were received
  {
//    Serial.println("> loop - 07");
    reading = Wire.read(); // receive high byte (overwrites previous reading)
    reading = reading << 8; // shift high byte to be high 8 bits
    reading |= Wire.read(); // receive low byte as lower 8 bits
    Serial.println(reading); // print the reading
//    Serial.println("> loop - 08");
  }
//  Serial.println("> loop - 09");
}

