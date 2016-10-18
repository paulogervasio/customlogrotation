#!/bin/bash
clear
echo "----INACTIVE LOG VERIFIER-----"
echo
echo "this script get all 'expired files' and compress then in single file, removing the old ones."
echo "A expired file is a archive that not was accessed neither modified 60 days ago"
echo
echo


time_file_inactive="60 days ago";
date_expired_files=`date  +%Y-%m-%d  --date="$time_file_inactive"`;


#echo $date_expired_files

#echo "All files not modified or accessed since "$date_expired_files \n
#"will be compacted in a zip file and removed from log directory";


array_files_to_remove=[];
array_all_files=(`ls`);
default_tar_file_name="compressed_logs_"`date  +%Y-%m-%d`".tar";

count_rm_file=0;
c=0;
splitSeparator="|";

wasFoundOldFile=false;


while [[ $c != ${#array_all_files[*]} ]]; do


        info_file_str="stat --format=%n"$splitSeparator"%x"$splitSeparator"%y";
        file_name=${array_all_files[$c]};

        # get file stats
        rowFileInfo=`$info_file_str $file_name`;

        # get last access date and last modification date
        last_access=$(echo `$info_file_str $file_name` | cut -d'|' -f2|cut -d\  -f1);
        last_modification=$(echo `$info_file_str $file_name` | cut -d'|' -f3|cut -d\  -f1);

        #echo $file_name;
        #echo $last_access;
        #echo $last_modification;
	#echo $date_expired_files
        #echo "/////////////";
	
	
        if [[ $(date -d $last_modification +%s) -le $(date -d $date_expired_files +%s) || $(date -d $last_access +%s) -le $(date -d $date_expired_files +%s) ]]
        then

		wasFoundOldFile=true;
		array_files_to_remove[$count_rm_file]=$file_name;
		(( count_rm_file++ ));     
	fi

        (( c++ ))
done

if [[ $wasFoundOldFile -eq true ]]
then

	echo "files picked, wait for compression...";
	echo ""
	
	echo "reporting files compacted and removed:"
	echo "the output filename is: " $default_tar_file_name;


	for file in $array_files_to_remove
	do
		echo "from loop " $OUTPUT;
		tar zcvf $default_tar_file_name $file;
		rm -i $file;

	done

else
	echo "Theres no files to remove";
	exit 0;
fi


