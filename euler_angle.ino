#include "NAxisMotion.h"        //import the library for the convenience of accessing the gyroscope sensor
#include <Wire.h>

int mega_address = 105;        // we set the I2C address here as 105
NAxisMotion mySensor;         //Object that for the sensor 
unsigned long lastStreamTime = 0;     //To store the last streamed time stamp
const int streamPeriod = 20;          //To stream at 50Hz without using additional timers (time period(ms) =1000/frequency(Hz))

void setup() //initialization codes
{    
  Serial.begin(115200);           //set the baud rate as 115200
  I2C.begin(mega_address);                    //set the I2C address

  //refer to the link below for the detail usage of NAxisMotion object 
  //https://github.com/arduino-org/arduino-library-nine-axes-motion/blob/master/src/NineAxesMotion.h
  
  mySensor.initSensor();         
  mySensor.setOperationMode(OPERATION_MODE_NDOF);   
  mySensor.setUpdateMode(MANUAL);	

  delay(1500);
  //indicate the arduino is connected successfully
  Serial.println('a');
  char a = 'b';
  while(a!='a')
  {
    a=Serial.read();
  }
}

void loop() //loop codes
{
      // if it does not exceed the time limit
     if ((millis() - lastStreamTime) >= streamPeriod){
        lastStreamTime = millis();
        int mode = Serial.read();
        //when received 'G', we update the data of gyroscope to Serial
        //it seems dummpy here, but when we consider some changes to 3D animation, it can be useful for the changeable
     
        if(mode=='G'){
          //Update the gyro data
          mySensor.updateGyro();
          //write the data of gyroscope
          Serial.println((mySensor.readGyroX()));
          Serial.println((mySensor.readGyroY()));
          Serial.println((mySensor.readGyroZ()));
          delay(200);
      }
    }            
}
