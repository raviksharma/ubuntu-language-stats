# ubuntu-language-stats

## download packages
$ sudo apt-mirror

## extract and analyse source 
$ ./run.sh |tee output.txt

## transform to csv
$ python3 csv.py output.txt

# analysis

## package count
$ wc -l output.txt

## packages without language
$ grep -c -F ': {}' output.txt

## sql 
$ sqlite3

### load csv into sqlite
> .import output.csv output --csv

### packge count with languages
> select count(distinct package) from output;