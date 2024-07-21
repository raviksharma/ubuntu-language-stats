import sys
import json
import ipdb

language_color={
"C":"#003f5c", "Python":"#2f4b7c","Shell":"#665191","Makefile":"#003f5c","Perl":"#a05195","C++":"#d45087","Roff":"#f95d6a","M4":"#ff7c43","XS":"#ffa600","HTML":"","TeX":"","Meson":"","JavaScript":"","Ruby":"","CMake":"","Assembly":"","Raku":"","Rust":"","Java":"","Go":"","XSLT":"","CSS":"","Tcl":"","Cython":"","PHP":"","Yacc":"","Scheme":"","SWIG":"","RPC":"","OpenEdge ABL":"","Objective-C++":"","Emacs Lisp":"","Common Lisp":"","C#":"","Ada":"","Other":""}

def main() -> None:
    f = open(sys.argv[1], 'r')
    _ = f.readline()

    print('<!DOCTYPE html>\n<html>\n<head>\n\t<link rel="stylesheet" href="chart.css">\n</head>\n<body>\n<div class="chart">')
    try:
        while line := f.readline():
            pkg, languages_s = line.split(':', 1)
            languages = json.loads(languages_s)
            other = 0.0
            print(f'\t<div class="bar">\n\t\t<div class="label">{pkg}</div>')
            for lang, v in dict(sorted(languages.items(), key=lambda item: float(item[1]['percentage']), reverse=True)).items():
                p = v['percentage']
                width = float(p)*10
                if float(p) >= 5.0:
                    print(f'\t\t<div class="section" style="--section-value: {width}px; --section-color: {language_color.get(lang, "black")}" data-value="{lang} ({p})"></div>')
                else:
                    other += float(p)
            if other > 0.0:
                width = float(other)*10
                print(f'\t\t<div class="section" style="--section-value: {width:.2f}px; --section-color: {language_color.get("other", "black")}" data-value="other ({other:.2f})"></div>')
            print('\t</div>')
    except Exception as e:
        ipdb.set_trace()
    print('</div>')
    print('</body>')
    print('</html>')
    return 0


if __name__ == "__main__":
    main()
