#!/bin/bash

generate_target() {
    local word_count=$1
    local min=$2
    local max=$3
    grep -E "^[a-z]{$min,$max}$" /usr/share/dict/words | sort -R | head -n "$word_count" | xargs
}

# Color variables
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[33m'
nc='\033[0m'
nc_bold='\033[1m'
green_bold='\033[1;32m'

while true; do
    clear
    echo -e "${nc_bold}choose mode${nc}"
    echo "1) word based"
    echo "2) timer based"
    echo -n "select (1 or 2): "
    read mode_choice

    if [[ "$mode_choice" != "1" && "$mode_choice" != "2" ]]; then
        echo -e "${red}Invalid input! Please enter 1 or 2.${nc}"
        sleep 1
        continue
    fi

    while true; do
        clear
        echo "Select your difficulty:"
        echo "1) easy"
        echo "2) medium"
        echo "3) hard"
        echo -n "Choose (1, 2, or 3): "
        read choice

        if [[ "$choice" == "1" ]]; then
            target=$(generate_target 10 2 6)
            [[ "$mode_choice" == "2" ]] && time_limit=20
            break
        elif [[ "$choice" == "2" ]]; then
            target=$(generate_target 25 4 8)
            [[ "$mode_choice" == "2" ]] && time_limit=40
            break
        elif [[ "$choice" == "3" ]]; then
            target=$(generate_target 40 6 12)
            [[ "$mode_choice" == "2" ]] && time_limit=60
            break
        else
            echo -e "${red}Invalid input! Please enter 1, 2, or 3.${nc}"
            sleep 1
        fi
    done

    clear
    echo -e "${nc_bold}typing test!${nc}"
    echo -e "${nc_bold}mode: $([[ "$mode_choice" == "1" ]] && echo "word based" || echo "timer based")${nc}"
    if [[ "$mode_choice" == "2" ]]; then
        echo -e "time limit: ${yellow}${time_limit} seconds${nc}"
    else
        echo -e "time limit: ${yellow}60 seconds (upper limit)${nc}"
    fi
    echo ""
    echo -e "${red}${target}${nc}"
    echo ""
    echo "press enter, then immediately start typing!"
    read

    #starting test
    start_time=$(date +%s)
    user_input=""

    old_stty=$(stty -g)
    stty -echo -icanon min 0 time 0

    if [[ "$mode_choice" == "2" ]]; then
        echo -e "${green}Go! Hit enter when you're done.${nc}"
        echo -n "> "

        while true; do
            current_time=$(date +%s)
            elapsed=$(( current_time - start_time ))
            remaining=$(( time_limit - elapsed ))

            echo -ne "\033[s\033[0;40H${red}TIME: ${remaining}s  ${nc}\033[u"

            if (( remaining <= 0 )); then
                echo -e "\n${red}!! time expired !!${nc}"
                break
            fi

            char=$(dd bs=1 count=1 2>/dev/null)

            if [[ "$char" == $'\r' ]] || [[ "$char" == $'\n' ]]; then
                echo ""
                break
            elif [[ "$char" == $'\x7f' ]] || [[ "$char" == $'\x08' ]]; then
                if [[ ${#user_input} -gt 0 ]]; then
                    user_input="${user_input%?}"
                    echo -ne "\b \b"
                fi
            elif [[ -n "$char" ]]; then
                user_input+="$char"
                echo -n "$char"
            else
                sleep 0.1
            fi
        done

    else
        echo -e "${green}Go! Hit enter when you're done.${nc}"
        echo -n "> "

        while true; do
            current_time=$(date +%s)
            elapsed=$(( current_time - start_time ))

            if (( elapsed >= 60 )); then
                echo -e "\n${red}!! TIME EXPIRED (60s limit) !!${nc}"
                break
            fi

            char=$(dd bs=1 count=1 2>/dev/null)

            if [[ "$char" == $'\r' ]] || [[ "$char" == $'\n' ]]; then
                echo ""
                break
            elif [[ "$char" == $'\x7f' ]] || [[ "$char" == $'\x08' ]]; then
                if [[ ${#user_input} -gt 0 ]]; then
                    user_input="${user_input%?}"
                    echo -ne "\b \b"
                fi
            elif [[ -n "$char" ]]; then
                user_input+="$char"
                echo -n "$char"
            else
                sleep 0.1
            fi
        done
    fi

    stty "$old_stty"

    #stats
    end_time=$(date +%s)
    timetaken=$(( end_time - start_time ))
    [[ $timetaken -lt 1 ]] && timetaken=1

    IFS=' ' read -ra target_words <<< "$target"
    IFS=' ' read -ra user_words <<< "$user_input"

    correct_words=0
    for (( i=0; i<${#target_words[@]}; i++ )); do
        [[ "${target_words[$i]}" == "${user_words[$i]}" ]] && ((correct_words++))
    done

    total_words=${#target_words[@]}
    [[ $total_words -lt 1 ]] && total_words=1

    accuracy=$(( (correct_words * 100) / total_words ))
    wpm=$(( (correct_words * 60) / timetaken ))

    echo ""
    echo -e "${green_bold}final stats${nc}"
    echo -e "${green}time taken:   $timetaken seconds${nc}"
    echo -e "${green}your speed:   $wpm wpm${nc}"
    echo -e "${green}accuracy:     $accuracy%${nc}"
    echo ""

    echo -n "play again? (r = restart, q = quit): "
    read play_again
    if [[ "$play_again" == "q" ]]; then
        exit 0
    fi
done