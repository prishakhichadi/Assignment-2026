
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
nc='\033[0m' # no colour
nc_bold='\033[1m'
green_bold='\033[1;32m'

easy="success is not final, failure is not fatal: it is the courage to continue that counts."

while true; do

    clear
    echo -e "${nc_bold}choose mode${nc}"
    echo "1) word based"
    echo "2) timer based"
    echo -n "select: "
    read mode_choice

    clear
    echo "select your difficulty"
    echo "1) easy"
    echo "2) medium"
    echo "3) hard"
    echo "choose (1, 2, or 3): "
    read choice



    if [[ "$choice" == "1" ]]; then
        target=$(generate_target 10 2 6)
        time_limit=20
    elif [[ "$choice" == "2" ]]; then
        target=$(generate_target 25 4 8)
        time_limit=40
    elif [[ "$choice" == "3" ]]; then
        target=$(generate_target 40 6 12)
        time_limit=60
    else
        target=$easy
    fi

    typing_test="typing test!"

    upper_lim=60 #for word mode

    clear
    echo -e "${nc_bold}${typing_test}${nc}"
    echo -e "${nc_bold}mode: $([[ "$mode_choice" == "1" ]] && echo "word based" || echo "timer based")${nc}"
    echo -e "time limit: ${yellow}${time_limit} seconds${nc}"
    echo "remember to click enter before reaching time limit!"
    echo ""
    echo -e "${red}${target}${nc}"
    echo ""
    echo "press enter, then immediately start typing!"
    read 
    
    start_time=$(date +%s)

    if [[ "$mode_choice" == "2" ]]; then
        echo -e "${red}you have $time_limit seconds!${nc}"
        echo -n "> "
        read -t "$time_limit" user_input
    else
        echo -e "${green}word mode(Max: ${upper_lim}s)!${nc}"
        echo -n "> "
        read -t "$upper_lim" user_input
    fi


    end_time=$(date +%s)

    # computing
    timetaken=$(( end_time - start_time ))

    if [[ -z "$user_input" ]]; then 
        echo -e "\n${red}TIME UP!${nc}"
        user_input=" " # avoid errors
    fi

    chars=${#user_input}

    if [ $timetaken -lt 1 ]; then timetaken=1; fi

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
