/*

LIDAR-Lite Continuous Pulse-Width Modulation

The LIDAR-Lite has the ability to read distance without the use of I2C, simply 
by reading the amount of time a signal from the mode pin is HIGH. We then take that
duration (here measured in microseconds) and convert it to centimeters using the 
LIDAR-Lite constant of 10usec/cm. We then print that value to the serial monitor. 

The wiring diagram and explanation is here: 

*/

unsigned long pulse_width;

void setup()
{
  Serial.begin(9600); // Start serial communications
  pinMode(3, OUTPUT); // Set pin 3 as trigger pin
  pinMode(2, INPUT); // Set pin 2 as monitor pin
  digitalWrite(3, LOW); // Set trigger LOW for continuous read
}

void loop()
{
  pulse_width = pulseIn(2, HIGH); // Count how long the pulse is high in microseconds
  if(pulse_width != 0){ // If we get a reading that isn't zero, let's print it
        pulse_width = pulse_width/10; // 10usec = 1 cm of distance for LIDAR-Lite
  	Serial.println(pulse_width); // Print the distance
  }
  delay(20); //Delay so we don't overload the serial port
}
