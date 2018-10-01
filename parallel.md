# Tools for parallel computing/text processing in Linux

## Xargs
```bash
#xargs -P ${numbJob} -n ${numbArgsAtOnce} ...
find . -name -type d | xargs -I {} -n 1 -P 2 bash -c 'echo $*' -- {}
```

## [Parallel](https://www.gnu.org/software/parallel/parallel_tutorial.html)
```bash
# parallel -j ${numbJob} -k -n ${numbArgsAtOnce} .... "cmd" ::: $listInPut
parallel -j 2 -k -n 2 echo ::: A B C
cat ex.txt | parallel echo 
```
## Manual
```bash
# Step 1: Split files by split or sed or csplit
split [-a|suffix-length=N] [-l|--lines=numberLinePerOutput] [-b|--bytes=bytesPerFile] ...
sed "$startLine $endLine p"
# Step 2: Run each splitted files in background
yourCmd &
# Step 3: Wait for finishing background processes
wait
# Step 4: Merge output parts
cat $outputParts > $output
```
### Example
```bash
numbLine=$(wc -l "${infile}" | cut -d ' ' -f1)
numbLinePerJob=`expr ${numbLine}  /${numbJob}`
```

