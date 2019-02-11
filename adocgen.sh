#!/bin/bash

# start the nginx daemon
nginx

inotifywait -m source -r -e create -e modify -e delete -e moved_to -e moved_from |
    while read path action file; do
        dpath=${path/source/build}
        dfile=${file/.adoc/.html}

        # echo "action=$action, path=$path, file=$file, dpath=$dpath, dfile=$dfile"

        case $action in
            DELETE|MOVED_FROM|DELETE,ISDIR|MOVED_FROM,ISDIR) rm -fr "$dpath/$dfile";;
            CREATE,ISDIR|MOVED_TO,ISDIR) mkdir -p "$dpath/$dfile";;
            MODIFY|MOVE_TO)
                ext="${file#*.}"

                if [[ $ext == "adoc" ]]; then
                    asciidoctor -r asciidoctor-diagram -D $dpath $path/$file
                else
                    cp "$path/$file" "$dpath/$dfile"
                fi
            ;;
        esac
    done
