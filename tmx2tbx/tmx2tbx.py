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

# How to use?
#
# 1) Download a TMX file.
# E.g. LibreOffice Terminology for Turkish:
# https://translations.documentfoundation.org/++offline_tm/tr/terminology/
# If link does not work, use the page to download the TMX:
# https://translations.documentfoundation.org/tr/terminology/ (then double 
# arrow and Download offline TM)

# 2) Adjust the following parameters:
origLang = "en-US" # Original language of the terminology
targetLang = "tr" # The target language
tmxfile = "terminology.tmx" # Downloaded file name

# 3) Run the script:
# python tmx2tbx.py

# 4) Copy the terms.tbx into Lokalize project folder, where *.lokalize exists


# Following configured for Lokalize
term = "<seg>"
saveAs = "terms.tbx"
index = 0

with open(tmxfile, "r") as f:
    searchfor = f.readlines()


with open(saveAs, 'w') as terms:
    terms.write('<?xml version=\'1.0\' encoding=\'UTF-8\'?>' + '\n')
    terms.write('<!DOCTYPE martif PUBLIC \'ISO 12200:1999A//DTD MARTIF core (DXFcdV04)//EN\' \'TBXcdv04.dtd\'>' + '\n')
    terms.write('<martif xml:lang="en_US" type="TBX">' + '\n')
    terms.write(' <text>' + '\n')
    terms.write('  <body>' + '\n')
    for i, line in enumerate(searchfor):
        if term in line:
            if index % 2:
                activeLang = targetLang
            else:
                activeLang = origLang
                terms.write('   <termEntry id="' + str(index) + '">' + '\n')
            wordBeg = line.find('>') + 1
            wordEnd = line.find('<', wordBeg + 1)
            terms.write('     <langSet xml:lang="' + activeLang + '">' + '\n')
            terms.write('       <tig>' + '\n')
            terms.write('         <term>' + line[wordBeg:wordEnd] + '</term>' + '\n')
            terms.write('       </tig>' + '\n')
            terms.write('     </langSet>' + '\n')
            index = index + 1
            if activeLang == targetLang:
                terms.write('   </termEntry>' + '\n')
    terms.write('  </body>' + '\n')
    terms.write(' </text>' + '\n')
    terms.write('</martif>' + '\n')
