pkg load instrument-control;

serial_01 = serialport("COM9",115200);

flush(serial_01);

do
   bytesavailable = get(serial_01,"numbytesavailable");
   
   if (bytesavailable > 0)
     inSerial = fread(serial_01);
     inChar = char(inSerial)
   endif

until(kbhit(1) == 'x');

clear serial_01;


