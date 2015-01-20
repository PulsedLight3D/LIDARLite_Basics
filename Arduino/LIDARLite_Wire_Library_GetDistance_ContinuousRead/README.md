LIDARLite_Wire_Library_GetDistance_ContinuousRead
========================================

Demonstrates taking a distance reading using the default Arduino Wire Library (works but is not the ideal configuration)

## Dependencies
1. Arduino Uno compatible Board
2. Arduino IDE (1.0.6 or newer)
3. USB Cable
4. LIDAR-Lite Sensor

## Installation
1. Download Repository and open with Arduino IDE

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
