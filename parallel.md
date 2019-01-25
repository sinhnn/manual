# Tools for parallel computing/text processing in Linux

## Xargs
```bash
#xargs -P ${numbJob} -n ${numbArgsAtOnce} ...
find . -name -type d | xargs -I {} -n 1 -P 2 bash -c 'echo $*' -- {}

# Working with list of commands in file
cat commands.txt | tr '\n' '\0' | xargs -0 -I {} bash -c '$*' -- {}
```

## [Parallel](https://www.gnu.org/software/parallel/parallel_tutorial.html)


```bash
# parallel -j ${numbJob} -k -n ${numbArgsAtOnce} .... "cmd" ::: $listInPut
parallel -j 2 -k -n 2 echo ::: A B C
cat ex.txt | parallel echo 

# {},{1},{2} Argument placeholder
find . -name '*.jpg' | parallel convert -resize 512x384 {} {}_web.jpg

# Working with list of commands in a file
parallel --jobs 2 < commands.txt

```
[Guide with example](https://www.gnu.org/software/parallel/man.html)
[Argument placeholders](https://www.biostars.org/p/63816/)
[Argument placeholders](https://www.biostars.org/p/182136/)
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

