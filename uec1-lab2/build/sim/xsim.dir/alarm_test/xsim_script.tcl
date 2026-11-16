set_param project.enableReportConfiguration 0
load_feature core
current_fileset
xsim {alarm_test} -autoloadwcfg -tclbatch {/home/student/ksolecki/Desktop/code/uec1-lab2/sim/alarm/commands.tcl}
