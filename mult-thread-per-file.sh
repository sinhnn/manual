#!/bin/bash
#source ~/usr/srilm-1.7.2/env.sh
# -----------------------------------------------------------------------------
# Checking input arguments
# -----------------------------------------------------------------------------
function usage() {
	echo "Usage: $0 -l letters.lst -i infile -n numb-thread"
	echo "Desc: Multithread ngram-count -write-vocab "
}
while [[ $# -gt 0 ]];
do
	case "$1" in
		--infile | -i)
			inf="$2"; shift 2;;
		--letters | -l)
			letters=$(cat "$2" | tr -d '\n'); shift 2;;
		--numb-proc | -n)
			np=$2; shift 2;;
		--help | -h)
			usage; exit 0 ;;
		* )
			usage; exit 1;;
	esac
done
[[ "${inf}" ]]  || { usage; exit 1; }
[[	-f "${inf}" ]] || { echo "${inf}: No such file"; exit 1; }
bs=$(basename "$inf")

[[ "${letters}" ]]  || { echo "Empty letters";  usage; exit 1; }

[[ ${np} -lt 1 ]]  && { echo "Number process: np < 1";  usage; exit 1; }
# -----------------------------------------------------------------------------
# Vocabulary from file
# -----------------------------------------------------------------------------
numbProcess=${np}
numbLine=$(wc -l "${inf}" | cut -d ' ' -f1)
numbLinePerThread=`expr ${numbLine} / ${numbProcess}` # FIXME: has to be floats
echo ${inf} ${numbProcess} ${numbLinePerThread} ${numbLine}
n=1;
s=1; e=$numbLinePerThread;
while [[ $e -le ${numbLine} ]]; do # FIXME: Cause of numbLinePerThread is int
	# Single process
	sed -n "$s, $e p" "$inf" \
		| ngram-count -text "$inf" -write-vocab "${bs}.vocab.$n"
	# Update range of infile
	s=`expr $s + ${numbLinePerThread}`
	e=`expr $e + ${numbLinePerThread}`
	if [[ $s -ge ${numbLine} ]]; then
		break;
	fi
	if [[ $e -gt ${numbLine} ]]; then
		e=${numbLine}
	fi
	n=`expr $n + 1`
done
wait
echo "Merging temporal files"
egrep --no-filename --ignore-case "^[${letters}\_]*$" "${bs}.vocab."[0-9]* \
   | sed 's/./\L&/g'	> ${bs}.vocab
rm -f "${bs}.vocab."[0-9]*
