#!/bin/bash
#
# test_nextflow_awsbatch.sh
#
# Test pipeline on AWS Batch
#
# Copyright (C) 2022 Matthew Stone <matthew.stone@modulustherapeutics.com>
# Distributed under terms of the MIT license.

nextflow run main.nf \
    -c nextflow.config \
    -profile aws \
    -bucket-dir s3://modulus-users/mstone/nextflow-crispr-screen-batch-demo \
    -w work/ \
    -with-docker ubuntu:latest \
    --treatment_fastq test_data/test1.fastq.gz,test_data/test3.fastq.gz \
    --control_fastq test_data/test2.fastq.gz \
    --library test_data/library.csv \
    --output output \
    --output_prefix OUTPUT \
    --organism hsa \
    --scale_cutoff 1 \
    --gmt test_data/Human_AllPathways_January_01_2022_symbol.gmt \
    --depmap_effect test_data/Achilles_gene_effect.csv \
    --depmap_samples test_data/sample_info.csv \
    --trim_5_prime 0 \
    --trim_3_prime 0
