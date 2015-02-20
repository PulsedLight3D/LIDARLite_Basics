LIDARLite_Basics
========================================

This repository contains sample code demonstrating different features and functions of the LIDAR-Lite Sensor. As we test with more different micro controllers we will continue to add to this repo. 

***If you've made any code for specific systems, environments, or micro controllers, please fork and propose!***

*Each micro controller has its own folder and the README.md within that folder contains documentation for the code within that folder.*


## /Arduino

- **LIDARLite_Wire_Library_GetDistance_ContinuousRead**: Demonstrates taking a distance reading using the default Arduino Wire Library (works but is not the ideal configuration)
- **LIDARLite_I2C_Library_GetDistance_ContinuousRead**: Demonstrates taking a distance reading using the 'Arduino I2C Master Library' from DSS Circuits (a more sophisticated I2C library than the default Wire library)
- **LIDARLite_PWM_GetDistance_ContinuousRead**: Demonstrates taking a distance reading using Pulse-Width Modulation (PWM), does not require/use I2C

## RaspberryPi (also ODROID C1)
- **lidarLite** - RaspberryPi (or ODROID C1) interface to lidarLite using the Wiring library.  See [https://github.com/answer17/lidarLite] 
