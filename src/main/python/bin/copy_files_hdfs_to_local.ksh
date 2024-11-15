############################################################
# Developed By:      Ajith S                               #
# Developed Date:    15/01/2024                            #
# Script NAME:       copy_files_hdfs_to_local.ksh          #
# PURPOSE: Copy output  files from HDFS to LOCAL.          #
############################################################

# Declare a variable to hold the unix script name.
JOBNAME="copy_files_hdfs_to_local.ksh"

# Declare a variable to hold the current date
date=$(date '+%Y-%m-%d_%H:%M:%S')

# Define a Log File where lpgs would be generated
LOGFILE="/home/hadoop/Projects/US-Prescribers-Report/src/main/python/logs/${JOBNAME}_${date}.log"

###########################################################################
### COMMENTS: From this point on, all standard output and standard error will
###           be logged in the log file.
###########################################################################
{  # <--- Start of the log file.
echo "${JOBNAME} Started...: $(date)"

LOCAL_OUTPUT_PATH="/home/hadoop/Projects/US-Prescribers-Report/src/main/output"
LOCAL_DIM_DIR=${LOCAL_OUTPUT_PATH}/dim
LOCAL_FACT_DIR=${LOCAL_OUTPUT_PATH}/fact

HDFS_OUTPUT_PATH=/user/hadoop/Projects/PrescPipeline/Output
HDFS_DIM_DIR=${HDFS_OUTPUT_PATH}/Dim
HDFS_FACT_DIR=${HDFS_OUTPUT_PATH}/Fact

# Delete the files at local if exists
rm -f ${LOCAL_DIM_DIR}/*
rm -f ${LOCAL_FACT_DIR}/*

# Copy the output dim & fact files from HDFS to LOCAL
hdfs dfs -get -f ${HDFS_DIM_DIR}/* ${LOCAL_DIM_DIR}/
hdfs dfs -get -f ${HDFS_FACT_DIR}/* ${LOCAL_FACT_DIR}/

echo "${JOBNAME} is Completed...: $(date)"
} > ${LOGFILE} 2>&1  #  <--- End of program and end of log.



