#!/bin/bash
#
# download_test_data.sh
#
# Download test data not included in repo
#
# Copyright (C) 2022 Matthew Stone <matthew.stone@modulustherapeutics.com>
# Distributed under terms of the MIT license.

cd test_data/
wget https://ndownloader.figshare.com/files/20274744 && mv 20274744 sample_info.csv
wget https://ndownloader.figshare.com/files/20234073 && mv 20234073 Achilles_gene_effect.csv
wget http://download.baderlab.org/EM_Genesets/January_01_2022/Human/symbol/Human_AllPathways_January_01_2022_symbol.gmt
