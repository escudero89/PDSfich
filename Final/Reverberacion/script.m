#! /usr/bin/octave -qf
1;

# Hago un script (lo podria hacer desde la consola) pero por las dudas si le
# pifie en algo (y asi te quedas mas tranquilo (??))

load('IR_FS_11025_D_0.2_R_10_AZ_30_E_S1');

wavwrite(data(:, 1), Fs, 'izquierda.wav');
wavwrite(data(:, 2), Fs, 'derecha.wav');


# Te mando uno sin eco ademas por si queres experimentar (??)

load('IR_FS_11025_D_0.2_R_10_AZ_30_NE_S1');

wavwrite(data(:, 1), Fs, 'sin_eco/izquierda_NE.wav');
wavwrite(data(:, 2), Fs, 'sin_eco/derecha_NE.wav');
