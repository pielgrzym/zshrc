function rly(){
    local confirm
    echo " ___ "
    echo "{o,o}"
    echo "|)__)"
    echo "-\"-\"-"
    echo "O RLY?"
    read -q confirm
    if [[ $confirm == "y" || $confirm == "t" ]]; then
        echo "\n"
        "$@"
    else
        echo "\n"
        echo " ___ "
        echo "{o,o}"
        echo "(__(|"
        echo "-\"-\"-"
        echo "NO WAI!"
    fi
}
