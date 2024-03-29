#!/bin/bash
echo ""
dr= 
log_file=path.log
dir_path=

# Code to find all the files with the given extension in the directory
# and creating a path.log file in the current working directory

# Begin

if [ $# -eq 0 ]; then
	dr=$(pwd)
	echo "Working directory : $dr"
	for j in {pdf,txt,c} ; do 
		find $dr -name "*.$j" -print>>$log_file
	done
else
	for i in $@; do
		if [ -d $i ]; then
			echo "Working directory : $i"
			for j in {pdf,txt,c,o} ; do
				find $i -name "*.$j" -print>>$log_file
			done
		else
			echo "Invalid Directory : $i"
		fi
	done
fi 

#End

# Display all the files in path.log
echo ""
echo "The following files will be changed : "
while read line ; do
	echo $line
done < $log_file
echo ""
echo "Do you want to move/remove the files [m/r/(q) to quit]? "

while true; do
	read decision
	if [ "$decision" = "r" ] || [ "$decision" = "m" ]; then
		break;
	fi
	if [ "$decision" = "q" ]; then
		rm $log_file
		exit
	fi
	echo "Invalid input : $decision"
done
	
# Code to remove all the file in path.log 
if [ "$decision" = "r" ]; then	
		echo "Are you sure [y/n] ? "
		read sure
		if [ "$sure" = "n" ]; then
			rm $log_file
			exit
		fi
		echo ""
		echo "Removing Files"	
		while read line ; do
			if [ -f $line ]; then
				rm $line
				echo "Removed $line"
			else
				echo "$line could not be removed : No such file" 
			fi
		done < $log_file

# Code to move all file in path.log

else
	echo "Enter the full path of the new directory : "
	read dir_path
	if [ -d $dir_path ]; then
		echo "Are you sure [y/n] ? "
		read sure
		if [ "$sure" = "n" ]; then
			rm $log_file
			exit
		fi
		while read line ; do
			if [ -f $line ]; then
				mv $line $dir_path
				echo "Moved $line to $dir_path"
			else
				echo "$line could not be moved : No such file"
			fi
		done < $log_file
	else
		echo "No such directory found : $dir_path"
	fi
fi

rm $log_file
