LIDARLite_Basics/Arduino
========================================

This repository contains sample Arduino sketches for LIDAR-Lite Sensor. 

### Contents
- [LIDARLite_Wire_Library_GetDistance_ContinuousRead]()
- [LIDARLite_I2C_Library_GetDistance_ContinuousRead]()
- [LIDARLite_PWM_GetDistance_ContinuousRead]()

----

# LIDARLite_Wire_Library_GetDistance_ContinuousRead

Demonstrates taking a distance reading using the default Arduino Wire Library (works but is not the ideal configuration)

----

# LIDARLite_I2C_Library_GetDistance_ContinuousRead

Demonstrates taking a distance reading using the 'Arduino I2C Master Library' from DSS Circuits (a more sophisticated I2C library than the default Wire library)

## Dependencies
1. Arduino Uno compatible Board
2. Arduino IDE (1.0.5 or newer)
3. USB Cable
4. LIDAR-Lite Sensor
5. The 'Arduino I2C Master Library' from DSS Circuits: http://www.dsscircuits.com/index.php/articles/66-arduino-i2c-master-library

## Installation
1. Download Repository and open with Arduino IDE
2. Install DSS "Arduino I2C Master Library" - Information about installing libraries can be found:  
http://arduino.cc/en/Guide/Libraries

## Arduino Setup

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

----

# LIDARLite_PWM_GetDistance_ContinuousRead

Demonstrates taking a distance reading using Pulse-Width Modulation (PWM), does not require/use I2C

