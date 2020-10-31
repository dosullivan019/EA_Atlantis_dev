#!/bin/bash
## instaling Atlantis for functionality
#sudo make install -C /home/demiurgo/Documents/PhD/Atlantis_Model/trunk/atlantis/
## This Code make an aumotamic backup of the log file
## The backup is do in it at the end of the run
#datIni="$(date +'%Y%m%d%H%M%S')"
#dateinicio="$(date +'%Y-%m-%d %H:%M:%S')"
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
## ~           Running Atlantis JFRE        ~ ##
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
atlantisMerged -i final_with_ice_input.nc 0 -o output.nc -r EA_run.prm -f EA_force.prm -p EA_physics.prm -b EA_biol.prm -h EA_harvest_nofishing.prm -s AntarcticGroupsnew2019.csv -d output_EA_biol_debug

## Backup of the log.txt file
#echo "++++++++++++++++++++++++++++++++++++++++"
#echo "  A Copy of the Log file as been made  "
#echo "++++++++++++++++++++++++++++++++++++++++"
# datEnd="$(date +'%Y%m%d%H%M%S')"
# dateend="$(date +'%Y-%m-%d %H:%M:%S')"
# cp -a SETas_Output_Folder/outputJFREAnnualAgeBiomIndx.txt Calibration/BioAge$datEnd.bak
# cp -a SETas_Output_Folder/outputJFREBiomIndx.txt Calibration/BioTot$datEnd.bak
# cp -a SETas_Output_Folder/outputJFRE.nc Calibration/Ncout$datEnd.nc
# if [ $(ls Calibration/*.nc | wc -l) -gt 4 ];
# then
#     rm "$(ls -t Calibration/*.nc | tail -1)"
#     echo "To save HD space I removed the file created 4 simulation ago"
# fi
# echo "...Done"

# osver=$(cat /etc/issue.net)

# ## Writing the information of the run in the RunTrack.org file
# echo "* Run PC-Demiurgo $datIni" >> RunTrack.org
# echo "  - Run start: $dateinicio">> RunTrack.org
# echo "  - Run end: $dateend">> RunTrack.org
# echo "  - log file : [[file:Calibration/$datEnd.bak][Backupfile]]">> RunTrack.org
# echo "  - OS : $osver">> RunTrack.org
# echo "  - Compiler version : gcc $(gcc -dumpversion)">> RunTrack.org
# echo "  - Bash Version : $BASH_VERSION">> RunTrack.org
# echo "  - Atlantis Version : $(sed -n '2p' < SETas_Output_Folder/log.txt)">> RunTrack.org
# echo "  - Run used :  $(sed -n '14p' < SETas_Output_Folder/log.txt)">> RunTrack.org

# echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
# echo " Do you want to do a commit? (Y)ES or (N)OT and press [ENTER]"
# echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
# read answer
# if [ $answer  ==  "Y" -o $answer  ==  "y" ];
# then
#     echo "Enter your comit and the press [ENTER]"
#     read comm
#     read comm2
#     while [[ ! -z "${comm2}" ]]
#     do
#         comm="$comm\n$comm2"
#         read comm2
#     done
#     git commit -a -m "$comm"
#     echo " Done!"
# else
#     echo " Automatic Git commit was done "
#     comm="Automatic backup $datEnd"
#     git commit -a -m "$comm"
#     echo "Done!"
# fi
# echo -e "  - Commit Githhub : $comm">> RunTrack.org

# echo "** Biomasss Plot">> RunTrack.org
# Rscript Figures_Save.R $datIni --save
# echo "#+CAPTION: Biomass plot for the simulation $datIni" >> RunTrack.org
# echo "[[file:/home/demiurgo/Documents/2017/Calibration_SETas/Model/SETas_model_Trunk_Stripped/Calibration/Figures/$datIni.png]]">> RunTrack.org
