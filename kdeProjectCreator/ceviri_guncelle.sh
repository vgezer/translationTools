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

# KDE4 Libs'i güncelle
#echo "KDE 4 Trunk Güncelleniyor..."
#cd kde4_tr_trunk
#svn up
#cd ..

read -r -p "Bu işlem, KDE Deposu'ndaki tüm proje dosyalarını güncelleyecek. Devam edilsin mi [eE]/hH? " cevap
cevap=${cevap:-e}
case "$cevap" in
    [hH]) 
        exit 0
        ;;
    *)
esac
ssh-add
# KDE5 trunk güncelle
echo "KDE 5 Trunk Güncelleniyor..."
cd kde5_tr_trunk
svn up
cd ..

# KDE5 stable güncelle
echo "KDE 5 Stable Güncelleniyor..."
cd kde5_tr_stable
svn up
cd ..

# KDE5 trunk şablonlarını güncelle
echo "KDE 5 Trunk Şablonları Güncelleniyor..."
cd templates_kde5
svn up
cd ..
