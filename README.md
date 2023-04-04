# OpenStreetData

Country data dumps from OpenStreetMaps in GeoJson format

### Remarks regarding area handling

"Closed Ways" can be interpreted as both a "way" or an "area" depending on what it represents.
By default, the *osmium-tool* will export closed ways as both `LineString` and `MultiPolygon`.
This would cause a lot of duplication of course since for example every house will be present twice in the resulting dataset.

Therefore, some heuristic is applied. The upside is no duplicates, the downside is that some closed ways might be lost if it does not fit any of the categories defined in **

- https://github.com/osmcode/osmium-tool/issues/264
https://taginfo.openstreetmap.org/keys