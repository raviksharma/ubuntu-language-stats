import sys
import json


def main() -> None:
    f = open(sys.argv[1], 'r')
    _ = f.readline()  # discard metadata

    while line := f.readline():
        pkg, languages_s = line.split(':', 1)
        languages = json.loads(languages_s)
        for lang, v in languages.items():
            print(pkg+','+lang+','+v['percentage'])
    return 0


if __name__ == "__main__":
    main()
