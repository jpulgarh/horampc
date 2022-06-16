# horampc
Locución de la hora en MPD con MPC

Bash script que genera un archivo de audio para decir la hora cuando tienes una radio configurada con MPD/Icecast. Se utiliza el cliente MPC para tal efecto.

Los audios los puedes descargar desde los pregrabados que existen para Zara Radio (Windows), solo se debe modificar el nombre de los archivos que llevan un 0 (cero) delante del número, desde 00 hasta el 09, ya que Bash los traduce como octales y no como números enteros.

Asimismo, en la línea 39 y 40 del código realiza esta función de limpieza del cero (0) para evitar que la hora y los minutos (generado con date) los tome como octales y pueda coincidir con los archivos de audio.

Lo principal es que el script calcula el tiempo transcurrido de la canción y el tiempo total de la canción, por lo que genera la hora de acuerdo al tiempo que en un futuro coincidirá con la hora del reloj, esta función se hizo de acuerdo solo a minutos, por lo que sería ideal ajustarla en un futuro incluyendo segundos y así tener una hora mucho más exacta.

El script está hecho para que los audios los lea desde una carpeta llamada 'audios_hora' y dentro de esta carpeta se incluyó dos archivos pregrabados en formato mp3 antes que diga la hora de acuerdo a los audios descargados desde Zara Radio.

Al modificar el nombre de los archivos de audio, estos deben quedar así dentro de la carpeta 'audios_hora', cabe destacar que son más archivos pero los demás no se les modificó el nombre, solo a los que tenían 08, 09, 00, etc:

HRS0.mp3
HRS0_O.mp3
HRS1.mp3
HRS1_O.mp3
HRS2.mp3   
HRS2_O.mp3
HRS3.mp3
HRS3_O.mp3
HRS4.mp3
HRS4_O.mp3
HRS5.mp3
HRS5_O.mp3
HRS6.mp3
HRS6_O.mp3
HRS7.mp3
HRS7_O.mp3
HRS8.mp3
HRS8_O.mp3
HRS9.mp3
HRS9_O.mp3
MIN1.mp3
MIN2.mp3
MIN3.mp3
MIN4.mp3
MIN5.mp3
MIN6.mp3
MIN7.mp3
MIN8.mp3
MIN9.mp3
intro_radio1.mp3
intro_radio2.mp3  
intro_radio3.mp3
