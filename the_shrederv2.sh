#!/bin/bash
# welcomes the user to the program
function welcome {
    clear
    echo "Welcome to the shreder.\n"
    echo "This program will find all external drives and erase them.\n"
    echo "Now let's shred!\n"
}

function getAllDrives {
    drives=($(sudo lsblk -l -a -d -n -o name))
    echo "${drives[@]}"
    if [[ "${drives[@]}" == "" ]]; then
        echo "no drives"
        return -1
    else
        return $drives
    fi
}

function eraseDrives {
    for drive in $(getAllDrives); do
        echo $drive
        if [[ "$drive" == "" ]]; then
            echo "list position is empty"
            continue
        fi
        if [[ "$drive" == *"sda"* ]]; then
            echo "list position was sda"
            continue
        fi
        if [[ "$drive" == *"loop"* ]]; then
            echo "list position was loop"
            continue
        else
            count=0
                drive="/dev/"$drive
                echo $drive
                for count in {0..10}; do
                    if [[ $count == 0 ]]; then
                        sudo shred -fzv -n 4 $drive
                    else
                        sudo shred -fzv -n 4 $drive$count
                    fi
                done
            fi
        done
}

welcome
eraseDrive