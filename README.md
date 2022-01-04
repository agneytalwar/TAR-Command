# TAR-Command
The program mimics the functionality of TAR command in Linux<br/>
I have created 3 metadata files in addition to the archive file named as metadata1.txt metadata2.txt and trackline.txt<br/> 

BASH version:5.0.17<br/>
COMMANDS:    ./tarcommand.sh(press enter)<br/>

Note that there should be .txt extention of archive name i.e. archivename.tar IS NOT SUPPORTED . Instead just write archivename.txt<br/>
Archiving of media files is not supported<br/>
Examples:     <br/>
             1) tar -cvf tararchive.txt sampleinput.txt sampleinput2.txt<br/> 
             2) tar -rvf tararchive.txt appendfile.txt <br/>
             3) tar -tvf tararchive.txt<br/>
             4) tar -tf tararchive.txt      <br/>        
             5) (after deleting sampleinput.txt)<br/>
                tar -xvf tararchive.txt sampleinput.txt<br/>
              


