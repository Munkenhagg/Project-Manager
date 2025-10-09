DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
BRIGHT_RED='\033[91m'
RESETCOL='\033[0m'
whendone() {
    printf "\n"
    read -p "Enter continue when ready: " con
    if [ "$con" == "continue" ]; then
        return 0
    else
	whendone
    fi
}
while true; do
    clear
    printf "Welcome\n1. Edit <project-name>\n2. Debug <project-name>\n3. Build <project-name>\n4. Run <project-name>\n5. List [search]\n6. Exit\n"
    read -p ": " opt name extracheck
    if [[ ! "$opt" =~ (exit|Exit|6|5|list|List) ]]; then
        if [ -z "$opt" ] || [ -z "$name" ]; then
    	    printf "%b" "\n\n\n\n\n\n\n\n\n\n\n${BRIGHT_RED}You must enter both an option and a name.${RESETCOL}"
            continue
	fi
fi
    case "$opt" in
        edit|1|Edit)
	    touch "$DIR/src/$name"
	    nano "$DIR/src/$name"
	    if [ "$?" == "0" ]; then
		echo "Done."
	    else
		printf "%b" "${BRIGHT_RED}Error!${RESETCOL}"
	    fi
	    sleep 3.5
	    ;;
	debug|2|Debug)
	    ext="${name##*.}"
	    case "$ext" in
    		c|s|asm) compiler="clang" ;;
    		cpp|cxx|cc|c++) compiler="clang++" ;;
    		*) compiler="" ;;
	    esac
	    if [ -f "$DIR/src/$name" ]; then
		if [ -z "$compiler" ]; then
		    printf "%b" "${BRIGHT_RED}Not a known extension!\nOnly C and C++ can be debugged!${RESETCOL}"
		else
		    "$compiler" -g -o "$DIR/tmp/$name.debug" "$DIR/src/$name"
		fi
	    else
		printf "%b" "${BRIGHT_RED}File not found!${RESETCOL}"
	    fi
	    rm -f "$DIR/tmp/$name.debug"
	    whendone
	    ;;
	build|3|Build)
	                ext="${name##*.}"
            case "$ext" in
                c|s|asm) compiler="clang" ;;
                cpp|cxx|cc|c++) compiler="clang++" ;;
                *) compiler="" ;;
            esac
	    build_name="${name%.*}"
            if [ -f "$DIR/src/$name" ]; then
                if [ -z "$compiler" ]; then
                    printf "%b" "${BRIGHT_RED}Not a known extension!${RESETCOL}"
                else
                    "$compiler" -g -o "$DIR/compiled/$build_name" "$DIR/src/$name"
                fi
            else
                printf "%b" "${BRIGHT_RED}File not found!${RESETCOL}"
            fi
	    if [ "$?" == "0" ]; then
		echo "Success!"
	    else
		echo "Error!"
	    fi
	    sleep 3.5
	    ;;
	run|4|Run)
	    if [ -f "$DIR/compiled/$name" ]; then
		"$DIR/compiled/$name"
		echo "Exit code $?"
	    else
		echo "Project not found!"
	    fi
	    sleep 3.5
	    ;;
	list|5|List)
	    echo "Compiled: "
	    ls "$DIR/compiled"
	    echo "Uncompiled: "
	    ls "$DIR/src"
	    whendone
	    ;;
	exit|6|Exit)
	    exit 0
	    ;;
	*)
	    printf "\nBad usage: $opt\n"
	    exit 1
	    ;;
    esac
done
