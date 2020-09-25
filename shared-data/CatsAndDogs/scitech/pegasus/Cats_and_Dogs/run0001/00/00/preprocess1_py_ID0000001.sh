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
Cat9.jpg:Dog3.jpg:Cat4.jpg:Dog5.jpg:Dog0.jpg:Dog1.jpg:Cat1.jpg:Dog7.jpg:Cat5.jpg:Cat7.jpg:Dog9.jpg:Dog4.jpg:Cat3.jpg:Dog2.jpg:Cat0.jpg:preprocess1_py:Cat2.jpg:Dog6.jpg:Cat8.jpg:Dog8.jpg:Cat6.jpg
eof

pegasus_lite_section_end stage_in
set +e
job_ec=0
pegasus_lite_section_start task_execute
printf "\n######################[Pegasus Lite] Executing the user task ######################\n"  1>&2
pegasus-kickstart  -n preprocess1.py -N ID0000001 -R condorpool  -s resized_Dog9.jpg=resized_Dog9.jpg -s resized_Cat8.jpg=resized_Cat8.jpg -s resized_Dog2.jpg=resized_Dog2.jpg -s resized_Cat6.jpg=resized_Cat6.jpg -s resized_Cat0.jpg=resized_Cat0.jpg -s labels.txt=labels.txt -s resized_Dog0.jpg=resized_Dog0.jpg -s resized_images.txt=resized_images.txt -s resized_Cat2.jpg=resized_Cat2.jpg -s resized_Dog4.jpg=resized_Dog4.jpg -s resized_Cat4.jpg=resized_Cat4.jpg -s resized_Dog8.jpg=resized_Dog8.jpg -s resized_Dog6.jpg=resized_Dog6.jpg -s resized_Dog3.jpg=resized_Dog3.jpg -s resized_Cat9.jpg=resized_Cat9.jpg -s resized_Cat1.jpg=resized_Cat1.jpg -s resized_Dog1.jpg=resized_Dog1.jpg -s resized_Cat7.jpg=resized_Cat7.jpg -s resized_Cat5.jpg=resized_Cat5.jpg -s resized_Dog5.jpg=resized_Dog5.jpg -s resized_Dog7.jpg=resized_Dog7.jpg -s resized_Cat3.jpg=resized_Cat3.jpg -L Cats_and_Dogs -T 2020-09-17T21:17:53+00:00 ./preprocess1_py 
job_ec=$?
pegasus_lite_section_end task_execute
set -e
pegasus_lite_section_start stage_out
pegasus_lite_section_end stage_out

set -e


# clear the trap, and exit cleanly
trap - EXIT
pegasus_lite_final_exit

