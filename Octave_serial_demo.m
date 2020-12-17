pkg load instrument-control;
clear all;
disp('Open SerialPort!')
#Windows - COM anpassen
serial_01 = serialport("COM5",115200);
#MacOSX - Pfad anpassen!
#serial_01 = serialport("/dev/cu.usbserial-1420",115200); 
configureTerminator(serial_01,"lf");
flush(serial_01);
adc_array = [];
ref_array = [];
x_index = 0;
cr_lf = [char(13) char(10)];      %% Zeichenkette CR/LF
inBuffer = [];                    %% Buffer serielle Schnittstelle

disp('Wait for data!')

do
until (serial_01.numbytesavailable > 0);

do
   bytesavailable = serial_01.numbytesavailable;
   
   if (bytesavailable > 0)
     %% Zeilenende (println) ist ASCII Kombination 13 10
     %% char(13) = CR char(10) = LF
     inSerialPort = char(read(serial_01,bytesavailable)); %% Daten werden vom SerialPort gelesen
     inBuffer     = [inBuffer inSerialPort];              %% und an den inBuffer angeh�ngt
     posCRLF      = rindex(inBuffer, cr_lf);              %% Test auf CR/LF im inBuffer 
     if (posCRLF > 0)          
        inChar   = inBuffer(1:posCRLF-1);
        inChar   = inChar(~isspace(inChar));              %% Leerzeichen aus inChar entfernen
        inBuffer = inBuffer(posCRLF+2:end);        
        inNumbers = strsplit(inChar,{',','ADC:','REF:'})
        count = length(inNumbers);
        for i = 2:2:count                                 %% erste Element bei strsplit ist �hier immer
           ref = str2num(inNumbers{i});                   %% ein Leerstring
           adc = str2num(inNumbers{i+1});
           adc_array(end+1)=adc;
           ref_array(end+1)=ref;
           x_index++;
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
   endif

until(kbhit(1) == 'x');    %% Programmende wenn x-Taste gedr�ckt wird

clear serial_01;


