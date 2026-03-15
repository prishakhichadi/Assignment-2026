#!/bin/bash

generate_target() {
    local word_count=$1
    local min=$2
    local max=$3
    grep -E "^[a-z]{$min,$max}$" /usr/share/dict/words | sort -R | head -n "$word_count" | xargs
}

red='\033[0;31m'
green='\033[0;32m'
yellow='\033[33m'
nc='\033[0m'
nc_bold='\033[1m'
green_bold='\033[1;32m'


while true; do
    clear
    echo -e "${nc_bold}choose mode:${nc}"
    echo "1) word based"
    echo "2) timer based"
    echo -n "Select (1 or 2): "
    read mode_choice

    if [[ "$mode_choice" != "1" && "$mode_choice" != "2" ]]; then
        echo -e "${red}Invalid input! Please enter 1 or 2.${nc}"
        sleep 1
        continue
    fi

    while true; do
        clear
        echo -e "${nc_bold}select difficulty:${nc}"
        echo "1) easy"
        echo "2) medium"
        echo "3) hard"
        echo -n "Choose (1, 2, or 3): "
        read choice

        if [[ "$choice" == "1" ]]; then
            target=$(generate_target 10 2 6)
            time_limit=25; break
        elif [[ "$choice" == "2" ]]; then
            target=$(generate_target 25 4 8)
            time_limit=45; break
        elif [[ "$choice" == "3" ]]; then
            target=$(generate_target 40 6 12)
            time_limit=80; break
        else
            echo -e "${red}Invalid input! Please enter 1, 2, or 3.${nc}"
            sleep 1
        fi
    done

  
    clear
    echo -e "${nc_bold}typing test${nc}"
    echo -e "Mode: $([[ "$mode_choice" == "1" ]] && echo "Word Based" || echo "Timer Based")"
    if [[ "$mode_choice" == "2" ]]; then
        echo -e "Time Limit: ${yellow}${time_limit}s${nc}"
    else
        echo -e "Time Limit: ${yellow}60s (Upper Limit)${nc}"
    fi
    echo -e "\n${red}${target}${nc}\n"
    echo "Press ENTER to start typing..."
    read

    start_time=$(date +%s)
    user_input=""

    old_stty=$(stty -g)
    stty -echo -icanon min 0 time 0

    echo -e "${green}Go! Hit enter when you're done.${nc}"
    echo -n "> "

    
    timer_expired_file=$(mktemp)
    timer_pid=""

    if [[ "$mode_choice" == "2" ]]; then
        (
            while true; do
                now=$(date +%s)
                remaining=$(( time_limit - (now - start_time) ))
                echo -ne "\033[s\033[0;40H${red}TIME: ${remaining}s  ${nc}\033[u"
                if (( remaining <= 0 )); then
                    echo "expired" > "$timer_expired_file"
                    break
                fi
                sleep 1
            done
        ) &
        timer_pid=$!
    else
        (
            sleep 60
            echo "expired" > "$timer_expired_file"
        ) &
        timer_pid=$!
    fi

    while true; do
        if [[ -s "$timer_expired_file" ]]; then
            echo ""
            break
        fi

        if IFS= read -r -n 1 char; then
            if [[ "$char" == $'\0' || "$char" == $'\n' || "$char" == $'\r' ]]; then
                echo ""
                break
            fi

            if [[ "$char" == $'\x7f' || "$char" == $'\x08' ]]; then
                if [[ ${#user_input} -gt 0 ]]; then
                    user_input="${user_input%?}"
                    echo -ne "\b \b"
                fi
            elif [[ -n "$char" || "$char" == " " ]]; then
                user_input+="$char"
                echo -n "$char"
            fi
        fi

        sleep 0.02
    done


    [[ -n "$timer_pid" ]] && kill "$timer_pid" 2>/dev/null
    rm -f "$timer_expired_file"

    stty "$old_stty"

    # stats
    end_time=$(date +%s)
    timetaken=$(( end_time - start_time ))
    [[ $timetaken -lt 1 ]] && timetaken=1

    IFS=' ' read -ra target_words <<< "$target"
    IFS=' ' read -ra user_words <<< "$user_input"

    correct_words=0
    for (( i=0; i<${#target_words[@]}; i++ )); do
        if [[ "${target_words[$i]}" == "${user_words[$i]}" ]]; then
            ((correct_words++))
        fi
    done

    total_words=${#target_words[@]}
    accuracy=$(( (correct_words * 100) / total_words ))
    wpm=$(( (correct_words * 60) / timetaken ))

    # results
    echo ""
    echo -e "${green_bold}--- FINAL STATS ---${nc}"
    echo -e "Time Taken:   $timetaken seconds"
    echo -e "Your Speed:   ${nc_bold}$wpm WPM${nc}"
    echo -e "Accuracy:     ${nc_bold}$accuracy%${nc}"
    echo ""

    echo -n "Play again? (r = restart, q = quit): "
    read play_again
    if [[ "$play_again" == "q" ]]; then
        echo "goodbye!"
        exit 0
    fi
done