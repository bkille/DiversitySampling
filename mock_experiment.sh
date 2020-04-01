# timing_file = "PATH TO TIMING FILE"
# Echo TIMING > ${timing_file}
# race="PATH TO RACE SAMPLE SAVABLE"
# taus="1,1.7,2.8,4.5,7.7,12.9,21.5,35.9,59.9,100"
# outputs="PATH/TO/OUTPUT1 PATH/TO/OUTPUT2"
#
# Iterate through directories
# For each directory
  # cd directory
    # mkdir temp
    # for f in *.gz; do
      # STEM=$(basename "${f}" .gz)
      # gunzip -c "${f}" > /temp/"${STEM}"
    # done
    # cd temp
    # for f1 in *_1_reads.fq; do
      # f2=${f:0:10}_21_reads.fq
      # (time ${race} ${taus} PE experimentsavefile.bin f1 f2 outputs --range 500000 --k 15) >> ${timing file}
    # exit temp
    # rm temp
  # Exit directory
timing_file="/home/bg31/firstRaceProject/DiversitySampling/results/experiment_timing.txt"
directorypath="/home/bg31/firstRaceProject/DiversitySampling/part_"
race="/home/bg31/firstRaceProject/DiversitySampling/bin/sampleracesavable"
taus="1,1.7,2.8,4.5,7.7,12.9,21.5,35.9,59.9,100"
outputs="/home/bg31/firstRaceProject/DiversitySampling/results/experiment_sample_1 /home/bg31/firstRaceProject/DiversitySampling/results/experiment_sample_2"

for dir in 0; do
  echo working on part ${dir}
  cd ${directorypath}${dir}
  mkdir temp
  for f in *.gz; do
    STEM=$(basename "${f}" .gz)
    gunzip -c "${f}" > /temp/"${STEM}"
  done
  cd temp
  for f1 in *_1_reads.fq; do
    f2=${f:0:10}_2_reads.fq
    path="${directorypath}${dir}/"
    mytime="$(time ${race} ${taus} PE experimentsavefile.bin ${path}${f1} ${path}${f2} ${outputs} --range 10 --k 15)"
    echo ${mytime}
    ${mytime} >> ${timing file}
  done
  cd ..
  rm -r temp
done