impress.haml
============

This is a simple script to create a presentation form a yaml configuration file.
It essentially allows you to prepare each slide, and allow easier experimentation 
with positioning, rotation, scale, etc.

impress.js
-----------

[impress.js](https://github.com/bartaz/impress.js) is an awesome HTML5 presentation library by [bartaz](https://github.com/bartaz).

Why impress.haml
-----------------

Basically because I'm too lazy to do this otherwise.

How To Use It
---------------

* Create a .haml for each individual slide like the [example](https://github.com/azizmb/impress.haml/tree/master/example/slides)
* Create a configuration yaml file like in the [example](https://github.com/azizmb/impress.haml/blob/master/example/slides.yml)
* Generate the presention by running the script:
```
    ruby impress.rb -s example/slides.yml -f example/slides > example/presentation.html
```

