#!/bin/bash
# Dibuat oleh komunitas Open Source dan Keamanan Komputer
# https://zerobyte.id/

VERSI="1.0";

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

echo "--,----------------------,-------,------,---------,---------,---------------------" > GEMPAINFO.TEMP
echo "No,Waktu,Lintang,Bujur,Magnitudo,Kedalaman,Wilayah" >> GEMPAINFO.TEMP
echo "--,----------------------,-------,------,---------,---------,---------------------" >> GEMPAINFO.TEMP
curl -s http://www.bmkg.go.id/gempabumi/gempabumi-terkini.bmkg | grep -A8 '<tr>' | sed -e "s/[[:space:]]\+/ /g" | sed 's/--//g' | sed ':a;N;$!ba;s/\n/ /g' | sed 's/<\/tr>/\n/g' | sed 's/   //g' | sed 's/^ //g' | sed 's/<\/td><td>/,/g' | sed 's/<tr><td>//g' | sed 's/<\/td>//g' | sed 's/<br>//g' | sed '/^\s*$/d' >> GEMPAINFO.TEMP
if [[ $(cat GEMPAINFO.TEMP | wc -l) -le 3 ]];then
	echo "error: tolong periksa koneksi internet anda.";
	rm GEMPAINFO.TEMP
	exit;
fi
echo "";
echo " * INFORMASI GEMPA BUMI TERKINI";
echo " * Badan Meteorologi Klimatologi dan Geofisika";
echo "";
cat GEMPAINFO.TEMP | sed -e 's/^/| /' -e 's/,/,| /g' -e 's/$/,|/' | grep -v 'Waktu Gempa' | column -t -s,
rm GEMPAINFO.TEMP
