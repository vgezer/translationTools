# -*- coding: utf-8 -*-
import os,sys
import time
import Lokalize
import Project
import Editor
import urllib2

def translate(to_translate, to_langage="tr", langage="en"):
    '''Return the translation using google translate
    you must shortcut the langage you define (French = fr, English = en, Spanish = es, etc...)
    if you don't define anything it will detect it or use english by default
    Example:
    print(translate("salut tu vas bien?", "en"))
    hello you alright?'''
    agents = {'User-Agent':"Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.04506.30)"}
    before_trans = 'class="t0">'
    link = "http://translate.google.com/m?hl=%s&sl=%s&q=%s" % (to_langage, langage, to_translate.replace(" ", "+"))
    request = urllib2.Request(link, headers=agents)
    page = urllib2.urlopen(request).read()
    result = page[page.find(before_trans)+len(before_trans):]
    result = result.split("<")[0]
    # return result
    if not result: return

# if __name__ == '__main__':
#     to_translate = 'Hello, how are you?'
#     print("%s >> %s" % (to_translate, translate(to_translate)))
#     print("%s >> %s" % (to_translate, translate(to_translate, 'fr')))
#     #should print Hola como estas >> Hello how are you
#     #and Hola como estas? >> Bonjour comment allez-vous?

    Editor.setEntryTarget(Editor.currentEntry(),0,result)


word = Editor.currentEntryId().split('\n', 1)[-1]

to_translate = word

translate(to_translate)
