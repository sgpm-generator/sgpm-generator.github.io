# http://www.sno.phy.queensu.ca/~phil/exiftool/exiftool_pod.html#input_output_text_formatting
# http://www.sno.phy.queensu.ca/~phil/exiftool/TagNames/IPTC.html

exiftool -Filename -'Writer-Editor' -'By-line' -Headline -Credit -Source -ImageDescription -CopyrightNotice -Keywords -CreateDate -progress -json . > sgpm-extended.json