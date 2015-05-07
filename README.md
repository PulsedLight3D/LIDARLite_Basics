LIDARLite_Basics
========================================

This repository contains sample code demonstrating different features and functions of the LIDAR-Lite Sensor. As we test with more different micro controllers we will continue to add to this repo. 

***If you've made any code for specific systems, environments, or micro controllers, please fork and propose!***

*Each micro controller has its own folder and the README.md within that folder contains documentation for the code within that folder.*


## /Arduino

- **LIDARLite_Wire_Library_GetDistance_ContinuousRead**: Demonstrates taking a distance reading using the default Arduino Wire Library (works but is not the ideal configuration)
- **LIDARLite_I2C_Library_GetDistance_ContinuousRead**: Demonstrates taking a distance reading using the 'Arduino I2C Master Library' from DSS Circuits (a more sophisticated I2C library than the default Wire library)
- **LIDARLite_PWM_GetDistance_ContinuousRead**: Demonstrates taking a distance reading using Pulse-Width Modulation (PWM), does not require/use I2C

## Texas Instruments Tiva™ C Series LaunchPad
Simple code from Elias Olsson for reading distance values

## /Lynxmotion BotBoarduino
Example using the Wire library and based on the Servo library example "Sweep" example and the Pulsed Light 3D examples.

This examples uses the Wire library.

## RaspberryPi (also ODROID C1)
- **lidarLite** - RaspberryPi (or ODROID C1) interface to lidarLite using the Wiring library.  See [https://github.com/answer17/lidarLite](https://github.com/answer17/lidarLite)

## Beaglebone Black (and Arch Linux)
- [LIDAR lite with Beaglebone Black and Arch Linux by pedro_nf](https://pedronf65.wordpress.com/2015/03/15/lidar-lite-with-beaglebone-black-and-arch-linux/)

## ARMmbed

- [Library for easy interface of LidarLite with mbed using I2C by Akash Vibhute](http://developer.mbed.org/users/akashvibhute/code/LidarLite/)
- [Example of LidarLite library usage by Akash Vibhute](https://developer.mbed.org/users/akashvibhute/code/LidarLite_mbed/)

