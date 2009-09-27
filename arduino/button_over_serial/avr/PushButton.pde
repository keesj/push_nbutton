/*
 * push_nbutton project code
 * This code read the input pins 2 til 6 and send
 * a hexadecimal value over the serial when a value
 * changes
 */
 
 /* wireing setup
  * RIGHT pin 0
  * UP pin 1
  * LEFT pin 2 
  * DOWN pin 3
  * fire pin 4
  */

int inputRight = 2; 
int inputUp  = 3; 
int inputLeft = 4; 
int inputDown = 5; 
int inputFire = 6;

int val = 0;                    // variable for reading the pin status
int last_val = -1;

void setup() {
  Serial.begin(9600);
  pinMode(inputRight, INPUT);     // declare pushbutton as input
  pinMode(inputUp, INPUT);        // declare pushbutton as input
  pinMode(inputLeft, INPUT);      // declare pushbutton as input
  pinMode(inputDown, INPUT);      // declare pushbutton as input
  pinMode(inputFire, INPUT);      // declare pushbutton as input
  
}

void loop(){
  val = digitalRead(inputRight);
  val |= digitalRead(inputUp) << 1;
  val |= digitalRead(inputLeft) << 2;
  val |= digitalRead(inputDown) << 3;
  val |= digitalRead(inputFire) << 4;
  if (last_val != val){
      Serial.println( val, HEX);
  }
  last_val = val;
}
