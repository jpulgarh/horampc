# horampc
Locución de la hora en MPD con MPC

Bash script que genera un archivo de audio para decir la hora cuando tienes una radio configurada con MPD/Icecast. Se utiliza el cliente MPC para tal efecto.

Los audios los puedes descargar desde los pregrabados que existen para Zara Radio (Windows), solo se debe modificar el nombre de los archivos que llevan un 0 (cero) delante del número, desde 00 hasta el 09, ya que Bash los traduce como octales y no como números enteros.

Asimismo, en la línea 39 y 40 del código realiza esta función de limpieza del cero (0) para evitar que la hora y los minutos (generado con date) los tome como octales y pueda coincidir con los archivos de audio.

Lo principal es que el script calcula el tiempo transcurrido de la canción y el tiempo total de la canción, por lo que genera la hora de acuerdo al tiempo que en un futuro coincidirá con la hora del reloj, esta función se hizo de acuerdo solo a minutos, por lo que sería ideal ajustarla en un futuro incluyendo segundos y así tener una hora mucho más exacta.

El script está hecho para que los audios los lea desde una carpeta llamada 'audios_hora' y dentro de esta carpeta se incluyó dos archivos pregrabados en formato mp3 antes que diga la hora de acuerdo a los audios descargados desde Zara Radio.

Al modificar el nombre de los archivos de audio, estos deben quedar así dentro de la carpeta 'audios_hora':
hora_final.mp3  HRS14_O.mp3  HRS1_O.mp3   HRS3_O.mp3  HRS9_O.mp3        MIN18.mp3  MIN29.mp3  MIN3.mp3   MIN50.mp3  MIN7.mp3
HRS0.mp3        HRS15.mp3    HRS20.mp3    HRS4.mp3    intro_radio1.mp3  MIN19.mp3  MIN2.mp3   MIN40.mp3  MIN51.mp3  MIN8.mp3
HRS0_O.mp3      HRS15_O.mp3  HRS20_O.mp3  HRS4_O.mp3  intro_radio2.mp3  MIN1.mp3   MIN30.mp3  MIN41.mp3  MIN52.mp3  MIN9.mp3
HRS10.mp3       HRS16.mp3    HRS21.mp3    HRS5.mp3    intro_radio3.mp3  MIN20.mp3  MIN31.mp3  MIN42.mp3  MIN53.mp3
HRS10_O.mp3     HRS16_O.mp3  HRS21_O.mp3  HRS5_O.mp3  MIN10.mp3         MIN21.mp3  MIN32.mp3  MIN43.mp3  MIN54.mp3
HRS11.mp3       HRS17.mp3    HRS22.mp3    HRS6.mp3    MIN11.mp3         MIN22.mp3  MIN33.mp3  MIN44.mp3  MIN55.mp3
HRS11_O.mp3     HRS17_O.mp3  HRS22_O.mp3  HRS6_O.mp3  MIN12.mp3         MIN23.mp3  MIN34.mp3  MIN45.mp3  MIN56.mp3
HRS12.mp3       HRS18.mp3    HRS23.mp3    HRS7.mp3    MIN13.mp3         MIN24.mp3  MIN35.mp3  MIN46.mp3  MIN57.mp3
HRS12_O.mp3     HRS18_O.mp3  HRS23_O.mp3  HRS7_O.mp3  MIN14.mp3         MIN25.mp3  MIN36.mp3  MIN47.mp3  MIN58.mp3
HRS13.mp3       HRS19.mp3    HRS2.mp3     HRS8.mp3    MIN15.mp3         MIN26.mp3  MIN37.mp3  MIN48.mp3  MIN59.mp3
HRS13_O.mp3     HRS19_O.mp3  HRS2_O.mp3   HRS8_O.mp3  MIN16.mp3         MIN27.mp3  MIN38.mp3  MIN49.mp3  MIN5.mp3
HRS14.mp3       HRS1.mp3     HRS3.mp3     HRS9.mp3    MIN17.mp3         MIN28.mp3  MIN39.mp3  MIN4.mp3   MIN6.mp3
