LIDARLite_I2C_Library_GetDistance_ContinuousRead
========================================

Demonstrates taking a distance reading using the 'Arduino I2C Master Library' from DSS Circuits (a more sophisticated I2C library than the default Wire library)

## Dependencies
1. Arduino Uno compatible Board
2. Arduino IDE (1.0.6 or newer)
3. USB Cable
4. LIDAR-Lite Sensor
5. The 'Arduino I2C Master Library' from DSS Circuits: http://www.dsscircuits.com/index.php/articles/66-arduino-i2c-master-library

## Installation
1. Download Repository and open with Arduino IDE
2. Install DSS "Arduino I2C Master Library" - Information about installing libraries can be found:  
http://arduino.cc/en/Guide/Libraries

## Arduino Setup

Note: the current picture is wrong with regards to SDA, SCL pin
location on the Arduino boards.  This table is correct.

Arduino Board | SDA, SCL Pins
:--------------|:--------------
Uno, Pro Mini | A4 (SDA), A5 (SCL)
Mega2560      | 20 (SDA), 21 (SCL)
Leonardo      | 2 (SDA), 3 (SCL)
Due           |20 (SDA), 21 (SCL), SDA1, SCL1

![arduino-screenshot](http://pulsedlight3d.com/pl3d/wp-content/uploads/2014/10/arduino-setup.png)

### LIDARLite I2C Connection Setup
LIDARLite Cable | Arduino Pins
:---|:---
5V | 5V
PWR EN | _(Unused)_
MODE | _(Unused)_
SCL | SCL (topmost pin on the right hand side of Arduino)
SDA | SDA (second pin from the top on the right hand side of Arduino)
GND | GND

## Usage

1. [Connect an Arduino](#arduino-setup) and upload code
2. Open the serial monitor (Make sure baud rate is set to 9600)
3. The distance measured in centimeters (cm) will print to the serial monitor

## Note
You can increase the baud rate for faster reads
