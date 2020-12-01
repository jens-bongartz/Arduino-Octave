pkg load instrument-control;
clear all;
#Windows - COM anpassen
serial_01 = serialport("COM9",115200);
#MacOSX - Pfad anpassen!
#serial_01 = serialport("/dev/cu.usbserial-1420",115200); 

flush(serial_01);
adc_array = [];
ref_array = [];
x_index = 0;

do
   bytesavailable = serial_01.numbytesavailable;
   
   if (bytesavailable > 0)
     inSerial = read(serial_01,bytesavailable);
     inChar = char(inSerial);
     inNumbers = strsplit(inChar,{',','ADC:','REF:'});
     count = length(inNumbers);
     for i = 2:2:count
        ref = str2num(inNumbers{i});
        adc = str2num(inNumbers{i+1});
        adc_array(end+1)=adc;
        ref_array(end+1)=ref;
        x_index++
     endfor
   endif
   tic
   clf
   plot(ref_array);
   hold on;
   plot(adc_array);
   if (x_index > 600)
      axis([x_index-600 x_index  0 1100]);
   endif
   toc
until(kbhit(1) == 'x');

clear serial_01;


