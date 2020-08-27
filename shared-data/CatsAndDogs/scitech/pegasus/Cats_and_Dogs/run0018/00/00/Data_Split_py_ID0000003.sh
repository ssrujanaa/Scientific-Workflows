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
if [ ! -x Data_Split_py ]; then
    /bin/chmod +x Data_Split_py
fi

printf "\n##################### Checking file integrity for input files #####################\n"  1>&2
# do file integrity checks
pegasus-integrity --print-timings --verify=stdin 1>&2 << 'eof'
Aug_resized_Cat94_0.jpg:Aug_resized_Dog90_1.jpg:Aug_resized_Dog34_0.jpg:Aug_resized_Cat77_2.jpg:Aug_resized_Cat37_2.jpg:Aug_resized_Cat54_0.jpg:Aug_resized_Dog74_0.jpg:Aug_resized_Dog21_0.jpg:Aug_resized_Cat24_2.jpg:Aug_resized_Cat6_0.jpg:Aug_resized_Dog61_0.jpg:Aug_resized_Cat30_1.jpg:Aug_resized_Cat70_1.jpg:Aug_resized_Cat48_1.jpg:Aug_resized_Cat83_1.jpg:Aug_resized_Cat11_2.jpg:Aug_resized_Dog97_2.jpg:Aug_resized_Dog17_2.jpg:Aug_resized_Dog57_2.jpg:Aug_resized_Cat27_0.jpg:Aug_resized_Dog28_1.jpg:Aug_resized_Dog68_1.jpg:Aug_resized_Dog84_2.jpg:Aug_resized_Dog44_2.jpg:Aug_resized_Dog76_1.jpg:Aug_resized_Cat96_1.jpg:Aug_resized_Cat67_0.jpg:Aug_resized_Cat35_1.jpg:Aug_resized_Cat64_2.jpg:Aug_resized_Dog10_1.jpg:Aug_resized_Cat72_2.jpg:Aug_resized_Cat59_0.jpg:Aug_resized_Cat19_0.jpg:Aug_resized_Dog50_1.jpg:Aug_resized_Dog5_0.jpg:Aug_resized_Cat41_0.jpg:Aug_resized_Cat81_0.jpg:Aug_resized_Cat46_0.jpg:Aug_resized_Dog42_1.jpg:Aug_resized_Cat85_2.jpg:Aug_resized_Dog82_0.jpg:Aug_resized_Cat32_2.jpg:Aug_resized_Cat99_0.jpg:Aug_resized_Cat29_2.jpg:Aug_resized_Dog82_1.jpg:Aug_resized_Cat62_0.jpg:Aug_resized_Dog52_2.jpg:Aug_resized_Dog89_1.jpg:Aug_resized_Cat69_2.jpg:Aug_resized_Dog12_2.jpg:Aug_resized_Cat8_2.jpg:Aug_resized_Cat22_0.jpg:Aug_resized_Dog49_1.jpg:Aug_resized_Dog92_2.jpg:Aug_resized_Cat16_2.jpg:Aug_resized_Dog53_0.jpg:Aug_resized_Cat51_2.jpg:Aug_resized_Cat91_2.jpg:Aug_resized_Cat56_2.jpg:Aug_resized_Dog13_0.jpg:Aug_resized_Cat88_1.jpg:Aug_resized_Cat75_0.jpg:Aug_resized_Cat43_1.jpg:Aug_resized_Dog71_1.jpg:Aug_resized_Cat3_2.jpg:Aug_resized_Dog40_0.jpg:Aug_resized_Dog23_2.jpg:Aug_resized_Cat45_2.jpg:Aug_resized_Dog0_0.jpg:Aug_resized_Dog87_0.jpg:Aug_resized_Dog63_2.jpg:Aug_resized_Cat86_0.jpg:Aug_resized_Dog55_1.jpg:Aug_resized_Dog95_1.jpg:Aug_resized_Dog15_1.jpg:Aug_resized_Dog47_0.jpg:Aug_resized_Dog20_2.jpg:Aug_resized_Cat24_1.jpg:Aug_resized_Cat14_1.jpg:Aug_resized_Cat80_2.jpg:Aug_resized_Cat30_2.jpg:Aug_resized_Cat38_0.jpg:Aug_resized_Dog50_2.jpg:Aug_resized_Cat83_2.jpg:Aug_resized_Dog90_0.jpg:Aug_resized_Dog57_1.jpg:Aug_resized_Dog87_1.jpg:Aug_resized_Dog7_2.jpg:Aug_resized_Dog28_0.jpg:Aug_resized_Cat53_2.jpg:Aug_resized_Dog84_1.jpg:Aug_resized_Dog58_0.jpg:Aug_resized_Dog34_1.jpg:Aug_resized_Cat70_0.jpg:Aug_resized_Cat35_0.jpg:Aug_resized_Cat65_0.jpg:Aug_resized_Dog61_1.jpg:Aug_resized_Cat12_0.jpg:Aug_resized_Dog36_2.jpg:Aug_resized_Cat73_0.jpg:Aug_resized_Dog59_2.jpg:Aug_resized_Dog5_1.jpg:Aug_resized_Cat88_0.jpg:Aug_resized_Dog10_0.jpg:Aug_resized_Cat81_1.jpg:Aug_resized_Dog85_0.jpg:Aug_resized_Cat18_2.jpg:Aug_resized_Cat98_2.jpg:Aug_resized_Dog68_2.jpg:Aug_resized_Cat19_1.jpg:Aug_resized_Cat67_1.jpg:Aug_resized_Cat1_1.jpg:Aug_resized_Cat96_0.jpg:Aug_resized_Dog73_2.jpg:Data_Split_py:Aug_resized_Dog79_0.jpg:Aug_resized_Dog3_0.jpg:Aug_resized_Dog12_1.jpg:Aug_resized_Cat69_1.jpg:Aug_resized_Dog9_2.jpg:Aug_resized_Dog26_0.jpg:Aug_resized_Dog15_2.jpg:Aug_resized_Cat1_0.jpg:Aug_resized_Cat16_1.jpg:Aug_resized_Dog49_0.jpg:Aug_resized_Dog95_2.jpg:Aug_resized_Dog65_2.jpg:Aug_resized_Dog42_2.jpg:Aug_resized_Cat46_1.jpg:Aug_resized_Cat75_1.jpg:Aug_resized_Dog36_1.jpg:Aug_resized_Cat98_1.jpg:Aug_resized_Cat26_2.jpg:Aug_resized_Dog94_2.jpg:Aug_resized_Dog7_1.jpg:Aug_resized_Cat20_0.jpg:Aug_resized_Cat5_2.jpg:Aug_resized_Cat45_1.jpg:Aug_resized_Dog55_0.jpg:Aug_resized_Dog89_2.jpg:Aug_resized_Dog63_1.jpg:Aug_resized_Cat51_1.jpg:Aug_resized_Cat48_2.jpg:Aug_resized_Dog71_2.jpg:Aug_resized_Cat3_1.jpg:Aug_resized_Cat43_0.jpg:Aug_resized_Dog32_0.jpg:Aug_resized_Dog92_1.jpg:Aug_resized_Cat14_0.jpg:Aug_resized_Dog38_2.jpg:Aug_resized_Cat22_1.jpg:Aug_resized_Dog40_1.jpg:Aug_resized_Dog80_1.jpg:Aug_resized_Cat47_2.jpg:Aug_resized_Cat84_0.jpg:Aug_resized_Dog64_0.jpg:Aug_resized_Cat27_2.jpg:Aug_resized_Dog24_0.jpg:Aug_resized_Cat87_2.jpg:Aug_resized_Dog11_0.jpg:Aug_resized_Dog8_0.jpg:Aug_resized_Cat34_2.jpg:Aug_resized_Dog31_0.jpg:Aug_resized_Cat77_0.jpg:Aug_resized_Cat40_1.jpg:Aug_resized_Dog34_2.jpg:Aug_resized_Cat80_1.jpg:Aug_resized_Cat93_1.jpg:Aug_resized_Dog67_2.jpg:Aug_resized_Dog27_2.jpg:Aug_resized_Cat38_1.jpg:Aug_resized_Dog87_2.jpg:Aug_resized_Cat18_1.jpg:Aug_resized_Cat41_2.jpg:Aug_resized_Dog13_1.jpg:Aug_resized_Cat78_1.jpg:Aug_resized_Dog71_0.jpg:Aug_resized_Dog41_2.jpg:Aug_resized_Dog21_2.jpg:Aug_resized_Dog33_1.jpg:Aug_resized_Dog81_2.jpg:Aug_resized_Cat24_0.jpg:Aug_resized_Dog73_1.jpg:Aug_resized_Cat1_2.jpg:Aug_resized_Dog17_0.jpg:Aug_resized_Cat16_0.jpg:Aug_resized_Dog65_1.jpg:Aug_resized_Dog85_1.jpg:Aug_resized_Dog77_0.jpg:Aug_resized_Dog25_1.jpg:Aug_resized_Dog57_0.jpg:Aug_resized_Dog32_1.jpg:Aug_resized_Dog72_1.jpg:Aug_resized_Cat39_2.jpg:Aug_resized_Cat26_1.jpg:Aug_resized_Cat32_1.jpg:Aug_resized_Dog35_2.jpg:Aug_resized_Cat23_0.jpg:Aug_resized_Dog69_0.jpg:Aug_resized_Dog75_2.jpg:Aug_resized_Dog76_0.jpg:Aug_resized_Dog19_2.jpg:Aug_resized_Dog22_2.jpg:Aug_resized_Cat92_0.jpg:Aug_resized_Dog9_1.jpg:Aug_resized_Dog26_1.jpg:Aug_resized_Cat79_2.jpg:Aug_resized_Dog23_0.jpg:Aug_resized_Cat85_0.jpg:Aug_resized_Dog79_1.jpg:Aug_resized_Cat46_2.jpg:Aug_resized_Cat0_1.jpg:Aug_resized_Dog74_2.jpg:Aug_resized_Cat17_0.jpg:Aug_resized_Dog63_0.jpg:Aug_resized_Cat25_1.jpg:Aug_resized_Dog66_1.jpg:Aug_resized_Dog78_1.jpg:Aug_resized_Dog7_0.jpg:Aug_resized_Cat33_2.jpg:Aug_resized_Cat28_2.jpg:Aug_resized_Cat37_1.jpg:Aug_resized_Dog12_0.jpg:Aug_resized_Cat94_1.jpg:Aug_resized_Dog20_1.jpg:Aug_resized_Cat29_0.jpg:Aug_resized_Cat69_0.jpg:Aug_resized_Dog86_2.jpg:Aug_resized_Cat77_1.jpg:Aug_resized_Cat91_0.jpg:Aug_resized_Dog67_1.jpg:Aug_resized_Dog30_2.jpg:Aug_resized_Cat34_1.jpg:Aug_resized_Cat87_1.jpg:Aug_resized_Cat50_2.jpg:Aug_resized_Cat40_2.jpg:Aug_resized_Cat2_2.jpg:Aug_resized_Cat28_0.jpg:Aug_resized_Cat93_2.jpg:Aug_resized_Cat18_0.jpg:Aug_resized_Dog80_0.jpg:Aug_resized_Dog17_1.jpg:Aug_resized_Dog77_1.jpg:Aug_resized_Dog70_0.jpg:Aug_resized_Cat78_0.jpg:Aug_resized_Cat90_0.jpg:Aug_resized_Dog74_1.jpg:Aug_resized_Dog18_0.jpg:Aug_resized_Cat80_0.jpg:Aug_resized_Dog24_1.jpg:Aug_resized_Dog21_1.jpg:Aug_resized_Cat96_2.jpg:Aug_resized_Dog31_1.jpg:Aug_resized_Cat25_0.jpg:Aug_resized_Cat86_2.jpg:Aug_resized_Dog9_0.jpg:Aug_resized_Dog73_0.jpg:Aug_resized_Dog68_0.jpg:Aug_resized_Cat30_0.jpg:Aug_resized_Dog65_0.jpg:Aug_resized_Dog79_2.jpg:Aug_resized_Cat43_2.jpg:Aug_resized_Cat41_1.jpg:Aug_resized_Cat38_2.jpg:Aug_resized_Dog22_0.jpg:Aug_resized_Cat33_0.jpg:Aug_resized_Dog90_2.jpg:Aug_resized_Cat84_1.jpg:Aug_resized_Cat35_2.jpg:Aug_resized_Cat27_1.jpg:Aug_resized_Dog76_2.jpg:Aug_resized_Dog28_2.jpg:Aug_resized_Cat76_0.jpg:Aug_resized_Dog33_2.jpg:Aug_resized_Cat95_2.jpg:Aug_resized_Dog19_1.jpg:Aug_resized_Dog22_1.jpg:Aug_resized_Cat92_1.jpg:Aug_resized_Cat79_1.jpg:Aug_resized_Dog16_0.jpg:Aug_resized_Cat29_1.jpg:Aug_resized_Dog25_2.jpg:Aug_resized_Cat85_1.jpg:Aug_resized_Cat0_2.jpg:Aug_resized_Cat82_0.jpg:Aug_resized_Dog32_2.jpg:Aug_resized_Dog66_0.jpg:Aug_resized_Cat89_2.jpg:Aug_resized_Cat36_2.jpg:Aug_resized_Dog82_2.jpg:Aug_resized_Cat32_0.jpg:Aug_resized_Dog81_1.jpg:Aug_resized_Cat33_1.jpg:Aug_resized_Dog69_1.jpg:Aug_resized_Dog26_2.jpg:Aug_resized_Dog18_1.jpg:Aug_resized_Dog31_2.jpg:Aug_resized_Cat83_0.jpg:Aug_resized_Cat86_1.jpg:Aug_resized_Dog20_0.jpg:Aug_resized_Cat94_2.jpg:Aug_resized_Dog23_1.jpg:Aug_resized_Dog15_0.jpg:Aug_resized_Cat88_2.jpg:Aug_resized_Cat91_1.jpg:Aug_resized_Dog78_2.jpg:Aug_resized_Dog75_1.jpg:Aug_resized_Cat42_2.jpg:Aug_resized_Dog72_0.jpg:Aug_resized_Cat31_0.jpg:Aug_resized_Cat26_0.jpg:Aug_resized_Dog83_2.jpg:Aug_resized_Dog67_0.jpg:Aug_resized_Dog54_0.jpg:Aug_resized_Dog70_1.jpg:Aug_resized_Cat9_2.jpg:Aug_resized_Cat74_0.jpg:Aug_resized_Cat57_2.jpg:Aug_resized_Cat17_2.jpg:Aug_resized_Cat90_1.jpg:Aug_resized_Dog14_0.jpg:Aug_resized_Dog94_0.jpg:Aug_resized_Dog1_1.jpg:Aug_resized_Cat50_1.jpg:Aug_resized_Dog41_0.jpg:Aug_resized_Cat44_2.jpg:Aug_resized_Dog77_2.jpg:Aug_resized_Cat87_0.jpg:Aug_resized_Dog24_2.jpg:Aug_resized_Cat10_1.jpg:Aug_resized_Dog37_2.jpg:Aug_resized_Cat2_1.jpg:Aug_resized_Cat68_1.jpg:Aug_resized_Cat28_1.jpg:Aug_resized_Dog48_1.jpg:Aug_resized_Cat15_1.jpg:Aug_resized_Dog96_1.jpg:Aug_resized_Dog64_2.jpg:Aug_resized_Dog56_1.jpg:Aug_resized_Cat7_1.jpg:Aug_resized_Cat47_0.jpg:Aug_resized_Cat84_2.jpg:Aug_resized_Cat55_1.jpg:Aug_resized_Cat76_1.jpg:Aug_resized_Dog8_2.jpg:Aug_resized_Cat92_2.jpg:Aug_resized_Dog88_1.jpg:Aug_resized_Cat39_0.jpg:Aug_resized_Cat52_2.jpg:Aug_resized_Cat79_0.jpg:Aug_resized_Dog30_1.jpg:Aug_resized_Cat21_0.jpg:Aug_resized_Cat4_2.jpg:Aug_resized_Cat61_0.jpg:Aug_resized_Cat82_1.jpg:Aug_resized_Cat89_1.jpg:Aug_resized_Cat49_1.jpg:Aug_resized_Cat42_1.jpg:Aug_resized_Dog91_2.jpg:Aug_resized_Dog99_0.jpg:Aug_resized_Dog59_0.jpg:Aug_resized_Dog19_0.jpg:Aug_resized_Cat36_1.jpg:Aug_resized_Dog45_2.jpg:Aug_resized_Dog85_2.jpg:Aug_resized_Dog16_1.jpg:Aug_resized_Dog6_0.jpg:Aug_resized_Dog29_2.jpg:Aug_resized_Cat95_1.jpg:Aug_resized_Dog86_0.jpg:Aug_resized_Dog46_0.jpg:Aug_resized_Cat40_0.jpg:Aug_resized_Dog69_2.jpg:Aug_resized_Dog81_0.jpg:Aug_resized_Dog43_1.jpg:Aug_resized_Dog51_2.jpg:Aug_resized_Dog75_0.jpg:Aug_resized_Dog11_2.jpg:Aug_resized_Dog35_0.jpg:Aug_resized_Cat71_1.jpg:Aug_resized_Dog83_1.jpg:Aug_resized_Cat31_1.jpg:Aug_resized_Dog58_2.jpg:Aug_resized_Dog80_2.jpg:Aug_resized_Cat34_0.jpg:Aug_resized_Cat97_2.jpg:Aug_resized_Cat10_2.jpg:Aug_resized_Dog18_2.jpg:Aug_resized_Dog98_2.jpg:Aug_resized_Cat60_2.jpg:Aug_resized_Dog93_2.jpg:Aug_resized_Cat97_1.jpg:Aug_resized_Cat44_1.jpg:Aug_resized_Cat90_2.jpg:Aug_resized_Dog14_1.jpg:Aug_resized_Dog27_1.jpg:Aug_resized_Dog70_2.jpg:Aug_resized_Dog40_2.jpg:Aug_resized_Cat58_0.jpg:Aug_resized_Dog37_1.jpg:Aug_resized_Dog60_0.jpg:Aug_resized_Dog64_1.jpg:Aug_resized_Cat68_0.jpg:Aug_resized_Dog48_0.jpg:Aug_resized_Dog94_1.jpg:Aug_resized_Dog11_1.jpg:Aug_resized_Cat45_0.jpg:Aug_resized_Cat15_0.jpg:Aug_resized_Dog1_0.jpg:Aug_resized_Dog25_0.jpg:Aug_resized_Cat2_0.jpg:Aug_resized_Dog41_1.jpg:Aug_resized_Dog16_2.jpg:Aug_resized_Cat50_0.jpg:Aug_resized_Dog30_0.jpg:labels.txt:Aug_resized_Cat23_2.jpg:Aug_resized_Cat78_2.jpg:Aug_resized_Cat93_0.jpg:Aug_resized_Cat21_1.jpg:Aug_resized_Cat47_1.jpg:Aug_resized_Cat7_2.jpg:Aug_resized_Dog96_2.jpg:Aug_resized_Dog8_1.jpg:Aug_resized_Cat55_2.jpg:Aug_resized_Dog88_2.jpg:Aug_resized_Dog62_0.jpg:Aug_resized_Dog13_2.jpg:Aug_resized_Dog29_1.jpg:Aug_resized_Dog6_1.jpg:Aug_resized_Cat36_0.jpg:Aug_resized_Cat19_2.jpg:Aug_resized_Cat52_1.jpg:Aug_resized_Cat39_1.jpg:Aug_resized_Dog62_1.jpg:Aug_resized_Cat13_0.jpg:Aug_resized_Cat4_1.jpg:Aug_resized_Dog39_2.jpg:Aug_resized_Cat42_0.jpg:Aug_resized_Dog56_0.jpg:Aug_resized_Dog72_2.jpg:Aug_resized_Cat72_0.jpg:Aug_resized_Cat49_2.jpg:Aug_resized_Cat99_2.jpg:Aug_resized_Dog33_0.jpg:Aug_resized_Dog91_1.jpg:Aug_resized_Cat81_2.jpg:Aug_resized_Dog59_1.jpg:Aug_resized_Cat23_1.jpg:Aug_resized_Cat95_0.jpg:Aug_resized_Dog86_1.jpg:Aug_resized_Cat76_2.jpg:Aug_resized_Cat31_2.jpg:Aug_resized_Dog83_0.jpg:Aug_resized_Cat37_0.jpg:Aug_resized_Dog58_1.jpg:Aug_resized_Dog78_0.jpg:Aug_resized_Dog66_2.jpg:Aug_resized_Dog4_0.jpg:Aug_resized_Cat25_2.jpg:Aug_resized_Cat82_2.jpg:Aug_resized_Cat17_1.jpg:Aug_resized_Cat0_0.jpg:Aug_resized_Cat89_0.jpg:Aug_resized_Cat74_1.jpg:Aug_resized_Cat66_0.jpg:Aug_resized_Dog43_2.jpg:Aug_resized_Cat71_0.jpg:Aug_resized_Dog27_0.jpg:Aug_resized_Dog35_1.jpg:Aug_resized_Cat11_0.jpg:Aug_resized_Dog44_0.jpg:Aug_resized_Cat3_0.jpg:Aug_resized_Cat67_2.jpg:Aug_resized_Dog84_0.jpg:Aug_resized_Cat44_0.jpg:Aug_resized_Cat14_2.jpg:Aug_resized_Cat64_0.jpg:Aug_resized_Cat6_2.jpg:Aug_resized_Dog51_0.jpg:Aug_resized_Cat54_2.jpg:Aug_resized_Cat97_0.jpg:Aug_resized_Dog4_1.jpg:Aug_resized_Dog0_2.jpg:Aug_resized_Cat20_1.jpg:Aug_resized_Dog14_2.jpg:Aug_resized_Cat60_1.jpg:Aug_resized_Dog47_2.jpg:Aug_resized_Cat21_2.jpg:Aug_resized_Cat73_1.jpg:Aug_resized_Cat58_1.jpg:Aug_resized_Cat53_1.jpg:Aug_resized_Dog2_0.jpg:Aug_resized_Cat5_1.jpg:Aug_resized_Dog53_1.jpg:Aug_resized_Dog91_0.jpg:Aug_resized_Dog93_1.jpg:Aug_resized_Dog61_2.jpg:Aug_resized_Cat12_1.jpg:Aug_resized_Dog45_1.jpg:Aug_resized_Dog97_0.jpg:Aug_resized_Dog37_0.jpg:Aug_resized_Cat8_0.jpg:Aug_resized_Dog92_0.jpg:Aug_resized_Cat72_1.jpg:Aug_resized_Cat56_0.jpg:Aug_resized_Cat22_2.jpg:Aug_resized_Cat75_2.jpg:Aug_resized_Cat59_1.jpg:Aug_resized_Cat99_1.jpg:Aug_resized_Dog29_0.jpg:Aug_resized_Cat66_1.jpg:Aug_resized_Cat65_1.jpg:Aug_resized_Dog62_2.jpg:Aug_resized_Cat52_0.jpg:Aug_resized_Cat4_0.jpg:Aug_resized_Dog36_0.jpg:Aug_resized_Dog5_2.jpg:Aug_resized_Cat13_1.jpg:Aug_resized_Dog39_1.jpg:Aug_resized_Cat61_2.jpg:Aug_resized_Dog38_1.jpg:Aug_resized_Dog46_2.jpg:Aug_resized_Cat9_0.jpg:Aug_resized_Dog98_0.jpg:Aug_resized_Cat57_0.jpg:Aug_resized_Cat98_0.jpg:Aug_resized_Cat74_2.jpg:Aug_resized_Cat63_0.jpg:Aug_resized_Cat68_2.jpg:Aug_resized_Dog3_1.jpg:Aug_resized_Cat51_0.jpg:Aug_resized_Cat62_2.jpg:Aug_resized_Cat54_1.jpg:Aug_resized_Dog52_0.jpg:Aug_resized_Dog60_1.jpg:Aug_resized_Dog6_2.jpg:Aug_resized_Dog4_2.jpg:Aug_resized_Cat6_1.jpg:Aug_resized_Dog10_2.jpg:Aug_resized_Cat70_2.jpg:Aug_resized_Cat20_2.jpg:Aug_resized_Dog60_2.jpg:Aug_resized_Dog47_1.jpg:Aug_resized_Cat11_1.jpg:Aug_resized_Cat48_0.jpg:Aug_resized_Dog97_1.jpg:Aug_resized_Dog54_1.jpg:Aug_resized_Cat63_2.jpg:Aug_resized_Cat73_2.jpg:Aug_resized_Dog44_1.jpg:Aug_resized_Dog38_0.jpg:Aug_resized_Cat7_0.jpg:Aug_resized_Dog93_0.jpg:Aug_resized_Cat66_2.jpg:Aug_resized_Dog99_2.jpg:Aug_resized_Dog56_2.jpg:Aug_resized_Cat10_0.jpg:Aug_resized_Dog88_0.jpg:Aug_resized_Cat61_1.jpg:Aug_resized_Dog2_1.jpg:Aug_resized_Dog45_0.jpg:Aug_resized_Dog50_0.jpg:Aug_resized_Cat53_0.jpg:Aug_resized_Cat58_2.jpg:Aug_resized_Dog1_2.jpg:Aug_resized_Cat15_2.jpg:Aug_resized_Dog48_2.jpg:Aug_resized_Cat5_0.jpg:Aug_resized_Dog42_0.jpg:Aug_resized_Cat64_1.jpg:Aug_resized_Dog53_2.jpg:Aug_resized_Cat12_2.jpg:Aug_resized_Dog52_1.jpg:Aug_resized_Cat62_1.jpg:Aug_resized_Dog39_0.jpg:Aug_resized_Cat8_1.jpg:Aug_resized_Dog89_0.jpg:Aug_resized_Dog55_2.jpg:Aug_resized_Cat56_1.jpg:Aug_resized_Dog99_1.jpg:Aug_resized_Dog96_0.jpg:Aug_resized_Dog46_1.jpg:Aug_resized_Cat59_2.jpg:Aug_resized_Cat71_2.jpg:Aug_resized_Dog43_0.jpg:Aug_resized_Dog2_2.jpg:Aug_resized_Cat63_1.jpg:Aug_resized_Dog51_1.jpg:Aug_resized_Cat55_0.jpg:Aug_resized_Dog54_2.jpg:Aug_resized_Cat13_2.jpg:Aug_resized_Dog0_1.jpg:Aug_resized_Cat60_0.jpg:Aug_resized_Dog3_2.jpg:Aug_resized_Dog49_2.jpg:Aug_resized_Cat49_0.jpg:Aug_resized_Cat9_1.jpg:Aug_resized_Dog95_0.jpg:Aug_resized_Dog98_1.jpg:Aug_resized_Cat57_1.jpg:Aug_resized_Cat65_2.jpg
eof

pegasus_lite_section_end stage_in
set +e
job_ec=0
pegasus_lite_section_start task_execute
printf "\n######################[Pegasus Lite] Executing the user task ######################\n"  1>&2
pegasus-kickstart  -n Data_Split.py -N ID0000003 -R condorpool  -s testing.pkl=testing.pkl -s validation.pkl=validation.pkl -s training.pkl=training.pkl -L Cats_and_Dogs -T 2020-08-25T16:42:33+00:00 ./Data_Split_py 
job_ec=$?
pegasus_lite_section_end task_execute
set -e
pegasus_lite_section_start stage_out
pegasus_lite_section_end stage_out

set -e


# clear the trap, and exit cleanly
trap - EXIT
pegasus_lite_final_exit

