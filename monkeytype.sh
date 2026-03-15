
#!/bin/bash

generate_target() {
    local word_count=$1
    local min=$2
    local max=$3

    grep -E "^[a-z]{$min,$max}$" /usr/share/dict/words | sort -R | head -n "$word_count" | xargs
}


#color variables
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[33m'
blue='\033[0;34m'
nc='\033[0m' # no colour
nc_bold='\033[1m'
green_bold='\033[1;32m'

easy="success is not final, failure is not fatal: it is the courage to continue that counts."

while true; do
    clear
    echo "select your difficulty"
    echo "1) easy (10 words)"
    echo "2) medium (25 words)"
    echo "3) hard (40 words)"
    echo "choose (1, 2, or 3): "
    read choice

    if [[ "$choice" == "1" ]]; then
        target=$(generate_target 10 2 6)
    elif [[ "$choice" == "2" ]]; then
        target=$(generate_target 25 4 8)
    elif [[ "$choice" == "3" ]]; then
        target=$(generate_target 40 6 12)
    else
        target=$easy
    fi

    typing_test="TYPING TEST"

    clear
    echo ""
    echo -e "${nc_bold}${typing_test}${nc}"
    echo ""
    echo -e "${red}${target}${nc}"
    echo ""
    echo "press ENTER, then immediately start typing!"
    read 
    
    start_time=$(date +%s)
    echo -n "> "
    read user_input
    end_time=$(date +%s)

    # computing
    timetaken=$(( end_time - start_time ))
    if [ $timetaken -lt 1 ]; then timetaken=1; fi

    chars=${#user_input}
    wpm=$(( (chars * 60) / (timetaken * 5) ))
    # 5 chars per word is the standard for wpm calculations

    matches=0
    target_len=${#target}
    user_len=${#user_input}
    

    for (( i=0; i<$target_len && i<$user_len; i++ )); do
        if [[ "${target:$i:1}" == "${user_input:$i:1}" ]]; then
            ((matches++))
        fi
    done
    
    accuracy=$(( (matches * 100) / target_len ))

    echo ""

    echo -e "${green_bold}final stats${nc}"
    echo -e "${green}time taken: $timetaken seconds${nc}"
    echo -e "${green}your speed: $wpm wpm${nc}"
    echo -e "${green}accuracy: $accuracy%${nc}"
    echo ""

    echo "play again? (r = restart, q = quit): "
    read play_again
    if [[ "$play_again" == "q" ]]; then
        break
    fi
done
