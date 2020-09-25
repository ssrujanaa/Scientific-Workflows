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
resized_Dog9.jpg:resized_Cat8.jpg:resized_Dog2.jpg:resized_Cat6.jpg:resized_Dog0.jpg:labels.txt:resized_Cat0.jpg:resized_Cat2.jpg:resized_Dog4.jpg:resized_Dog8.jpg:resized_Cat4.jpg:resized_Dog6.jpg:resized_Dog3.jpg:resized_Cat9.jpg:resized_Cat1.jpg:resized_Dog1.jpg:resized_Cat7.jpg:resized_Cat5.jpg:resized_Dog5.jpg:Augmentation_py:resized_Dog7.jpg:resized_Cat3.jpg
eof

pegasus_lite_section_end stage_in
set +e
job_ec=0
pegasus_lite_section_start task_execute
printf "\n######################[Pegasus Lite] Executing the user task ######################\n"  1>&2
pegasus-kickstart  -n Augmentation.py -N ID0000002 -R condorpool  -s Aug_resized_Dog4_2.jpg=Aug_resized_Dog4_2.jpg -s Aug_resized_Cat6_1.jpg=Aug_resized_Cat6_1.jpg -s Aug_resized_Cat3_0.jpg=Aug_resized_Cat3_0.jpg -s Aug_resized_Cat9_2.jpg=Aug_resized_Cat9_2.jpg -s Aug_resized_Cat2_2.jpg=Aug_resized_Cat2_2.jpg -s Aug_resized_Dog1_1.jpg=Aug_resized_Dog1_1.jpg -s Aug_resized_Dog8_0.jpg=Aug_resized_Dog8_0.jpg -s Aug_resized_Cat6_0.jpg=Aug_resized_Cat6_0.jpg -s Aug_resized_Cat6_2.jpg=Aug_resized_Cat6_2.jpg -s Aug_resized_Dog7_2.jpg=Aug_resized_Dog7_2.jpg -s Aug_resized_Dog4_1.jpg=Aug_resized_Dog4_1.jpg -s Aug_resized_Dog0_2.jpg=Aug_resized_Dog0_2.jpg -s Aug_resized_Cat7_0.jpg=Aug_resized_Cat7_0.jpg -s Aug_resized_Cat2_1.jpg=Aug_resized_Cat2_1.jpg -s Aug_resized_Dog1_0.jpg=Aug_resized_Dog1_0.jpg -s Aug_resized_Dog9_0.jpg=Aug_resized_Dog9_0.jpg -s Aug_resized_Cat2_0.jpg=Aug_resized_Cat2_0.jpg -s Aug_resized_Dog2_0.jpg=Aug_resized_Dog2_0.jpg -s Aug_resized_Cat5_1.jpg=Aug_resized_Cat5_1.jpg -s Aug_resized_Cat7_1.jpg=Aug_resized_Cat7_1.jpg -s Aug_resized_Dog2_1.jpg=Aug_resized_Dog2_1.jpg -s Aug_resized_Dog5_1.jpg=Aug_resized_Dog5_1.jpg -s augmentation.txt=augmentation.txt -s Aug_resized_Dog8_2.jpg=Aug_resized_Dog8_2.jpg -s Aug_resized_Dog1_2.jpg=Aug_resized_Dog1_2.jpg -s Aug_resized_Cat1_2.jpg=Aug_resized_Cat1_2.jpg -s Aug_resized_Cat5_0.jpg=Aug_resized_Cat5_0.jpg -s Aug_resized_Cat7_2.jpg=Aug_resized_Cat7_2.jpg -s Aug_resized_Dog8_1.jpg=Aug_resized_Dog8_1.jpg -s Aug_resized_Cat1_1.jpg=Aug_resized_Cat1_1.jpg -s Aug_resized_Dog5_0.jpg=Aug_resized_Dog5_0.jpg -s Aug_resized_Cat4_2.jpg=Aug_resized_Cat4_2.jpg -s Aug_resized_Cat8_0.jpg=Aug_resized_Cat8_0.jpg -s Aug_resized_Dog3_0.jpg=Aug_resized_Dog3_0.jpg -s Aug_resized_Dog6_1.jpg=Aug_resized_Dog6_1.jpg -s Aug_resized_Dog9_2.jpg=Aug_resized_Dog9_2.jpg -s Aug_resized_Cat1_0.jpg=Aug_resized_Cat1_0.jpg -s Aug_resized_Cat4_1.jpg=Aug_resized_Cat4_1.jpg -s Aug_resized_Cat8_1.jpg=Aug_resized_Cat8_1.jpg -s Aug_resized_Cat0_2.jpg=Aug_resized_Cat0_2.jpg -s Aug_resized_Dog6_0.jpg=Aug_resized_Dog6_0.jpg -s Aug_resized_Dog9_1.jpg=Aug_resized_Dog9_1.jpg -s Aug_resized_Cat4_0.jpg=Aug_resized_Cat4_0.jpg -s Aug_resized_Cat8_2.jpg=Aug_resized_Cat8_2.jpg -s Aug_resized_Dog5_2.jpg=Aug_resized_Dog5_2.jpg -s Aug_resized_Dog2_2.jpg=Aug_resized_Dog2_2.jpg -s Aug_resized_Cat0_1.jpg=Aug_resized_Cat0_1.jpg -s aug_labels.txt=aug_labels.txt -s Aug_resized_Dog7_1.jpg=Aug_resized_Dog7_1.jpg -s Aug_resized_Cat3_2.jpg=Aug_resized_Cat3_2.jpg -s Aug_resized_Dog0_1.jpg=Aug_resized_Dog0_1.jpg -s Aug_resized_Cat9_0.jpg=Aug_resized_Cat9_0.jpg -s Aug_resized_Cat5_2.jpg=Aug_resized_Cat5_2.jpg -s Aug_resized_Dog4_0.jpg=Aug_resized_Dog4_0.jpg -s Aug_resized_Dog7_0.jpg=Aug_resized_Dog7_0.jpg -s Aug_resized_Dog3_2.jpg=Aug_resized_Dog3_2.jpg -s Aug_resized_Cat3_1.jpg=Aug_resized_Cat3_1.jpg -s Aug_resized_Cat9_1.jpg=Aug_resized_Cat9_1.jpg -s Aug_resized_Dog3_1.jpg=Aug_resized_Dog3_1.jpg -s Aug_resized_Cat0_0.jpg=Aug_resized_Cat0_0.jpg -s Aug_resized_Dog0_0.jpg=Aug_resized_Dog0_0.jpg -s Aug_resized_Dog6_2.jpg=Aug_resized_Dog6_2.jpg -L Cats_and_Dogs -T 2020-09-24T05:31:40+00:00 ./Augmentation_py 
job_ec=$?
pegasus_lite_section_end task_execute
set -e
pegasus_lite_section_start stage_out
pegasus_lite_section_end stage_out

set -e


# clear the trap, and exit cleanly
trap - EXIT
pegasus_lite_final_exit

