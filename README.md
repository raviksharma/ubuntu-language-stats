# ubuntu-language-stats

## download packages
```shell
# copy mirror.list to /etc/apt/mirror.list
$ sudo apt-mirror
```

## extract languages
```shell
# save analysis to file
$ ./run.sh |tee output.txt

# transform to csv
$ python3 csv.py output.txt
```

## analysis

```shell
# package count
$ wc -l output.txt

# packages without language
$ grep -c -F ': {}' output.txt
```

### load data in sqlite3

```sql
# load csv into sqlite
> create table output(package TEXT, lang TEXT, percentage NUMERIC);
> .import output.csv output --csv

# packge count with languages
> select count(distinct package) from output;

# show language with max percentage in package
> select package, lang, max(percentage) from output group by package

# show C packages count
> select count(*) from (select package, lang, max(percentage) from output group by package) where lang='C';

# show top language frequency
> select lang, count(*) as c from (select package, lang, max(percentage) from output group by package) group by lang order by c desc;

# show packages with Rust code
> select package from output where lang='Rust';

# most popular lang overall
> select lang, count(*) as c from output group by lang order by c desc;
```