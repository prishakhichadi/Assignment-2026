
#!/bin/bash

easy="the sun sets behind the tall mountains."
medium="success is not final, failure is not fatal: it is the courage to continue that counts."
hard="the biological brain is a complex system of neurons, but the silicon brain we build with code is a reflection of our own logic."

while true; do
    clear
    echo "select your difficulty"
    echo "1) easy"
    echo "2) medium"
    echo "3) hard"
    echo "choose (1, 2, or 3): "
    read choice

    if [[ "$choice" == "1" ]]; then
        target=$easy
    elif [[ "$choice" == "2" ]]; then
        target=$medium
    elif [[ "$choice" == "3" ]]; then
        target=$hard
    else
        target=$easy
    fi

    clear
    echo "typing test"
    echo ""
    echo "$target"
    echo ""
    echo "press ENTER, then immediately start typing!"
    read 
    
    start_time=$(date +%s)
    echo "> "
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

    echo -e "\nfinal stats"
    echo "time taken: $timetaken seconds"
    echo "your speed: $wpm wpm"
    echo "accuracy:   $accuracy%"
    echo ""

    echo "play again? (r = restart, q = quit): "
    read play_again
    if [[ "$play_again" == "q" ]]; then
        break
    fi
done
