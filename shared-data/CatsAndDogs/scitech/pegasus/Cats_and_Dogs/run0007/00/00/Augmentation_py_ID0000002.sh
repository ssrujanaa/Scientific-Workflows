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
if [ ! -x Augmentation_py ]; then
    /bin/chmod +x Augmentation_py
fi

printf "\n##################### Checking file integrity for input files #####################\n"  1>&2
# do file integrity checks
pegasus-integrity --print-timings --verify=stdin 1>&2 << 'eof'
resized_Dog23.jpg:resized_Cat66.jpg:resized_Cat74.jpg:resized_Dog58.jpg:resized_Cat23.jpg:resized_Dog31.jpg:resized_Dog82.jpg:resized_Dog74.jpg:resized_Dog15.jpg:resized_Cat31.jpg:resized_Cat90.jpg:resized_Cat82.jpg:resized_Cat1.jpg:resized_Cat5.jpg:resized_Dog90.jpg:resized_Cat38.jpg:resized_Cat54.jpg:resized_Cat11.jpg:resized_Dog1.jpg:resized_Dog62.jpg:resized_Dog27.jpg:resized_Cat19.jpg:resized_Cat97.jpg:resized_Dog9.jpg:resized_Cat8.jpg:resized_Cat27.jpg:resized_Dog11.jpg:resized_Cat35.jpg:resized_Dog89.jpg:resized_Dog43.jpg:resized_Dog86.jpg:resized_Cat78.jpg:resized_Dog46.jpg:Augmentation_py:resized_Cat50.jpg:resized_Cat63.jpg:resized_Cat20.jpg:resized_Cat46.jpg:resized_Dog78.jpg:resized_Dog35.jpg:resized_Dog54.jpg:resized_Cat89.jpg:resized_Dog18.jpg:resized_Dog97.jpg:resized_Dog71.jpg:resized_Cat93.jpg:resized_Dog5.jpg:resized_Cat49.jpg:resized_Dog83.jpg:resized_Cat40.jpg:resized_Dog67.jpg:resized_Cat2.jpg:resized_Dog4.jpg:resized_Dog24.jpg:resized_Dog65.jpg:resized_Cat83.jpg:resized_Dog59.jpg:resized_Cat30.jpg:resized_Dog16.jpg:resized_Cat73.jpg:resized_Dog73.jpg:resized_Dog30.jpg:resized_Cat12.jpg:resized_Cat55.jpg:labels.txt:resized_Dog93.jpg:resized_Dog39.jpg:resized_Cat98.jpg:resized_Dog50.jpg:resized_Cat18.jpg:resized_Cat67.jpg:resized_Cat24.jpg:resized_Dog44.jpg:resized_Dog28.jpg:resized_Cat28.jpg:resized_Dog61.jpg:resized_Dog88.jpg:resized_Dog45.jpg:resized_Dog87.jpg:resized_Dog8.jpg:resized_Dog38.jpg:resized_Dog94.jpg:resized_Dog55.jpg:resized_Cat34.jpg:resized_Dog51.jpg:resized_Dog12.jpg:resized_Dog72.jpg:resized_Dog77.jpg:resized_Dog17.jpg:resized_Dog34.jpg:resized_Dog98.jpg:resized_Cat39.jpg:resized_Cat77.jpg:resized_Cat94.jpg:resized_Cat51.jpg:resized_Cat62.jpg:resized_Cat45.jpg:resized_Dog49.jpg:resized_Cat88.jpg:resized_Cat7.jpg:resized_Dog40.jpg:resized_Dog66.jpg:resized_Dog3.jpg:resized_Cat48.jpg:resized_Cat13.jpg:resized_Dog33.jpg:resized_Cat21.jpg:resized_Dog68.jpg:resized_Cat99.jpg:resized_Dog21.jpg:resized_Dog64.jpg:resized_Cat56.jpg:resized_Dog25.jpg:resized_Cat17.jpg:resized_Cat72.jpg:resized_Cat25.jpg:resized_Dog99.jpg:resized_Cat68.jpg:resized_Dog56.jpg:resized_Dog80.jpg:resized_Dog76.jpg:resized_Dog13.jpg:resized_Dog92.jpg:resized_Cat41.jpg:resized_Cat84.jpg:resized_Cat3.jpg:resized_Cat61.jpg:resized_Dog0.jpg:resized_Dog37.jpg:resized_images.txt:resized_Cat87.jpg:resized_Dog52.jpg:resized_Cat44.jpg:resized_Cat29.jpg:resized_Dog60.jpg:resized_Dog29.jpg:resized_Dog95.jpg:resized_Cat52.jpg:resized_Cat95.jpg:resized_Dog7.jpg:resized_Cat80.jpg:resized_Cat6.jpg:resized_Cat33.jpg:resized_Cat16.jpg:resized_Cat59.jpg:resized_Dog84.jpg:resized_Dog22.jpg:resized_Dog41.jpg:resized_Dog48.jpg:resized_Cat76.jpg:resized_Cat91.jpg:resized_Cat57.jpg:resized_Cat14.jpg:resized_Cat4.jpg:resized_Dog91.jpg:resized_Cat65.jpg:resized_Cat22.jpg:resized_Dog81.jpg:resized_Cat42.jpg:resized_Cat85.jpg:resized_Dog2.jpg:resized_Dog20.jpg:resized_Dog63.jpg:resized_Dog69.jpg:resized_Dog26.jpg:resized_Cat37.jpg:resized_Dog32.jpg:resized_Dog14.jpg:resized_Dog57.jpg:resized_Dog75.jpg:resized_Cat71.jpg:resized_Dog96.jpg:resized_Dog53.jpg:resized_Cat36.jpg:resized_Cat53.jpg:resized_Dog36.jpg:resized_Cat79.jpg:resized_Dog70.jpg:resized_Cat10.jpg:resized_Cat70.jpg:resized_Dog19.jpg:resized_Cat96.jpg:resized_Cat9.jpg:resized_Cat60.jpg:resized_Cat69.jpg:resized_Cat26.jpg:resized_Cat86.jpg:resized_Cat43.jpg:resized_Dog47.jpg:resized_Dog42.jpg:resized_Cat47.jpg:resized_Cat64.jpg:resized_Dog85.jpg:resized_Cat0.jpg:resized_Cat81.jpg:resized_Dog6.jpg:resized_Cat92.jpg:resized_Cat75.jpg:resized_Cat15.jpg:resized_Dog79.jpg:resized_Cat32.jpg:resized_Dog10.jpg:resized_Cat58.jpg
eof

pegasus_lite_section_end stage_in
set +e
job_ec=0
pegasus_lite_section_start task_execute
printf "\n######################[Pegasus Lite] Executing the user task ######################\n"  1>&2
pegasus-kickstart  -n Augmentation.py -N ID0000002 -R condorpool  -s aug_labels.txt=aug_labels.txt -s augmentation.txt=augmentation.txt -L Cats_and_Dogs -T 2020-08-03T17:53:14+00:00 ./Augmentation_py 
job_ec=$?
pegasus_lite_section_end task_execute
set -e
pegasus_lite_section_start stage_out
pegasus_lite_section_end stage_out

set -e


# clear the trap, and exit cleanly
trap - EXIT
pegasus_lite_final_exit

