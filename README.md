# TAR-Command
The program mimics the functionality of TAR command in Linux
I have created 3 metadata files in addition to the archive file named as metadata1.txt metadata2.txt and trackline.txt 

BASH version:5.0.17
COMMANDS:    ./tarcommand.sh(press enter)

Note that there should be .txt extention of archive name i.e. archivename.tar IS NOT SUPPORTED . Instead just write archivename.txt
Archiving of media files is not supported
Examples:     
             1) tar -cvf tararchive.txt sampleinput.txt sampleinput2.txt 
             2) tar -rvf tararchive.txt appendfile.txt 
             3) tar -tvf tararchive.txt
             4) tar -tf tararchive.txt              
             5) (after deleting sampleinput.txt)
                tar -xvf tararchive.txt sampleinput.txt
              


