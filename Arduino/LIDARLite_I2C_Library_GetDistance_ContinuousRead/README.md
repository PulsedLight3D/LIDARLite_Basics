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

![arduino-screenshot](http://pulsedlight3d.net/assets.pl3d/arduino-setup.png)

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
