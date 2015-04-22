// If you want to debug the plotter without using a real serial port

int mockupValue = 0;
int mockupDirection = 10;
String mockupSerialFunction() {
  mockupValue = (mockupValue + mockupDirection);
  if (mockupValue > 100)
    mockupDirection = -10;
  else if (mockupValue < -100)
    mockupDirection = 10;
  String r = "";
  for (int i = 0; i<10; i++) {
    switch (i) {
    case 0:
      r += alert+" ";
      break;
    case 1:
      r += drowsy+" ";
      break;
    case 2:
      r += mockupValue/4+" ";
      break;
    case 3:
      r += mockupValue/8+" ";
      break;
    case 4:
      r += mockupValue/16+" ";
      break;
    case 5:
      r += mockupValue/32+" ";
      break;
  case 6:
      r += 100*cos(mockupValue*(2*3.14)/1000)+" ";
      break;
    case 7:
      r += mockupValue/4+" ";
      break;
  //  case 8:
   //   r += mockupValue/8+" ";
    //  break;
    //case 9:
     // r += mockupValue/16+" ";
      //break;
    }
    if (i < 10)
      r += '\r';
  }
  delay(10);
  return r;
}
