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
pegasus_lite_setup_work_dir

printf "\n##############[Pegasus Lite] Figuring out the worker package to use ##############\n"  1>&2
# figure out the worker package to use
pegasus_lite_worker_package

pegasus_lite_section_start stage_in
printf "\n###################### Staging in input data and executables ######################\n"  1>&2
# stage in data and executables
pegasus-transfer --threads 1  1>&2 << 'eof'
[
 { "type": "transfer",
   "linkage": "input",
   "lfn": "dog_sounds.txt",
   "id": 1,
   "src_urls": [
     { "site_label": "stage", "url": "file:///tmp//scitech/pegasus/nested-dir-tutorial/run0001/00/00/dog_sounds.txt", "checkpoint": "false" }
   ],
   "dest_urls": [
     { "site_label": "condorpool", "url": "file://$PWD/dog_sounds.txt" }
   ] }
 ,
 { "type": "transfer",
   "linkage": "input",
   "lfn": "print_file_contents",
   "id": 2,
   "src_urls": [
     { "site_label": "stage", "url": "file:///tmp//scitech/pegasus/nested-dir-tutorial/run0001/00/00/print_file_contents", "checkpoint": "false" }
   ],
   "dest_urls": [
     { "site_label": "condorpool", "url": "file://$PWD/print_file_contents" }
   ] }
 ,
 { "type": "transfer",
   "linkage": "input",
   "lfn": "cat_sounds.txt",
   "id": 3,
   "src_urls": [
     { "site_label": "stage", "url": "file:///tmp//scitech/pegasus/nested-dir-tutorial/run0001/00/00/cat_sounds.txt", "checkpoint": "false" }
   ],
   "dest_urls": [
     { "site_label": "condorpool", "url": "file://$PWD/cat_sounds.txt" }
   ] }
]
eof

printf "\n##################### Setting the xbit for executables staged #####################\n"  1>&2
# set the xbit for any executables staged
if [ ! -x print_file_contents ]; then
    /bin/chmod +x print_file_contents
fi

printf "\n##################### Checking file integrity for input files #####################\n"  1>&2
# do file integrity checks
pegasus-integrity --print-timings --verify=stdin 1>&2 << 'eof'
dog_sounds.txt:print_file_contents:cat_sounds.txt
eof

pegasus_lite_section_end stage_in
set +e
job_ec=0
pegasus_lite_section_start task_execute
printf "\n######################[Pegasus Lite] Executing the user task ######################\n"  1>&2
pegasus-kickstart  -n print_file_contents -N ID0000001 -o out.txt -R condorpool  -s out.txt=out.txt -L nested-dir-tutorial -T 2020-07-23T16:56:10+00:00 ./print_file_contents 
job_ec=$?
pegasus_lite_section_end task_execute
set -e
pegasus_lite_section_start stage_out
printf "\n############################ Staging out output files ############################\n"  1>&2
# stage out
pegasus-transfer --threads 1  1>&2 << 'eof'
[
 { "type": "transfer",
   "linkage": "output",
   "lfn": "",
   "id": 1,
   "src_urls": [
     { "site_label": "condorpool", "url": "file://$PWD/out.txt", "checkpoint": "false" }
   ],
   "dest_urls": [
     { "site_label": "stage", "url": "file:///tmp//scitech/pegasus/nested-dir-tutorial/run0001/00/00/out.txt" }
   ] }
]
eof

pegasus_lite_section_end stage_out

set -e


# clear the trap, and exit cleanly
trap - EXIT
pegasus_lite_final_exit

