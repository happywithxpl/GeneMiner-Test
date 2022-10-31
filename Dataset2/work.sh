###1.Run GeneMiner

cat species.list |while read a;do echo "geneminer.py  -1 ${a}_1.fq.gz -2 ${a}_2.fq.gz -rtfa shallow_ref/ -t 4 -o geneminer_out_${a} " >> run_geneminer.sh;done
bash run_geneminer.sh





###2.Run HybPiper

cat species.list |while read a; do echo "hybpiper assemble -r ${a}_1.fq.gz ${a}_2.fq.gz -t_dna shallow_ref_hybpiper.fasta   --prefix ${a} --bwa --cpu 4 " >>run_hybpiper_v2.0.sh;done    
bash run_hybpiper_v2.0.sh





###3.Run NOVOPlasty


#(1) Prepare the output folder
for i in $(cat species.list); do for j in $(cat gene.list); do mkdir -p novoplasty_out/${i}_${j};done;done

#(2) Prepare the config.txt
mkdir novoplasty_config
for i in $(cat species.list); do for j in $(cat gene.list);do  if [ $j == "ITS" ];then sed -e "s/xxxx/${i}/g" -e "s/zzzz/${j}/g" -e "s/xxstart/500/g" -e "s/xxend/1000/g" config.txt > novoplasty_config/${i}_${j}.txt ;elif [ $j == "matK" ];then sed -e "s/xxxx/${i}/g" -e "s/zzzz/${j}/g" -e "s/xxstart/1000/g" -e "s/xxend/2500/g" config.txt > novoplasty_config/${i}_${j}.txt;elif [ $j == "psbA" ];then sed -e "s/xxxx/${i}/g" -e "s/zzzz/${j}/g" -e "s/xxstart/1000/g" -e "s/xxend/2500/g" config.txt > novoplasty_config/${i}_${j}.txt;elif [ $j == "rbcL" ];then sed -e "s/xxxx/${i}/g" -e "s/zzzz/${j}/g" -e "s/xxstart/1000/g" -e "s/xxend/2500/g" config.txt > novoplasty_config/${i}_${j}.txt;
else :;fi;done;done

#(3) run
for i in $(cat species.list); do for j in $(cat gene.list); do echo "NOVOPlasty4.3.1.pl -c novoplasty_config/${i}_${j}.txt" >>run_novoplasty.sh;done;done
bash run_novoplasty.sh