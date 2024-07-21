import sys
import json
import ipdb

recognised_langs=["C","Python","Shell","Makefile","Perl","C++","Roff","M4","XS","HTML","TeX","Meson","JavaScript","Ruby","CMake","Assembly","Raku","Rust","Java","Go","XSLT","CSS","Tcl","Cython","PHP","Yacc","Scheme","SWIG","RPC","OpenEdge ABL","Objective-C++","Emacs Lisp","Common Lisp","C#","Ada","Other"]

def main() -> None:
    f = open(sys.argv[1], 'r')
    _ = f.readline()

    #out = open('bars.html', 'w')
    print('<!DOCTYPE html>\n<html>\n<head>\n<link rel="stylesheet" href="chart.css">\n</head>\n<body>\n<div class="chart">\n')
    #print('name,'+','.join(recognised_langs))
    try:
        while line := f.readline():
            pkg, languages_s = line.split(':', 1)
            languages = json.loads(languages_s)
            other = 0.0
            print(f'<div class="bar">\n<div class="label">{pkg}</div>\n')
            for lang, v in languages.items():
                p = v['percentage']
                if float(p) >= 5.0:
                    print(f'<div class="section" style="--section-value: {p};" data-value="{lang} ({p})"></div>\n')
                    #print(pkg+','+lang+','+p)
                else:
                    other += float(p)
            if other > 0.0:
                print(f'<div class="section" style="--section-value: {p};" data-value="other ({other})"></div>\n')
            #print(pkg+',other,'+"{:.2f}".format(other))
            print('</div>\n')
    except Exception as e:
        ipdb.set_trace()
    #out.write('</div>\n</body>\n</html>')
    #out.close()
    return 0


if __name__ == "__main__":
    main()
