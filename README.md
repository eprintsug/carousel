# Front page carousel for EPrints
#### Based on Bootstrap Carousel http://getbootstrap.com/examples/carousel/

## Installation

In order to install from https://github.com/eprintsug/carousel/ you must have [gitaar](https://github.com/eprintsug/gitaar) up and running on your EPrints.

* cd to your eprints3 base root
* pull in git-hosted package

    ```
    git submodule add https://github.com/eprintsug/carousel.git lib/epm/carousel 
    cd lib/epm/carousel 
    git checkout origin/bootstrap
    ```
* generate carousel.epmi

    ```
    gitaar/gitaar build_epmi YOUR_ARCHIVE carousel
    ```
* install carousel.epmi

    ```
    tools/epm link_lib carousel
    ```
* enable carousel.epmi

    ```
    tools/epm enable YOUR_ARCHIVE carousel
    ```
* customize your workflow [See next session](#choosing-what-to-display)
* add the new fields to your repository

    ```
    epadmin update YOUR_ARCHIVE
    ```
* add the following to archives/YOUR_ARCHIVE/cfg/lang/en/static/index.xpage:
    
    ```
    <epc:phrase ref="carousel"/>
    ```
* regenerate everything

    ```
    generate_static --prune YOUR_ARCHIVE && generate_abstracts YOUR_ARCHIVE  &&  generate_views YOUR_ARCHIVE && epadmin reload YOUR_ARCHIVE
    ```
* restart your webserver

## Choosing what to display

The carousel displays a random selection of your "featured" records - that is, records where the carousel_featured field is set to TRUE. If the record has a cover image attached (ie. uploaded image with content field set to "Cover Image") that will also be displayed.

If you already have some records which meet this criteria you could do something like this to get up and running quickly:

```
mysql> update eprint set carousel_featured="TRUE" where eprintid in (select eprintid from document where content="coverimage");
```

Otherwise (and for finer tuned control), add the carousel_featured field to your workflow and select records individually - for best results also attach a suitable cover image (minimum size 200x150) to the record.

```
$ vi archives/YOUR_ARCHIVE/cfg/workflows/eprint/default.xml
```
then add, in the document section,

```
<stage name="local">
        ...
        ...
        ...
         <component><field ref="carousel_featured" /></component>
        ...
        ...
```

and finally, in your namedset/content,

```
        ...
        ...
        ...
        carousel
        ...
        ...
```

## Tips

* Carousel uses jquery and bootstrap - if you are already loading one of both of these just override the carousel-js phrase
* To update the carousel content run:

    ```
    bin/generate_static foo
    ```
    If you want the carousel content to change regularly, schedule this command to run as often as desired using cron.
* By default 5 randomly selected "featured" records are shown in the carousel - to show more (or less) override the carousel phrase and change the "<epc:print expr="carousel(5)"/>" line
