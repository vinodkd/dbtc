# dont break the chain display

# find all git repos under a dir ($1)
# for each such repo, find commits by userid $2 in the given range ($3 to $4).
# for each such commit, print out the repo name, day, month, year, dateOfYear, wkOfYear

rootDir=$1
userID=$2
from=$3
to=$4

outputDir=`pwd`
outputFile="${outputDir}/dbtc_${userID}_${from//-/_}_${to//-/_}.csv"
echo "Output File: $outputFile"

if [[ -ne $outputFile ]]; then
	touch $outputFile
fi

echo "repo,commitYear,commitMonth,commitDay,commitDOY,commitWOY" > $outputFile

for subd in $(find $rootDir -type d -depth 1); do
	cd $subd
	echo -n "Processing $subd:"
	# use output of git status to check if this dir is a repo.
	git status &> /dev/null
	if [[ $? -eq 0 ]]; then
		repo=$(echo  $subd | cut -d/ -f2)

		IFS=$'\r\n' commits=($(git log --branches --remotes --tags --since=$from --until=$to --author=$userID --date=short --pretty="%ad"|uniq))
		for c in ${commits[@]}; do
			cyr=$(echo $c | cut -d"-" -f1)
			cmth=$(echo $c | cut -d"-" -f2)
			cdt=$(echo $c | cut -d"-" -f3)
			cdoy=$(date -jf "%Y-%m-%d" $c +%j )
			# go with simplistic version for now, but see http://stackoverflow.com/a/3237884 for problems with this.
			cwoy=$(date -jf "%Y-%m-%d" $c +%W )
			echo "$repo,$cyr,$cmth,$cdt,$cdoy,$cwoy" >> $outputFile
		done
		echo "DONE"
	else
		echo "SKIPPED"
	fi
done
