#!/bin/bash

echo "RUNNING ZALOHA TO SYNCHRONIZE 'YHRI-2024'"

$HOME/bin/Zaloha.sh --sourceDir="/opt/Data/Personal/NextCloud/home/Documents/YHRI/YHRI-2024" --backupDir="/run/media/edavison/SP PHD U3/YHRI/YHRI-2024"
#./Zaloha.sh --sourceDir="test_source" --backupDir="test_backup" --color

metaDir="/run/media/edavison/SP PHD U3/YHRI/YHRI-2024/.Zaloha_metadata/"

echo "DISPLAYING STATISTICS ON THE RUN OF ZALOHA"
echo
printf "Objects compared ..................................... %12s\n" $(                                                              awk 'END { print NR }' "${metaDir}"370_union_s_diff.csv )
printf "Unavoidable removals from <backupDir> ................ %12s\n" $(                                                              awk 'END { print NR }' "${metaDir}"510_exec1.csv        )
printf "Copies to <backupDir> ................................ %12s\n" $(                                                              awk 'END { print NR }' "${metaDir}"520_exec2.csv        )
printf "Reverse-copies to <sourceDir> ........................ %12s\n" $( [ ! -e "${metaDir}"530_exec3.csv ]        && echo '(off)' || awk 'END { print NR }' "${metaDir}"530_exec3.csv        )
printf "Remaining removals from <backupDir> .................. %12s\n" $( [ ! -e "${metaDir}"540_exec4.csv ]        && echo '(off)' || awk 'END { print NR }' "${metaDir}"540_exec4.csv        )
printf "Files compared byte by byte .......................... %12s\n" $( [ ! -e "${metaDir}"555_byte_by_byte.csv ] && echo '(off)' || awk 'END { print NR }' "${metaDir}"555_byte_by_byte.csv )
printf "From byte by byte comparing: copies to <backupDir> ... %12s\n" $( [ ! -e "${metaDir}"550_exec5.csv ]        && echo '(off)' || awk 'END { print NR }' "${metaDir}"550_exec5.csv        )
printf "Objects in synchronized state ........................ %12s\n" $(                                                              awk 'END { print NR }' "${metaDir}"505_target.csv       )
