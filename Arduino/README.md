LIDARLite_Basics/Arduino
========================================

This repository contains sample Arduino sketches for LIDAR-Lite Sensor. 

### Contents
- **LIDARLite_Wire_Library_GetDistance_ContinuousRead**: Demonstrates taking a distance reading using the default Arduino Wire Library (works but is not the ideal configuration)
- **LIDARLite_I2C_Library_GetDistance_ContinuousRead**: Demonstrates taking a distance reading using the 'Arduino I2C Master Library' from DSS Circuits (a more sophisticated I2C library than the default Wire library)
- **LIDARLite_PWM_GetDistance_ContinuousRead**: Demonstrates taking a distance reading using Pulse-Width Modulation (PWM), does not require/use I2C
