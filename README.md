# Front page carousel for EPrints based on http://kenwheeler.github.io/slick/

## Getting started

To add a carousel to your front page add the following to archives/foo/cfg/lang/en/static/index.xpage:

````
<epc:phrase ref="carousel"/>
````

### Choosing what to display

By default, the carousel displays a small (random) selection of your most recently deposited records.

You can override the defaults so that the carousel displays, for example, a random selection of your "featured" records (that is, records where the carousel_featured field is set to TRUE) or even a random selection from your entire repository. See lib/cfg,d/carousel.pl for examples.

If the record has a cover image attached (ie. uploaded image with content field set to "Cover Image") that will also be displayed.

### Keeping things fresh

To update the carousel content run:

````
bin/generate_static foo
````

If you want the carousel content to change regularly, schedule this command to run as often as desired using cron.

## Tips

* Carousel uses jquery and slick - if you are already loading one of both of these just override the carousel-js phrase
* The slick library has many additional settings - see http://kenwheeler.github.io/slick/#settings - if you want to adjust the defaults just override the carousel-init phrase
