#!/bin/bash
brew install aria2
aria2c -x 8 https://storage.googleapis.com/puga-reference/homo_sapiens_merged_110_GRCh37.zip
unzip homo_sapiens_merged_110_GRCh37.zip