OpenStreetData
==============

Country data dumps from OpenStreetMaps in GeoJson format

Remarks
-------

### Performance

This is not a script you simply download on your laptop and run. It requires lots of RAM, CPU, disk and *time* to run.

With such huge data, performance is a core concern. Everything must be tuned to not be wasteful.


### Countries

Sometimes, it is not even clear if an area is an independent country or not.
Take Kosovo for example. Half of the world consider it to be a sovereign country, the other half consider it to be a part of Serbia. See https://en.wikipedia.org/wiki/International_recognition_of_Kosovo for more details.


### Addresses are crazy

For example, here is an enclave of Belgium in the Netherlands. 
It's a single city called Baarle divided into two countries like a jigsaw puzzle.

![img](http://newsimg.bbc.co.uk/media/images/45720000/gif/_45720211_neth_belg_nass_466.gif)


Or here, that's a real house number in Vietnam:

![img](https://qph.cf2.quoracdn.net/main-qimg-28c36359aa26de2b8c2d68a1b52de29d-pjlq)

Or here, houses in Mannheim center do not belong to streets (which are *unnamed*) but to "blocks:

![img](https://upload.wikimedia.org/wikipedia/commons/2/2d/Mannheim_Quadratstadt_beschriftet.png)

There are cases where it's not clear where the actual border is, because of conflicts or disputed territory.

Sometimes, it's not even clear if it's an independent country or not. For example, half of the world considers Kosovo to be an independent country, while the other half to be part of Serbia.

![img](https://upload.wikimedia.org/wikipedia/commons/thumb/2/23/Kosovo_relations.svg/600px-Kosovo_relations.svg.png)

Postal codes are also crazy. So countries use them, others don't. Some are numeric, others not. Some are aligned with administrative borders, others don't. Streets might belong to different postal codes on different sides or segments...

*If one thing is sure, it's that addresses are extremely diverse and full of unexpected things.*


### Remarks regarding area handling

"Closed Ways" can be interpreted as both a "way" or an "area" depending on what it represents.
By default, the *osmium-tool* will export closed ways as both `LineString` and `MultiPolygon`.
This would cause a lot of duplication of course since for example every house will be present twice in the resulting dataset.

Therefore, some heuristic is applied. The upside is no duplicates, the downside is that some closed ways might be lost if it does not fit any of the categories defined in **

- https://github.com/osmcode/osmium-tool/issues/264
https://taginfo.openstreetmap.org/keys






### Building extracts

> At the beginning, we used the extracts from GeoFabrik. However, they were not accurate enough for us.
GeoFabrik provides "simplified country polygons". This is good for avarage usage, but in our case it caused issues for address extraction.
In areas close to the country borders, addresses would belong to the neighbor country or worse, be missing.
In order to extract addresses precisely, country extracts that perfectly match the country boundaries are necessary and is the reason why they are extracted here.


The process of building country extracts is also a two step procedure.
First, the planet is devided into (sub-)regions, then each one is further split into countries.
The reason to do so is a balancing between performance and memory consumption.
Extracting all countries at once consumes too much RAM while extracting countries one after another takes too long. With such huge data, how you handle it is critical. 


1. Fetch the whole OSM planet per torrent
2. Extract all country borders
3. Build `extracts/{COUNTRY_CODE}-borders.geojson` for each country which contains its border polygon
4. Build `temp/{CONTINENT}-borders.geojson` for each continent by bundling some countries
5. Extract the continents
6. Extract the countries from continents