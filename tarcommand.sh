#!/bin/bash
#read str
#set -- $str
#tokens=( $str )
#read -ra tokens <<<"$str"
read -r -a tokens 
#comman= ${tokens[0]}
options=${tokens[1]}
target=${tokens[2]}
source=${tokens[3]}
numfiles=${#tokens[@]}
if [ "${tokens[0]}" != "tar" ]; then
    echo "Please enter the command as tar [options] [filename] [sourcefiles]"
    exit 1
fi
c=0
r=0
t=0
x=0
f=0
v=0
#f-=0
if [[ "${tokens[1]}" == *"c"* ]];
then
  c=1
fi
if [[ "${tokens[1]}" == *"r"* ]]; 
then
  r=1
fi
if [[ "${tokens[1]}" == *"t"* ]];
then
  t=1
fi
if [[ "${tokens[1]}" == *"x"* ]]; 
then
  x=1
fi
if [[ "${tokens[1]}" == *"f"* ]]; 
then
  f=1
fi
if [[ "${tokens[1]}" == *"v"* ]]; 
then
  v=1
fi
if [ $c -eq 1 ] && [ $f -eq 1 ];
then
  touch ${tokens[2]}
fi
if [ $c -eq 1 ] || [ $r -eq 1  ];
then
   #open the file in append mode to write content into it
for (( i=3; i<numfiles; i++ ))
do  
if [[ "${tokens[i]}" == *"*."* ]]
then
    array=( $( ls ${tokens[i]} ) )
    numoffilestype=${#array[@]}
    for (( j=0; j<numoffilestype; j++ ))
    do
       filename="${array[j]}"
       filestart=$(wc -l < "${tokens[2]}")
       while read -r line; 
       do
          #name="$line"
          echo $line >> ${tokens[2]} 
          done < "$filename"
       ls -l "$filename" >>metadata1.txt
       ls "$filename" >>metadata2.txt
       linecount=$(wc -l < "$filename")
       if [ $v -eq 1 ]
       then
           ls $filename
       fi
       #do linecount +number of lines already in file
       echo $filename $filestart $linecount >> trackline.txt
    done
else    
    filename="${tokens[i]}"
    if [ ! -f "$filename" ]; then
         echo "$filename does not exist."
         exit 1
    fi
    filestart=$(wc -l < "${tokens[2]}")
    while read -r line; 
    do
       #name="$line"
       echo $line >> ${tokens[2]} 
       done < "$filename"
    ls -l "$filename" >>metadata1.txt
    ls "$filename" >>metadata2.txt
    linecount=$(wc -l < "$filename")
    if [ $v -eq 1 ]
    then
        ls $filename
    fi
    #do linecount +number of lines already in file
    echo $filename $filestart $linecount >> trackline.txt    
fi
done  
fi

if [ $t -eq 1 ]
then
  #display the table
  if [ $v -eq 1 ]
  then
    filename="metadata1.txt"
    while read -r line; 
    do
       echo $line
       done < "$filename"
  else 
    filename="metadata2.txt"
    while read -r line; 
    do
       echo $line
       done < "$filename"
  fi
fi
if [[ $x -eq 1 ]];
then
  #open the file and extract files
for (( i=3; i<numfiles; i++ ))
do  
    filename="${tokens[i]}"
    touch $filename
    startline=0
    endline=0
    while read -r line; 
    do
       read -ra arr <<<"$line"
       if [ "${arr[0]}" == $filename ]
       then
          startline=${arr[1]}
          ((endline=startline+${arr[2]}-1))
       fi
    done < "trackline.txt"
    i=0
    while read -r line; 
    do
       if [ $i -ge $startline ] && [ $i -le $endline ]
       then
          if [ $i -eq $startline ]
          then
              echo $line >$filename
          else echo $line >>$filename
          fi
       fi
       ((i++)) 
       done < "${tokens[2]}"
    if [ $v -eq 1 ]
    then
        ls $filename
    fi   
done 
if [ $numfiles -eq 3 ]
then
    while read -r filename; 
    do
        touch $filename
    	startline=0
    	endline=0
   	while read -r line; 
    	do
        read -ra arr <<<"$line"
        if [ "${arr[0]}" == $filename ]
        then
          	startline=${arr[1]}
          	((endline=startline+${arr[2]}-1))
       	fi
    		done < "trackline.txt"
        i=0
        while read -r line; 
        do
            if [ $i -ge $startline ] && [ $i -le $endline ]
            then
                #echo $line >>$filename
                if [ $i -eq $startline ]
                then
                     echo $line >$filename
                else echo $line >>$filename
                fi
            fi
            ((i++)) 
       done < "${tokens[2]}"
       if [ $v -eq 1 ]
       then
           ls $filename
       fi   
    done < "metadata2.txt"
fi 
fi

#echo $numfiles
#echo $options

