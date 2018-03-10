/****************************************************************************
* Copyright (C) 2011 - 2014 Bosch Sensortec GmbH
*
* Euler.ino
* Date: 2014/09/09
* Revision: 3.0 $
*
* Usage:        Example code to stream Euler data
*
****************************************************************************
/***************************************************************************
* License:
*
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions are met:
*
*   Redistributions of source code must retain the above copyright
*   notice, this list of conditions and the following disclaimer.
*
*   Redistributions in binary form must reproduce the above copyright
*   notice, this list of conditions and the following disclaimer in the
*   documentation and/or other materials provided with the distribution.
*
*   Neither the name of the copyright holder nor the names of the 
*   contributors may be used to endorse or promote products derived from 
*   this software without specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
* ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
* WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
* DISCLAIMED. IN NO EVENT SHALL COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY
* DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
* (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
* LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
* ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
* (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
* SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE
* 
* The information provided is believed to be accurate and reliable.
* The copyright holder assumes no responsibility for the consequences of use
* of such information nor for any infringement of patents or
* other rights of third parties which may result from its use.
* No license is granted by implication or otherwise under any patent or
* patent rights of the copyright holder. 
*/

#include "NAxisMotion.h"        //Contains the bridge code between the API and the Arduino Environment
#include <Wire.h>
#include <Servo.h>

#define CTRL_REG1 0x20
#define CTRL_REG2 0x21
#define CTRL_REG3 0x22
#define CTRL_REG4 0x23
#define CTRL_REG5 0x24
int mega_address = 105;
NAxisMotion mySensor;         //Object that for the sensor 
unsigned long lastStreamTime = 0;     //To store the last streamed time stamp
const int streamPeriod = 20;          //To stream at 50Hz without using additional timers (time period(ms) =1000/frequency(Hz))
//Servo myservo;

void setup() //This code is executed once
{    
  //Peripheral Initialization
  Wire.begin();
  Serial.begin(115200);           //Initialize the Serial Port to view information on the Serial Monitor
  I2C.begin(105);                    //Initialize I2C communication to the let the library communicate with the sensor.
  //myservo.attach(9);
  //myservo.write(0);
  //Sensor Initialization
  mySensor.initSensor();          //The I2C Address can be changed here inside this function in the library
  mySensor.setOperationMode(OPERATION_MODE_NDOF);   //Can be configured to other operation modes as desired
  mySensor.setUpdateMode(MANUAL);	//The default is AUTO. Changing to MANUAL requires calling the relevant update functions prior to calling the read functions
  //Setting to MANUAL requires fewer reads to the sensor  
  //writeRegister(mega_address,CTRL_REG1,0b00001111);
  //writeRegister(mega_address,CTRL_REG4,0b0011000);
  
  delay(1500);
  Serial.println('a');
  char a = 'b';
  while(a!='a')
  {
    a=Serial.read();
  }
}

void loop() //This code is looped forever
{
  
     if ((millis() - lastStreamTime) >= streamPeriod){
      lastStreamTime = millis();
    int mode = Serial.read();
    if(mode=='G'){
        mySensor.updateGyro();
        Serial.println((mySensor.readGyroX()));
        Serial.println((mySensor.readGyroY()));
        Serial.println((mySensor.readGyroZ()));
        delay(200);
    }
   
    }            
    //Update the Euler data into the structure of the object
    //mySensor.updateCalibStatus();  
    //Update the Calibration Status
}
void writeRegister(int deviceaddress,byte address,byte val){
  Wire.beginTransmission(deviceaddress);
  Wire.write(address);
  Wire.write(val);
  Wire.endTransmission();
}