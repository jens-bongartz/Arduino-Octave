<<<<<<< HEAD
pkg load instrument-control;
clear all;
graphics_toolkit('qt');
#Windows - COM anpassen
serial_01 = serialport("COM9",115200);
#MacOSX - Pfad anpassen!
#serial_01 = serialport("/dev/cu.usbserial-1420",115200); 
configureTerminator(serial_01,"lf");
flush(serial_01);
adc_array = [];
ref_array = [];
x_index = 0;
cr_lf = [char(13) char(10)];      %% Zeichenkette CR/LF
inBuffer = [];                    %% Buffer serielle Schnittstelle

#
# Fuer Spannungs- und Widerstandsmessung eingefuegt
#
adc_mean = zeros(100,1);
mean_index = 1;
R_kar_index = 1;
R_kar_array = [0];

do
   bytesavailable = serial_01.numbytesavailable;
   
   if (bytesavailable > 0)
     
     inSerialPort = char(read(serial_01,bytesavailable)); %% Daten werden vom SerialPort gelesen
     inBuffer     = [inBuffer inSerialPort];              %% und an den inBuffer angeh�ngt
     posCRLF      = rindex(inBuffer, cr_lf);              %% Test auf CR/LF im inBuffer 
     if (posCRLF > 0)          
        inChar   = inBuffer(1:posCRLF-1);
        inBuffer = inBuffer(posCRLF+2:end);        
        inNumbers = strsplit(inChar,{',','ADC:','REF:'});
        count = length(inNumbers);
        for i = 2:2:count                                 %% erste Element bei strsplit ist �hier immer
           ref = str2num(inNumbers{i});                   %% ein Leerstring
           adc = str2num(inNumbers{i+1});
           adc_array(end+1)=adc;
           ref_array(end+1)=ref;
           x_index++;
           #
           # Spannungsmessung nur wenn D9 auf HIGH liegt 
           # 
           if (ref > 10)
             # Mittelwertbildung des ADC-Wertes
             # hier ueber 100 Messwerte
             adc_mean(mean_index) = adc;   
             mean_index++;
             if (mean_index > 100)
               mean_index = 1;
             endif
           endif
        endfor
        ##tic
        ##clf
        #plot(ref_array);
        ##hold on;
        #plot(adc_array);
        #if (x_index > 600)
          #axis([x_index-600 x_index  0 1100]);
        #endif
        
        mean_adc = sum(adc_mean)/100;
        #hold on;
        u_mess = (3.3/1023) * mean_adc;
        
        i_g = u_mess / 1000;
        
        R_kar  = (3.3 / i_g) - 1000
        
        R_kar_array(end+1) = R_kar;
        R_kar_index++;
        plot(R_kar_array);
        if (R_kar_index > 200)
          R_kar_display = R_kar_array(R_kar_index-200:R_kar_index);
          axis([R_kar_index-200 R_kar_index min(R_kar_display)-50 max(R_kar_display)+50]);
        endif
        ##toc
     endif   %% (posCRLF > 0)  
   endif     %% (bytesavailable > 0)
 
until(kbhit(1) == 'x');    %% Programmende wenn x-Taste gedr�ckt wird

clear serial_01;


=======
pkg load instrument-control;
clear all;
graphics_toolkit('qt');
#Windows - COM anpassen
serial_01 = serialport("COM9",115200);
#MacOSX - Pfad anpassen!
#serial_01 = serialport("/dev/cu.usbserial-1420",115200); 
configureTerminator(serial_01,"lf");
flush(serial_01);
adc_array = [];
ref_array = [];
x_index = 0;
cr_lf = [char(13) char(10)];      %% Zeichenkette CR/LF
inBuffer = [];                    %% Buffer serielle Schnittstelle

#
# Fuer Spannungs- und Widerstandsmessung eingefuegt
#
adc_mean = zeros(100,1);
mean_index = 1;
R_kar_index = 1;
R_kar_array = [0];

do
   bytesavailable = serial_01.numbytesavailable;
   
   if (bytesavailable > 0)
     
     inSerialPort = char(read(serial_01,bytesavailable)); %% Daten werden vom SerialPort gelesen
     inBuffer     = [inBuffer inSerialPort];              %% und an den inBuffer angeh�ngt
     posCRLF      = rindex(inBuffer, cr_lf);              %% Test auf CR/LF im inBuffer 
     if (posCRLF > 0)          
        inChar   = inBuffer(1:posCRLF-1);
        inBuffer = inBuffer(posCRLF+2:end);        
        inNumbers = strsplit(inChar,{',','ADC:','REF:'});
        count = length(inNumbers);
        for i = 2:2:count                                 %% erste Element bei strsplit ist �hier immer
           ref = str2num(inNumbers{i});                   %% ein Leerstring
           adc = str2num(inNumbers{i+1});
           adc_array(end+1)=adc;
           ref_array(end+1)=ref;
           x_index++;
           #
           # Spannungsmessung nur wenn D9 auf HIGH liegt 
           # 
           if (ref > 10)
             # Mittelwertbildung des ADC-Wertes
             # hier ueber 100 Messwerte
             adc_mean(mean_index) = adc;   
             mean_index++;
             if (mean_index > 100)
               mean_index = 1;
             endif
           endif
        endfor
        ##tic
        ##clf
        #plot(ref_array);
        ##hold on;
        #plot(adc_array);
        #if (x_index > 600)
          #axis([x_index-600 x_index  0 1100]);
        #endif
        
        mean_adc = sum(adc_mean)/100;
        #hold on;
        u_mess = (3.3/1023) * mean_adc;
        
        i_g = u_mess / 1000;
        
        R_kar  = (3.3 / i_g) - 1000
        
        R_kar_array(end+1) = R_kar;
        R_kar_index++;
        plot(R_kar_array);
        if (R_kar_index > 200)
          R_kar_display = R_kar_array(R_kar_index-200:R_kar_index);
          axis([R_kar_index-200 R_kar_index min(R_kar_display)-50 max(R_kar_display)+50]);
        endif
        ##toc
     endif   %% (posCRLF > 0)  
   endif     %% (bytesavailable > 0)
 
until(kbhit(1) == 'x');    %% Programmende wenn x-Taste gedr�ckt wird

clear serial_01;


>>>>>>> b71ecf13731fcf5a360391514dd49a5e7996e43c
