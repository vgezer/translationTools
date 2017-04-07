# TMX to TBX converter       

## A simple Python Script to convert TMX file into TBX to be used in Lokalize


_terminology.tmx_ is retrieved from https://translations.documentfoundation.org/tr/terminology/

Direct link: https://translations.documentfoundation.org/++offline_tm/tr/terminology/

* Check the _origLang_, _targetLang_, and _tmxfile_ param values and change if necessary.

~~~
origLang = "en-US" # Original language of the terminology
targetLang = "tr" # The target language
tmxfile = "terminology.tmx" # Downloaded file name
~~~

* Run the script using _python_ interpreter:

~~~
python tmx2tbx.py
~~~

* Copy the generated _terms.tbx_ into Lokalize's project folder.
This folder is where *.lokalize file exists.
