identify_chimeric_seqs.py -m usearch61 -i 16S/readyForQiime.allsamples.fasta -r 16S/gg_13_8_97_otus.fasta -o 16S/usearch61_chimera_checking
filter_fasta.py -f 16S/readyForQiime.allsamples.fasta -o 16S/readyForQiime.allsamples.nochimeras.fasta -s 16S/usearch61_chimera_checking/non_chimeras.txt
pick_otus.py -i 16S/readyForQiime.allsamples.nochimeras.fasta -o 16S/picked_otus_97 -z
pick_rep_set.py -i 16S/picked_otus_97/readyForQiime.allsamples.nochimeras_otus.txt -f 16S/readyForQiime.allsamples.nochimeras.fasta -o 16S/bioaerosol.16S.repset.fasta -m most_abundant
assign_taxonomy.py -i 16S/bioaerosol.16S.repset.fasta -o 16S/assigned_taxonomy -t 16S/gg_13_8_97_otu_taxonomy.txt -r 16S/gg_13_8_97_otus.fasta -m blast -e 0.001
make_otu_table.py -i 16S/picked_otus_97/readyForQiime.allsamples.nochimeras_otus.txt -t 16S/assigned_taxonomy/bioaerosol.16S.repset_tax_assignments.txt -o 16S/bioaerosol.16S.biom
echo "summarize_taxa:level 7" > 16S/parameters.txt
summarize_taxa_through_plots.py -i 16S/bioaerosol.16S.biom -o 16S/visualised_taxonomy -m 16S/mappingfile.txt -s -p 16S/parameters.txt