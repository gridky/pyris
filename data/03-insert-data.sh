#!/bin/bash

set -e

# You need to install PostGIS
# Suppose the database 'pyris' exists

echo "######################################################"
echo "Use 'shp2pgsql' to insert some data from the shp file"
echo "######################################################"
shp2pgsql -D -W latin1 -I -s 4326 IRIS_GEO_2018_FRTOT.shp geoiris | psql -d pyris


# Historically, all the code uses dcomiris instead of code_iris and depcom instead of insee_com, so let's rename this column
echo "######################################################"
echo "Renaming column"
echo "######################################################"
psql pyris -c "ALTER TABLE geoiris RENAME COLUMN code_iris TO dcomiris;"
psql pyris -c "ALTER TABLE geoiris RENAME COLUMN insee_com TO depcom;"


# don't know why but there are several duplications in the shapefile (same geometries for the same IRIS)
echo "######################################################"
echo "Data cleaning: remove some duplicated rows"
echo "######################################################"
psql pyris -c "DELETE FROM geoiris WHERE gid IN (SELECT gid FROM (SELECT gid,RANK() OVER (PARTITION BY dcomiris ORDER BY gid) FROM geoiris) AS X WHERE X.rank > 1);
"

echo "######################################################"
echo "There are"
psql pyris -c 'SELECT COUNT(1) FROM geoiris;'
