###1.resample
mkdir data
less reads-depth.list |while read a b;do echo "seqtk sample -s 100 SRR18391637.fastq ${a} > data/${b}x.fq " >>resample.sh;done
ParaFly -c resample.sh -CPU 4



###2.depth
#Prepare the commands 
mkdir depth
less depth.list |while read a ;do echo "geneminer.py -s data/${a}x.fq -rtfa ref_Brassicaceae_353/ -t 4 -o depth/${a}x" >>run_depth.sh;done
#run
ParaFly -c run_depth.sh -CPU 4

###3.var
#Prepare the commands
mkdir var
less var.list |while read a;do echo "geneminer.py -s data/50x.fq -rtfa ref_var/Arabidopsis_thaliana_${a} -t 4 -o var/var_${a} ">>run_var.sh  ;done
#run
ParaFly -c run_var.sh -CPU 4



###4.limit
#Prepare the commands
mkdir limit
for i in $(cat depth.list);do for j in $(cat limit.list);do echo "geneminer.py -s data/${i}x.fq -rtfa ref_Brassicaceae_353/ -t 4 -limit_count ${j} -o limit/${i}x-l${j}" >>run_limit.sh;done;done
#run
ParaFly -c run_limit.sh -CPU 4


###5.weighted model
#Prepare the commands
mkdir weighted_model_free
less depth.list |while read a ;do echo "geneminer.py -s data/${a}x.fq -rtfa ref_Brassicaceae_353/ -t 4 -o weighted_model_free/${a}x" >>run_depth.sh;done
#run
ParaFly -c run_depth.sh -CPU 4



###6.bootstrap
#Prepare the commands
mkdir bootstrap
less var.list |while read a;do echo "geneminer.py -s data/50x.fq -rtfa ref_var/Arabidopsis_thaliana_${a} -t 4 -o bootstrap/bootstrap_${a} -bn 50 ">>run_bootstrap.sh ;done
#run
ParaFly -c run_bootstrap.sh -CPU 4