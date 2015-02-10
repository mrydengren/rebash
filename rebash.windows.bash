ORIGINAL_IFS=$IFS
IFS=$(echo -en "\n\b")

# define the rebash command.
for command_dir in "commands" "commands/windows"; do
    if [ ! -d ~/.rebash/${command_dir} ]; then
        continue;
    fi
    
    for command in ~/.rebash/${command_dir}/*.bash; do
        source $command
    done
done

source ~/.rebash/rebash.bash

# define aliases and functions.
for script_file_type in "lib" "aliases" "functions"; do
    if [ ! -d ~/.rebash/${script_file_type} ]; then
        continue;
    fi
    
    for script_file in ~/.rebash/${script_file_type}/*.bash; do
        source $script_file
    done
done

# define scripts.
if [ -d ~/.rebash/scripts ]; then
    for dir in ~/.rebash/scripts/*; do
        for script_file in ${dir}/*.bash; do
            script=${script_file##*/}
            target="/usr/bin/${script/.bash/}"
            
            if [ -e $target ]; then
                rm $target
            fi
            
            ln -s $script_file $target
        done
    done
fi

# include any user-specific functionality.
if [[ -e ~/.bash_profile_custom ]]; then
    source ~/.bash_profile_custom
fi

IFS=$ORIGINAL_IFS