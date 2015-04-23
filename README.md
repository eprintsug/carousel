# Front page carousel for EPrints based on Bootstrap Carousel http://getbootstrap.com/examples/carousel/

## Getting started

To add a carousel to your front page add the following to archives/foo/cfg/lang/en/static/index.xpage:

````
<epc:phrase ref="carousel"/>
````

### Choosing what to display

The carousel displays a random selection of your "featured" records - that is, records where the carousel_featured field is set to TRUE. If the record has a cover image attached (ie. uploaded image with content field set to "Cover Image") that will also be displayed.

If you already have some records which meet this criteria you could do something like this to get up and running quickly:

```
mysql> update eprint set carousel_featured="TRUE" where eprintid in (select eprintid from document where content="coverimage");
```

Otherwise (and for finer tuned control), add the carousel_featured field to your workflow and select records individually - for best results also attach a suitable cover image (minimum size 200x150) to the record.

### Keeping things fresh

To update the carousel content run:

````
bin/generate_static foo
````

If you want the carousel content to change regularly, schedule this command to run as often as desired using cron.

## Tips

* Carousel uses jquery and bootstrap - if you are already loading one of both of these just override the carousel-js phrase
* By default 5 randomly selected "featured" records are shown in the carousel - to show more (or less) override the carousel phrase and change the "<epc:print expr="carousel(5)"/>" line
