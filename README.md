# Front page carousel for EPrints based on http://kenwheeler.github.io/slick/

## Adding the carousel

To add a carousel to your front page add the following to archives/foo/cfg/lang/en/static/index.xpage:

````
<epc:phrase ref="carousel"/>
````

## Choosing what to display

To get up and running quickly you could do something like:

```
mysql> update eprint set carousel_featured="TRUE" where eprintid in (select eprintid from document order by rand() limit 10);
```

For finer tuned control, add the carousel_featured field to your workflow and select records individually.
