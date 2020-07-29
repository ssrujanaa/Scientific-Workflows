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
Cat17.jpg:Cat25.jpg:Dog68.jpg:Dog25.jpg:Cat61.jpg:Dog17.jpg:Cat6.jpg:Dog88.jpg:Cat53.jpg:Dog92.jpg:Cat96.jpg:Dog61.jpg:Dog29.jpg:Cat10.jpg:Dog33.jpg:Cat41.jpg:Cat68.jpg:Dog76.jpg:Cat84.jpg:Cat37.jpg:Dog45.jpg:Cat21.jpg:Dog3.jpg:Cat64.jpg:Dog81.jpg:Cat99.jpg:Dog21.jpg:Cat56.jpg:Cat81.jpg:Dog64.jpg:Cat73.jpg:Cat30.jpg:Dog72.jpg:Cat13.jpg:Cat88.jpg:Cat45.jpg:Cat28.jpg:Dog10.jpg:Dog96.jpg:Dog53.jpg:Cat92.jpg:Dog49.jpg:Dog79.jpg:Dog36.jpg:Dog26.jpg:Cat69.jpg:Cat26.jpg:Cat34.jpg:Dog69.jpg:Dog7.jpg:Cat60.jpg:Cat77.jpg:Dog87.jpg:Cat87.jpg:Cat44.jpg:Dog60.jpg:Dog75.jpg:Cat40.jpg:Cat83.jpg:Cat97.jpg:Dog16.jpg:Cat5.jpg:Cat49.jpg:Dog44.jpg:Dog59.jpg:Dog93.jpg:Dog2.jpg:Dog50.jpg:Cat54.jpg:Cat72.jpg:Cat11.jpg:Dog32.jpg:Cat12.jpg:Cat55.jpg:Dog48.jpg:Cat38.jpg:Dog82.jpg:Dog22.jpg:Dog65.jpg:Cat82.jpg:Cat48.jpg:Cat65.jpg:Cat22.jpg:Cat9.jpg:Dog37.jpg:Cat33.jpg:Cat16.jpg:Cat93.jpg:Cat59.jpg:Cat0.jpg:Dog11.jpg:Dog54.jpg:Dog6.jpg:Dog71.jpg:Cat50.jpg:Dog97.jpg:Cat76.jpg:Dog51.jpg:Cat94.jpg:Cat51.jpg:Dog94.jpg:Dog78.jpg:Cat43.jpg:Dog35.jpg:Cat86.jpg:Cat27.jpg:Dog43.jpg:Dog8.jpg:Cat35.jpg:Dog86.jpg:Cat78.jpg:Cat4.jpg:Dog15.jpg:Dog1.jpg:Cat66.jpg:Dog31.jpg:Cat23.jpg:Dog63.jpg:Dog20.jpg:Cat71.jpg:Cat19.jpg:Cat98.jpg:Dog27.jpg:preprocess1_py:Dog58.jpg:Cat39.jpg:Cat1.jpg:Dog55.jpg:Cat47.jpg:Cat90.jpg:Dog98.jpg:Dog38.jpg:Dog74.jpg:Dog12.jpg:Dog91.jpg:Dog47.jpg:Cat15.jpg:Dog40.jpg:Cat32.jpg:Dog5.jpg:Cat58.jpg:Dog66.jpg:Dog83.jpg:Cat75.jpg:Dog70.jpg:Cat62.jpg:Dog23.jpg:Cat8.jpg:Dog19.jpg:Cat42.jpg:Dog77.jpg:Cat18.jpg:Dog42.jpg:Dog18.jpg:Cat7.jpg:Dog85.jpg:Cat52.jpg:Dog52.jpg:Cat95.jpg:Dog95.jpg:Dog34.jpg:Cat70.jpg:Dog62.jpg:Dog0.jpg:Cat36.jpg:Cat79.jpg:Dog89.jpg:Dog46.jpg:Dog14.jpg:Dog9.jpg:Dog57.jpg:Cat3.jpg:Cat85.jpg:Cat24.jpg:Dog28.jpg:Cat67.jpg:Dog80.jpg:Dog99.jpg:Dog56.jpg:Dog13.jpg:Dog39.jpg:Dog4.jpg:Cat14.jpg:Dog90.jpg:Cat57.jpg:Cat31.jpg:Dog73.jpg:Cat91.jpg:Cat2.jpg:Cat74.jpg:Dog30.jpg:Dog67.jpg:Dog24.jpg:Cat29.jpg:Cat46.jpg:Cat80.jpg:Dog41.jpg:Cat20.jpg:Cat89.jpg:Cat63.jpg:Dog84.jpg
eof

pegasus_lite_section_end stage_in
set +e
job_ec=0
pegasus_lite_section_start task_execute
printf "\n######################[Pegasus Lite] Executing the user task ######################\n"  1>&2
pegasus-kickstart  -n preprocess1.py -N ID0000001 -R condorpool  -s labels.txt=labels.txt -s resized_images.txt=resized_images.txt -L Cats_and_Dogs -T 2020-07-29T16:06:39+00:00 ./preprocess1_py 
job_ec=$?
pegasus_lite_section_end task_execute
set -e
pegasus_lite_section_start stage_out
pegasus_lite_section_end stage_out

set -e


# clear the trap, and exit cleanly
trap - EXIT
pegasus_lite_final_exit

