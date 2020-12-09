#!/bin/bash

#  Copyright (C) 2017-2020  Volkan Gezer <volkangezer@gmail.com>

#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.


read -r -p "Bu işlem, proje içerisindeki tüm PO dosyalarını sistem içerisindeki dosyalar ile değiştirip, çevirileri hemen kullanmanızı sağlayacak. Devam edilsin mi [eE]/hH? " cevap
cevap=${cevap:-e}
case "$cevap" in
    [hH]) 
        exit 0
        ;;
    *)
esac

cd kde5_tr_trunk

echo -e "PO dosyalarını bul, her birini msgfmt ile işle ve sonuçları MO dosyası olarak adlandır...\n Bu işlem biraz zaman alabilir."

for file in `find messages -name "*.po"` ; do msgfmt -o `echo $file | sed 's/\.po$/.mo/'` $file ; done

echo "Şimdi dönüştürülen tüm MO dosyalarını uygulama dizinine aktar."
echo "Bu işlem için isteniyorsa yönetici parolasını girmeniz gerekecek."

sudo find . -iname '*.mo' -exec mv '{}' /usr/share/locale/tr/LC_MESSAGES/ \;
