#!/bin/bash
set -e
pegasus_lite_version_major="5"
pegasus_lite_version_minor="0"
pegasus_lite_version_patch="0dev"
pegasus_lite_enforce_strict_wp_check="true"
pegasus_lite_version_allow_wp_auto_download="true"


. pegasus-lite-common.sh

pegasus_lite_init

# cleanup in case of failures
trap pegasus_lite_signal_int INT
trap pegasus_lite_signal_term TERM
trap pegasus_lite_unexpected_exit EXIT

printf "\n########################[Pegasus Lite] Setting up workdir ########################\n"  1>&2
# work dir
export pegasus_lite_work_dir=$PWD
pegasus_lite_setup_work_dir

printf "\n##############[Pegasus Lite] Figuring out the worker package to use ##############\n"  1>&2
# figure out the worker package to use
pegasus_lite_worker_package

pegasus_lite_section_start stage_in
printf "\n##################### Setting the xbit for executables staged #####################\n"  1>&2
# set the xbit for any executables staged
if [ ! -x preprocess1_py ]; then
    /bin/chmod +x preprocess1_py
fi

printf "\n##################### Checking file integrity for input files #####################\n"  1>&2
# do file integrity checks
pegasus-integrity --print-timings --verify=stdin 1>&2 << 'eof'
Cat17.jpg:Cat25.jpg:Dog68.jpg:Dog25.jpg:Cat61.jpg:Dog17.jpg:Cat6.jpg:Dog88.jpg:Cat53.jpg:Dog92.jpg:Cat96.jpg:Dog61.jpg:Dog29.jpg:Cat10.jpg:Dog33.jpg:Cat68.jpg:Cat41.jpg:Dog76.jpg:Cat84.jpg:Dog45.jpg:Cat37.jpg:Cat64.jpg:Dog3.jpg:Cat21.jpg:Dog81.jpg:Cat99.jpg:Dog21.jpg:Cat81.jpg:Cat56.jpg:Dog64.jpg:Cat73.jpg:Dog72.jpg:Cat30.jpg:Cat13.jpg:Cat88.jpg:Cat45.jpg:Dog10.jpg:Cat28.jpg:Dog96.jpg:Dog53.jpg:Cat92.jpg:Dog49.jpg:Dog79.jpg:Dog36.jpg:Dog26.jpg:Cat69.jpg:Cat26.jpg:Cat34.jpg:Dog69.jpg:Dog7.jpg:Cat60.jpg:Cat77.jpg:Dog87.jpg:Cat87.jpg:Cat44.jpg:Dog60.jpg:Dog75.jpg:Cat40.jpg:Cat83.jpg:Cat97.jpg:Dog16.jpg:Cat5.jpg:Cat49.jpg:Dog44.jpg:Dog59.jpg:Dog93.jpg:Dog2.jpg:Dog50.jpg:Cat54.jpg:Cat72.jpg:Cat11.jpg:Dog32.jpg:Cat12.jpg:Cat55.jpg:Dog48.jpg:Cat38.jpg:Dog82.jpg:Dog22.jpg:Dog65.jpg:Cat82.jpg:Cat48.jpg:Cat65.jpg:Cat22.jpg:Cat9.jpg:Dog37.jpg:Cat33.jpg:Cat16.jpg:Cat93.jpg:Cat59.jpg:Cat0.jpg:Dog11.jpg:Dog6.jpg:Dog54.jpg:Dog71.jpg:Cat50.jpg:Dog97.jpg:Cat76.jpg:Dog51.jpg:Cat94.jpg:Cat51.jpg:Dog94.jpg:Dog78.jpg:Cat43.jpg:Cat86.jpg:Dog35.jpg:Cat27.jpg:Dog43.jpg:Dog8.jpg:Dog86.jpg:Cat35.jpg:Cat78.jpg:Cat4.jpg:Dog15.jpg:Dog1.jpg:Cat66.jpg:Dog31.jpg:Cat23.jpg:Dog63.jpg:Dog20.jpg:Cat71.jpg:Cat19.jpg:Cat98.jpg:Dog27.jpg:preprocess1_py:Dog58.jpg:Cat39.jpg:Cat1.jpg:Dog55.jpg:Cat47.jpg:Cat90.jpg:Dog98.jpg:Dog38.jpg:Dog74.jpg:Dog12.jpg:Dog91.jpg:Dog47.jpg:Cat15.jpg:Dog40.jpg:Dog5.jpg:Cat32.jpg:Cat58.jpg:Dog66.jpg:Dog83.jpg:Cat75.jpg:Cat62.jpg:Dog70.jpg:Dog23.jpg:Cat8.jpg:Dog19.jpg:Cat42.jpg:Dog77.jpg:Cat18.jpg:Dog42.jpg:Dog18.jpg:Cat7.jpg:Dog85.jpg:Cat52.jpg:Dog52.jpg:Cat95.jpg:Dog95.jpg:Dog34.jpg:Cat70.jpg:Dog62.jpg:Dog0.jpg:Cat36.jpg:Cat79.jpg:Dog89.jpg:Dog46.jpg:Dog14.jpg:Dog9.jpg:Dog57.jpg:Cat3.jpg:Cat24.jpg:Cat85.jpg:Dog28.jpg:Dog80.jpg:Cat67.jpg:Dog99.jpg:Dog56.jpg:Dog13.jpg:Dog39.jpg:Dog4.jpg:Cat14.jpg:Dog90.jpg:Cat57.jpg:Cat31.jpg:Cat91.jpg:Dog73.jpg:Cat2.jpg:Cat74.jpg:Dog30.jpg:Dog67.jpg:Dog24.jpg:Cat29.jpg:Cat46.jpg:Cat80.jpg:Dog41.jpg:Cat20.jpg:Cat89.jpg:Cat63.jpg:Dog84.jpg
eof

pegasus_lite_section_end stage_in
set +e
job_ec=0
pegasus_lite_section_start task_execute
printf "\n######################[Pegasus Lite] Executing the user task ######################\n"  1>&2
pegasus-kickstart  -n preprocess1.py -N ID0000001 -R condorpool  -s resized_Dog23.jpg=resized_Dog23.jpg -s resized_Cat66.jpg=resized_Cat66.jpg -s resized_Cat74.jpg=resized_Cat74.jpg -s resized_Dog58.jpg=resized_Dog58.jpg -s resized_Cat23.jpg=resized_Cat23.jpg -s resized_Dog31.jpg=resized_Dog31.jpg -s resized_Dog74.jpg=resized_Dog74.jpg -s resized_Dog82.jpg=resized_Dog82.jpg -s resized_Dog15.jpg=resized_Dog15.jpg -s resized_Cat31.jpg=resized_Cat31.jpg -s resized_Cat90.jpg=resized_Cat90.jpg -s resized_Cat82.jpg=resized_Cat82.jpg -s resized_Cat1.jpg=resized_Cat1.jpg -s resized_Cat5.jpg=resized_Cat5.jpg -s resized_Dog90.jpg=resized_Dog90.jpg -s resized_Cat38.jpg=resized_Cat38.jpg -s resized_Cat54.jpg=resized_Cat54.jpg -s resized_Cat11.jpg=resized_Cat11.jpg -s resized_Dog62.jpg=resized_Dog62.jpg -s resized_Dog1.jpg=resized_Dog1.jpg -s resized_Dog27.jpg=resized_Dog27.jpg -s resized_Cat97.jpg=resized_Cat97.jpg -s resized_Cat19.jpg=resized_Cat19.jpg -s resized_Dog9.jpg=resized_Dog9.jpg -s resized_Cat8.jpg=resized_Cat8.jpg -s resized_Cat27.jpg=resized_Cat27.jpg -s resized_Dog11.jpg=resized_Dog11.jpg -s resized_Cat35.jpg=resized_Cat35.jpg -s resized_Dog89.jpg=resized_Dog89.jpg -s resized_Dog43.jpg=resized_Dog43.jpg -s resized_Dog86.jpg=resized_Dog86.jpg -s resized_Cat78.jpg=resized_Cat78.jpg -s resized_Dog46.jpg=resized_Dog46.jpg -s resized_Cat50.jpg=resized_Cat50.jpg -s resized_Cat63.jpg=resized_Cat63.jpg -s resized_Cat20.jpg=resized_Cat20.jpg -s resized_Cat46.jpg=resized_Cat46.jpg -s resized_Dog78.jpg=resized_Dog78.jpg -s resized_Dog35.jpg=resized_Dog35.jpg -s resized_Dog54.jpg=resized_Dog54.jpg -s resized_Cat89.jpg=resized_Cat89.jpg -s resized_Dog97.jpg=resized_Dog97.jpg -s resized_Dog18.jpg=resized_Dog18.jpg -s resized_Dog71.jpg=resized_Dog71.jpg -s resized_Cat93.jpg=resized_Cat93.jpg -s resized_Dog5.jpg=resized_Dog5.jpg -s resized_Cat49.jpg=resized_Cat49.jpg -s resized_Dog83.jpg=resized_Dog83.jpg -s resized_Cat40.jpg=resized_Cat40.jpg -s resized_Dog67.jpg=resized_Dog67.jpg -s resized_Cat2.jpg=resized_Cat2.jpg -s resized_Dog24.jpg=resized_Dog24.jpg -s resized_Dog4.jpg=resized_Dog4.jpg -s resized_Dog65.jpg=resized_Dog65.jpg -s resized_Cat83.jpg=resized_Cat83.jpg -s resized_Cat30.jpg=resized_Cat30.jpg -s resized_Dog59.jpg=resized_Dog59.jpg -s resized_Dog16.jpg=resized_Dog16.jpg -s resized_Cat73.jpg=resized_Cat73.jpg -s resized_Dog73.jpg=resized_Dog73.jpg -s resized_Dog30.jpg=resized_Dog30.jpg -s resized_Cat12.jpg=resized_Cat12.jpg -s resized_Cat55.jpg=resized_Cat55.jpg -s resized_Dog93.jpg=resized_Dog93.jpg -s labels.txt=labels.txt -s resized_Dog39.jpg=resized_Dog39.jpg -s resized_Cat98.jpg=resized_Cat98.jpg -s resized_Dog50.jpg=resized_Dog50.jpg -s resized_Cat18.jpg=resized_Cat18.jpg -s resized_Cat67.jpg=resized_Cat67.jpg -s resized_Cat24.jpg=resized_Cat24.jpg -s resized_Dog44.jpg=resized_Dog44.jpg -s resized_Dog28.jpg=resized_Dog28.jpg -s resized_Dog61.jpg=resized_Dog61.jpg -s resized_Cat28.jpg=resized_Cat28.jpg -s resized_Dog88.jpg=resized_Dog88.jpg -s resized_Dog45.jpg=resized_Dog45.jpg -s resized_Dog87.jpg=resized_Dog87.jpg -s resized_Dog8.jpg=resized_Dog8.jpg -s resized_Dog38.jpg=resized_Dog38.jpg -s resized_Dog94.jpg=resized_Dog94.jpg -s resized_Dog55.jpg=resized_Dog55.jpg -s resized_Cat34.jpg=resized_Cat34.jpg -s resized_Dog51.jpg=resized_Dog51.jpg -s resized_Dog12.jpg=resized_Dog12.jpg -s resized_Dog72.jpg=resized_Dog72.jpg -s resized_Dog77.jpg=resized_Dog77.jpg -s resized_Dog17.jpg=resized_Dog17.jpg -s resized_Dog34.jpg=resized_Dog34.jpg -s resized_Cat39.jpg=resized_Cat39.jpg -s resized_Dog98.jpg=resized_Dog98.jpg -s resized_Cat77.jpg=resized_Cat77.jpg -s resized_Cat94.jpg=resized_Cat94.jpg -s resized_Cat51.jpg=resized_Cat51.jpg -s resized_Cat62.jpg=resized_Cat62.jpg -s resized_Cat45.jpg=resized_Cat45.jpg -s resized_Cat88.jpg=resized_Cat88.jpg -s resized_Dog49.jpg=resized_Dog49.jpg -s resized_Cat7.jpg=resized_Cat7.jpg -s resized_Dog40.jpg=resized_Dog40.jpg -s resized_Dog66.jpg=resized_Dog66.jpg -s resized_Dog3.jpg=resized_Dog3.jpg -s resized_Cat48.jpg=resized_Cat48.jpg -s resized_Cat13.jpg=resized_Cat13.jpg -s resized_Dog33.jpg=resized_Dog33.jpg -s resized_Cat21.jpg=resized_Cat21.jpg -s resized_Dog68.jpg=resized_Dog68.jpg -s resized_Cat99.jpg=resized_Cat99.jpg -s resized_Dog21.jpg=resized_Dog21.jpg -s resized_Dog64.jpg=resized_Dog64.jpg -s resized_Cat56.jpg=resized_Cat56.jpg -s resized_Dog25.jpg=resized_Dog25.jpg -s resized_Cat17.jpg=resized_Cat17.jpg -s resized_Cat72.jpg=resized_Cat72.jpg -s resized_Cat25.jpg=resized_Cat25.jpg -s resized_Dog99.jpg=resized_Dog99.jpg -s resized_Cat68.jpg=resized_Cat68.jpg -s resized_Dog56.jpg=resized_Dog56.jpg -s resized_Dog80.jpg=resized_Dog80.jpg -s resized_Dog76.jpg=resized_Dog76.jpg -s resized_Dog13.jpg=resized_Dog13.jpg -s resized_Dog92.jpg=resized_Dog92.jpg -s resized_Cat41.jpg=resized_Cat41.jpg -s resized_Cat84.jpg=resized_Cat84.jpg -s resized_Cat3.jpg=resized_Cat3.jpg -s resized_Cat61.jpg=resized_Cat61.jpg -s resized_Dog0.jpg=resized_Dog0.jpg -s resized_Dog37.jpg=resized_Dog37.jpg -s resized_images.txt=resized_images.txt -s resized_Cat87.jpg=resized_Cat87.jpg -s resized_Dog52.jpg=resized_Dog52.jpg -s resized_Cat44.jpg=resized_Cat44.jpg -s resized_Dog60.jpg=resized_Dog60.jpg -s resized_Cat29.jpg=resized_Cat29.jpg -s resized_Dog29.jpg=resized_Dog29.jpg -s resized_Dog95.jpg=resized_Dog95.jpg -s resized_Cat52.jpg=resized_Cat52.jpg -s resized_Cat95.jpg=resized_Cat95.jpg -s resized_Dog7.jpg=resized_Dog7.jpg -s resized_Cat80.jpg=resized_Cat80.jpg -s resized_Cat33.jpg=resized_Cat33.jpg -s resized_Cat6.jpg=resized_Cat6.jpg -s resized_Cat16.jpg=resized_Cat16.jpg -s resized_Cat59.jpg=resized_Cat59.jpg -s resized_Dog84.jpg=resized_Dog84.jpg -s resized_Dog22.jpg=resized_Dog22.jpg -s resized_Dog41.jpg=resized_Dog41.jpg -s resized_Dog48.jpg=resized_Dog48.jpg -s resized_Cat76.jpg=resized_Cat76.jpg -s resized_Cat91.jpg=resized_Cat91.jpg -s resized_Cat57.jpg=resized_Cat57.jpg -s resized_Cat14.jpg=resized_Cat14.jpg -s resized_Cat4.jpg=resized_Cat4.jpg -s resized_Dog91.jpg=resized_Dog91.jpg -s resized_Cat65.jpg=resized_Cat65.jpg -s resized_Cat22.jpg=resized_Cat22.jpg -s resized_Dog81.jpg=resized_Dog81.jpg -s resized_Cat42.jpg=resized_Cat42.jpg -s resized_Cat85.jpg=resized_Cat85.jpg -s resized_Dog2.jpg=resized_Dog2.jpg -s resized_Dog20.jpg=resized_Dog20.jpg -s resized_Dog63.jpg=resized_Dog63.jpg -s resized_Dog69.jpg=resized_Dog69.jpg -s resized_Dog26.jpg=resized_Dog26.jpg -s resized_Cat37.jpg=resized_Cat37.jpg -s resized_Dog32.jpg=resized_Dog32.jpg -s resized_Dog14.jpg=resized_Dog14.jpg -s resized_Dog57.jpg=resized_Dog57.jpg -s resized_Dog75.jpg=resized_Dog75.jpg -s resized_Cat71.jpg=resized_Cat71.jpg -s resized_Dog96.jpg=resized_Dog96.jpg -s resized_Cat36.jpg=resized_Cat36.jpg -s resized_Dog53.jpg=resized_Dog53.jpg -s resized_Dog36.jpg=resized_Dog36.jpg -s resized_Cat53.jpg=resized_Cat53.jpg -s resized_Cat79.jpg=resized_Cat79.jpg -s resized_Dog70.jpg=resized_Dog70.jpg -s resized_Cat10.jpg=resized_Cat10.jpg -s resized_Dog19.jpg=resized_Dog19.jpg -s resized_Cat70.jpg=resized_Cat70.jpg -s resized_Cat96.jpg=resized_Cat96.jpg -s resized_Cat9.jpg=resized_Cat9.jpg -s resized_Cat60.jpg=resized_Cat60.jpg -s resized_Cat69.jpg=resized_Cat69.jpg -s resized_Cat26.jpg=resized_Cat26.jpg -s resized_Cat86.jpg=resized_Cat86.jpg -s resized_Cat43.jpg=resized_Cat43.jpg -s resized_Dog47.jpg=resized_Dog47.jpg -s resized_Cat47.jpg=resized_Cat47.jpg -s resized_Dog42.jpg=resized_Dog42.jpg -s resized_Cat64.jpg=resized_Cat64.jpg -s resized_Dog85.jpg=resized_Dog85.jpg -s resized_Cat0.jpg=resized_Cat0.jpg -s resized_Cat81.jpg=resized_Cat81.jpg -s resized_Dog6.jpg=resized_Dog6.jpg -s resized_Cat92.jpg=resized_Cat92.jpg -s resized_Cat75.jpg=resized_Cat75.jpg -s resized_Cat15.jpg=resized_Cat15.jpg -s resized_Dog79.jpg=resized_Dog79.jpg -s resized_Dog10.jpg=resized_Dog10.jpg -s resized_Cat32.jpg=resized_Cat32.jpg -s resized_Cat58.jpg=resized_Cat58.jpg -L Cats_and_Dogs -T 2020-08-18T03:59:03+00:00 ./preprocess1_py 
job_ec=$?
pegasus_lite_section_end task_execute
set -e
pegasus_lite_section_start stage_out
pegasus_lite_section_end stage_out

set -e


# clear the trap, and exit cleanly
trap - EXIT
pegasus_lite_final_exit

