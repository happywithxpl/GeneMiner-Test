1.reads-depth.list
It is used to resample transcriptome data from Arabidopsis thaliana. The first column is the number of resampled reads, and the second is the corresponding depth.

Additional information: 
(1) Arabidopsis CDS region consists of approximately 43.5M bases
(2) read length is 150bp

2. depth.list
A depth list of resampled data. Used to explore the effect of sequencing depth on GeneMiner assembly

3. ref_var

4. var.list
Reference sequence variability list. Used to explore the effect of the reference variability on GeneMiner assembly

5. limit.list
A list of limit_count values. Used to explore the effect of the sequencing error exclusion on GeneMiner assembly


6. Modify the source code of “my_assemble.py” for the “get_weight” function

#Use the weighted model
def get_weight(_count, current_pos, average_pos, _dis=0):
    if average_pos and current_pos:
        dis = (1 - abs(current_pos - average_pos))
    else:
        dis = _dis
    weight = _count * math.exp(dis)
    return weight
#Do not use the weighted model
def get_weight(_count, _pos, average_pos, _dis=0.5):
    weight = 1
    return weight


7. Use “-bn” in bootstrap verification



8. work.sh
Commands for recording GeneMiner’s specific feature Studies.

Note1: you should install GeneMiner, seqtk (https://github.com/lh3/seqtk)
Note2: The source code needs to be modified when comparing the difference between using the weighting model and not using the weighting model.

