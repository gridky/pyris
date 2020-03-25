#!/bin/bash

#Usage : Go to the data directory and then: ./01-download-data.sh

wget https://static.data.gouv.fr/resources/contour-des-iris-insee-tout-en-un/20200306-111351/iris-geo-2018-frtot.zip
# "stable"(?) link : https://www.data.gouv.fr/fr/datasets/r/a1ce4923-4128-4334-8117-3df7f6b73ba4
# see https://www.data.gouv.fr/fr/datasets/contour-des-iris-insee-tout-en-un/
unzip iris-geo-2018-frtot.zip
