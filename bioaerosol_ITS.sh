identify_chimeric_seqs.py -m usearch61 -i ITS/readyForQiime.allsamples.fasta -r ITS/uchime_sh_refs_dynamic_develop_985_01.01.2016.ITS1.fasta -o ITS/usearch61_chimera_checking
filter_fasta.py -f ITS/readyForQiime.allsamples.fasta -o ITS/readyForQiime.allsamples.nochimeras.fasta -s ITS/usearch61_chimera_checking/non_chimeras.txt
pick_otus.py -i ITS/readyForQiime.allsamples.nochimeras.fasta -o ITS/picked_otus_97 -z
pick_rep_set.py -i ITS/picked_otus_97/readyForQiime.allsamples.nochimeras_otus.txt -f ITS/readyForQiime.allsamples.nochimeras.fasta -o ITS/bioaerosol.ITS.repset.fasta -m most_abundant
assign_taxonomy.py -i ITS/bioaerosol.ITS.repset.fasta -o ITS/assigned_taxonomy -t ITS/sh_taxonomy_qiime_ver7_dynamic_31.01.2016.txt -r ITS/sh_refs_qiime_ver7_dynamic_31.01.2016.fasta -m blast -e 0.001
make_otu_table.py -i ITS/picked_otus_97/readyForQiime.allsamples.nochimeras_otus.txt -t ITS/assigned_taxonomy/bioaerosol.ITS.repset_tax_assignments.txt -o ITS/bioaerosol.ITS.biom
echo "summarize_taxa:level 7" > ITS/parameters.txt
summarize_taxa_through_plots.py -i ITS/bioaerosol.ITS.biom -o ITS/visualised_taxonomy -m ITS/mappingfile.txt -s -p ITS/parameters.txt