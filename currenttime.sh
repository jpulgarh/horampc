#!/bin/bash

# Solo funciona bien con canciones que duren menos de 10 minutos, se debe modificar para temas más extensos
# t1 = Tiempo transcurrido; t2 = Tiempo total de la canción
t1="00:0"$(mpc status | grep '%)' | awk '{ print $3 }' | awk -F/ '{ print $1 }')
t2="00:0"$(mpc status -f '%time%' | sed -n 1p)

function diff_dates() {
  TS1=$(date -d "$1" +%s)
  TS2=$(date -d "$2" +%s)
  [ $TS2 -ge $TS1 ] \
    && TZ=UTC date -d @$((TS2-TS1)) +%H:%M:%S \
    || TZ=UTC date -d @$((TS1-TS2)) +-%H:%M:%S
}

diferencia=$(diff_dates $t1 $t2)
# Hora actual
DS_1=$(date +%H:%M:%S)
# Hora actual en SEGUNDOS
DS_2=$(date +%s)
# Resta de hora tiempo total de la canción menos tiempo transcurrido
DS_3=$(date -d "$diferencia" +%s)
# Hora diferencia en format H:M:S
DS_6=$(date -d "$diferencia" +%H:%M:%S)
# Hora actual sumado al tiempo restante que le queda a la canción en formato H:M:S
DS_5=$(date -d @$((DS_2+DS_3)) +%H:%M:%S)
# Medianoche (sirve como referencia para agregar los segundos faltantes)
DS_7=$(date -d "00:00:00" +%s)
# Resta en segundos entre la hora actual y la hora en que termina la CANCIÓN
DS_8=$(date -d @$((DS_3-DS_7)) +%s)
DS_9=$(date -d @$((DS_8+DS_2)) +%H:%M:%S)

hora_final="/home/jp/api/audios_hora/hora_final.mp3"
lista_horas="/home/jp/api/lista_horas.txt"

function generarHora() {
  DS_CERO="_O"
  # Limpiando los octales y dejándolos como números enteros
  DS_HORA=${DS_HORA#0}
  DS_MINUTOS=${DS_MINUTOS#0}

  ##################
  ## HORA ----------
  ##################
  if [[ $DS_HORA -lt 24 && $DS_MINUTOS -eq 00 ]]; then
    hora="/home/jp/api/audios_hora/HRS$DS_HORA$DS_CERO.mp3"
  elif [[ $DS_HORA -lt 24 && $DS_MINUTOS -ne 00 ]]; then
    hora="/home/jp/api/audios_hora/HRS$DS_HORA.mp3"
  else
    echo "[!!] Error en la hora"
  fi

  ##################
  ## MINUTOS -------
  ##################
  if [[ $DS_MINUTOS -ne 00 ]]; then
    minuto="/home/jp/api/audios_hora/MIN$DS_MINUTOS.mp3"
  else
    echo "[??] Minutos corresponde a 00, no hago nada"
  fi

  if [[ $DS_MINUTOS -eq 00 ]]; then
    echo "file '/home/jp/api/audios_hora/intro_radio1.mp3'" > /home/jp/api/lista_horas.txt
    echo "file '$hora'"  >> /home/jp/api/lista_horas.txt
  elif [[ $DS_MINUTOS -lt 60 && $DS_MINUTOS -ge 00 ]]; then
    echo "file '/home/jp/api/audios_hora/intro_radio2.mp3'"  > /home/jp/api/lista_horas.txt
    echo "file '$hora'"  >> /home/jp/api/lista_horas.txt
    echo "file '$minuto'"  >> /home/jp/api/lista_horas.txt
  else
    echo "[!!] Error de código"
    exit 1
  fi
}

function marcador() {
  echo "#################### HORA ACTUAL Y SEGUNDOS FALTANTES DE LA CANCIÓN EN SEGUNDOS"
  echo $DS_3 "   - tiempo faltante para la siguiente canción en formato segundos"
  echo $DS_7 "   - hora referencia inicial 00:00:00 en formato SEGUNDOS"
  echo "#################### HORA ACTUAL EN FORMATO H:M:S"
  echo $DS_1 "     - hora actual"
  echo $DS_9 "     - hora a utilizar para generar la hora en audio"
  echo "#################### DIFERENCIA TIEMPO EN LA CANCIÓN"
  echo $t1 "     - tiempo transcurrido"
  echo $t2 "     - tiempo total de la canción"
  echo "#################### DIFERENCIA EN MINUTOS Y SEGUNDOS ENTRE EL TOTAL DE LA CANCIÓN Y EL TIEMPO TRANSCURRIDO"
  echo $diferencia "     - tiempo faltante para la siguiente canción"
  echo $DS_6 "     - hora diferencia"
  echo "#################### RESTA EN SEGUNDOS ENTRE LA HORA ACTUAL Y LA HORA QUE TERMINA LA canción"
  echo $DS_8
}

function generarAudio() {
  echo "Generando el audio de la hora actual"
  echo "[1/3] Transformando de hora a audio con ffmpeg"
  ffmpeg -y -f concat -safe 0 -i $lista_horas -c copy $hora_final #> /dev/null 2>&1
  echo "[2/3] Agregando el archivo hora a la playlist de MPD"
  mpc add $hora_final
  echo "[3/4] Esperando que termine la canción para decir la hora"
  mpc current --wait && mpc play $(mpc playlist | wc -l) && mpc current --wait && mpc del $(mpc playlist | wc -l)
}

if (($DS_8<20)); then
  echo "[??] Es menor a 20 segundos de diferencia"
else
  echo "[??] Es mayor a 20 segundos"
  marcador
  DS_HORA=$(date -d $DS_9 +%H)
  DS_MINUTOS=$(date -d $DS_9 +%M)
  #DS_HORA=00
  #DS_MINUTOS=07
  generarHora $DS_HORA $DS_MINUTOS
  generarAudio
fi
