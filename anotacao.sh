#!/bin/bash
brew install aria2
aria2c -x 8 https://storage.googleapis.com/puga-reference/homo_sapiens_merged_110_GRCh37.zip
unzip homo_sapiens_merged_110_GRCh37.zip
aria2c -x 5 https://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/hg38.fa.gz
gunzip hg38.fa.gz
mv hg38.fa homo_sapiens_merged
chmod 777 /data
chmod 777 /data/homo_sapiens_merged/
chmod 777 /data/vep_output/
docker pull ensemblorg/ensembl-vep
# executa o VEP por meio de docker
docker run -it --rm  -v $(pwd):/data ensemblorg/ensembl-vep vep \
-i /data/WP312.filtered.vcf.gz \
-o /data/vep_output/WP312.filtered.vep.tsv \
--assembly GRCh37  \
--merged -pick \
--pick_allele \
--force_overwrite \
--tab --symbol --distance 0 \
--fields "Location,SYMBOL,Consequence,Feature,Amino_acids,CLIN_SIG" \
--individual all \
--dir_cache /data \
--cache --offline \
--variant_class \
--fork 10 \
--fasta /data/homo_sapiens_merged/hg38.fa
##
docker run -it --rm  -v $(pwd):/data ensemblorg/ensembl-vep vep \
-i /data/WP312.filtered.vcf.gz \
-o /data/vep_output/WP312.filtered.vep.tsv \
--assembly GRCh37  \
--merged --pick \
--pick_allele \
--force_overwrite \
--tab \
--distance 0 \
--everything \
--individual all \
--dir_cache /data/ \
--cache --offline \
--fork 16 \
--buffer_size 1000 \
--fasta /data/homo_sapiens_merged/hg38.fa
