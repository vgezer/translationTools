#!/bin/bash

#  Copyright (C) 2017  Volkan Gezer <volkangezer@gmail.com>

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

clear
echo -e "KDE Çeviri Hazırlama Betiğine Hoş Geldiniz!\n"
echo -e "Bu betik, depoya yazma yetkisi olmayan kullanıcılar için çeviri ortamını hazırlayacak.\nGerekli çeviri (PO) ve şablon dosyaları (POT) depolardan indirilecek, \nardından KDE 5 çevirisi için Lokalize proje dosyası oluşturulacak. \nKurulum, bazı yardımcı betikleri kopyaladıktan sonra Lokalize uygulamasını bu proje ile açacak."

read -r -p "Kuruluma devam edilsin mi? [e]/h " cevap
cevap=${cevap:-e}
case "$cevap" in
    [hH]) 
        exit 0
        ;;
    *)
esac

# KDE4 Libs'i klonla
#echo "KDE 4 Trunk Klonlanıyor..."
#svn co svn://anonsvn.kde.org/home/kde/trunk/l10n-kde4/tr/ kde4_tr_trunk

# KDE5 trunk klonla
echo "KDE 5 Trunk Klonlanıyor..."
svn co -q svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/tr/ kde5_tr_trunk
# KDE5 stable klonla
echo "KDE 5 Stable Klonlanıyor..."
svn co -q svn://anonsvn.kde.org/home/kde/branches/stable/l10n-kf5/tr/ kde5_tr_stable
# KDE5 trunk şablonlarını klonla
echo "KDE 5 Trunk Şablonları Klonlanıyor..."
svn co -q svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/templates templates_kde5

echo "KDE 5 Lokalize Projesi oluşturuluyor..."
# Proje dosyasını yapılandır
echo "[General]" >> kde5_tr_trunk.lokalize
echo "BranchDir=kde5_tr_stable" >> kde5_tr_trunk.lokalize
echo "LangCode=tr" >> kde5_tr_trunk.lokalize
echo "PoBaseDir=kde5_tr_trunk" >> kde5_tr_trunk.lokalize
echo "PotBaseDir=templates_kde5" >> kde5_tr_trunk.lokalize
echo "ProjectID=KDE Türkçe" >> kde5_tr_trunk.lokalize
echo "TargetLangCode=tr" >> kde5_tr_trunk.lokalize

echo "Çeviride yardımcı olacak lokalize betikleri kopyalanıyor..."


# Lokalize betiklerini kopyala
# https://github.com/maidis/tr-lokalize-scripts
mkdir lokalize-scripts
mv embedded-google-translate.* lokalize-scripts


# Lokalize'yi oluşturulan proje dosyası ile çalıştır
echo "KDE Çeviri Ekibine Hoş Geldiniz! Herhangi bir sorunuzda kde-l10n-tr@kde.org adresine e-posta gönderebilirsiniz."
echo "Kurulum tamamlandı. Bu betiği silebilir ve Lokalize uygulamasını açabilirsiniz... "
read -r -p "Şimdi lokalize açılsın mı? [e]/h " cevap
cevap=${cevap:-e}
case "$cevap" in
    [eE]) 
        echo "Enter'a bastığınızda Lokalize uygulaması otomatik olarak kde5_tr_trunk.lokalize projesini açacak."
        read -r -p "Çeviriye başlamadan önce ilk olarak 'Ayarlar -> Lokalize Uygulamasını Yapılandır -> Kimlik' bölümünden bilgilerinizi girmeyi unutmayın!"
        lokalize --project kde5_tr_trunk.lokalize &> /dev/null &
        ;;
    *)
        echo -e "Lokalize uygulamasını elle başlattıktan sonra bu klasörde oluşturulmuş kde5_tr_trunk.lokalize proje dosyasını açın.\nÇeviriye başlamadan önce ilk olarak 'Ayarlar -> Lokalize Uygulamasını Yapılandır -> Kimlik' bölümünden bilgilerinizi girmeyi unutmayın!"
        ;;
esac

