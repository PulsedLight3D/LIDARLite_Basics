/*

http://pulsedlight3d.com

LIDAR-Lite Continuous Pulse-Width Modulation

The LIDAR-Lite has the ability to read distance without the use of I2C, simply 
by reading the amount of time a signal from the mode pin is HIGH. We then take that
duration (here measured in microseconds) and convert it to centimeters using the 
LIDAR-Lite constant of 10usec/cm. We then print that value to the serial monitor. 

Technical explanation is on page 15/16 of the operating manual: 
http://pulsedlight3d.com/pl3d/wp-content/uploads/2014/11/LIDAR-Lite-Operating-Manual.pdf

*/

unsigned long pulse_width;

void setup()
{
  Serial.begin(9600); // Start serial communications
  pinMode(2, OUTPUT); // Set pin 2 as trigger pin
  pinMode(3, INPUT); // Set pin 3 as monitor pin
  digitalWrite(2, LOW); // Set trigger LOW for continuous read
}

void loop()
{
  pulse_width = pulseIn(3, HIGH); // Count how long the pulse is high in microseconds
  if(pulse_width != 0){ // If we get a reading that isn't zero, let's print it
        pulse_width = pulse_width/10; // 10usec = 1 cm of distance for LIDAR-Lite
  	Serial.println(pulse_width); // Print the distance
  }
  delay(20); //Delay so we don't overload the serial port
}
