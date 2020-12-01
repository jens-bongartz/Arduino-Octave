#include <TimerOne.h>

int faADC  = 200;

int msHigh = 100;
int msLow  = 900;    // Digitaler Ausgang
int outChannel = 9;  // D9
// Analoge Eingänge
int refChannel = 1;  // A1
int adcChannel = 0;  // A0

void setup() {
  // put your setup code here, to run once:
  pinMode(outChannel,OUTPUT);
  Serial.begin(115200);
  Timer1.initialize(1000000/faADC);             
  Timer1.attachInterrupt(readADC);                             
}

void loop() {
  // put your main code here, to run repeatedly:
  digitalWrite(outChannel,HIGH);
  delay(msHigh);
  digitalWrite(outChannel,LOW);
  delay(msLow);
}

void readADC() {
  int refValue = analogRead(refChannel);
  int adcValue = analogRead(adcChannel);
  Serial.print("REF:");
  Serial.print(refValue);
  Serial.print(",");
  Serial.print("ADC:");
  Serial.println(adcValue);
}

void serialEvent() {
  char inChar = Serial.read();
  if (inChar == 's') {   // 's'top
    Timer1.stop();
  }
  if (inChar == 't') {   //  restar't'
    Timer1.restart();
  }
}
