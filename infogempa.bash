#!/bin/bash
# Dibuat oleh komunitas Open Source dan Keamanan Komputer
# https://zerobyte.id/

VERSI="1.4";

if [[ $1 == "--version" ]];then
	echo "Versi $VERSI";
	exit;
fi
if [[ $1 == "--help" ]];then
	echo " -v / --version  : Digunakan untuk melihat versi tool ini";
	exit;
fi
if [[ -z $(command -v curl) ]];then
	echo "error: mohon untuk install \"curl\" terlebih dahulu.";
	exit;
fi
if [[ -z $(command -v column) ]];then
	echo "error: mohon untuk install \"column\" terlebih dahulu.";
	exit;
fi

COLINE='--,----------------------,-------,------,-----,---------,----------------------------------';
echo "$COLINE" > /tmp/INFOGEMPA.TEMP
echo "No,Waktu,Lintang,Bujur,Skala,Kedalaman,Wilayah" >> /tmp/INFOGEMPA.TEMP
echo "$COLINE" >> /tmp/INFOGEMPA.TEMP
curl -s https://www.bmkg.go.id/gempabumi/gempabumi-terkini.bmkg | grep -A8 '<tr>' | sed -e "s/[[:space:]]\+/ /g" | sed 's/--//g' | sed ':a;N;$!ba;s/\n/ /g' | sed 's/<\/tr>/\n/g' | sed 's/   //g' | sed 's/^ //g' | sed 's/<\/td><td>/,/g' | sed 's/<tr><td>//g' | sed 's/<\/td>//g' | sed 's/<br>//g' | sed '/^\s*$/d' >> /tmp/INFOGEMPA.TEMP
echo "$COLINE" >> /tmp/INFOGEMPA.TEMP
if [[ $(cat /tmp/INFOGEMPA.TEMP | wc -l) -le 4 ]];then
	echo "error: tolong periksa koneksi internet anda.";
	rm /tmp/INFOGEMPA.TEMP
	exit;
fi
echo "";
echo " * INFORMASI GEMPA BUMI TERKINI";
echo " * Badan Meteorologi Klimatologi dan Geofisika";
echo "";
cat /tmp/INFOGEMPA.TEMP | sed -e 's/^/| /' -e 's/,/,| /g' -e 's/$/,|/' | grep -v 'Waktu Gempa' | column -t -s,
rm /tmp/INFOGEMPA.TEMP
