# Many directories, many files importing
1. Importing directory --> Using Multiprocess (nd)
2. Importing file --> Using MultiThread (nf)
3. If various file size (large range file size) --> Using MultiThread to importing large file (nc)

===> Maximum active processes at time: nd * nf * nc
