#!/bin/bash
set -euo pipefail

tasknames=(
  "0b_demo_data_i9"
  "3a_ig_gsd_i9_nocut_filter" 
  "3b_ig_gsd_i9_nocut_filter_Run2"
  "3c_ig_gsd_i9_nocut_filter_Run3"
)

echo "Working directory: $(pwd)"
echo "Running on host: $(hostname)"
echo "SLURM_JOB_ID: ${SLURM_JOB_ID:-none}"
echo "SLURM_NODELIST: ${SLURM_NODELIST:-none}"
echo "Starting all tasks at: $(date)"
echo "Number of tasks: ${#tasknames[@]}"
echo

for ((taskid=0; taskid<${#tasknames[@]}; taskid++)); do
  TASK_NAME="${tasknames[$taskid]}"

  NOTEBOOK="${TASK_NAME}.ipynb"
  OUTPUT="${TASK_NAME}.executed.ipynb"
  LOGFILE="${TASK_NAME}.log"

  echo "============================================================"
  echo "Task id: ${taskid}"
  echo "Task name: ${TASK_NAME}"
  echo "Notebook: ${NOTEBOOK}"
  echo "Output notebook: ${OUTPUT}"
  echo "Log file: ${LOGFILE}"
  echo "Starting task ${taskid} at: $(date)"
  echo "============================================================"

  if [ ! -f "${NOTEBOOK}" ]; then
    echo "ERROR: Notebook not found: ${NOTEBOOK}"
    exit 1
  fi

  # Delete only the previous output notebook if it exists
  if [ -f "${OUTPUT}" ]; then
    echo "Existing output found, deleting: ${OUTPUT}"
    rm -f "${OUTPUT}"
  fi

  # Delete only the previous log file if it exists
  if [ -f "${LOGFILE}" ]; then
    echo "Existing log found, deleting: ${LOGFILE}"
    rm -f "${LOGFILE}"
  fi

  papermill "${NOTEBOOK}" "${OUTPUT}" --log-output 2>&1 | tee "${LOGFILE}"

  echo "Finished task id ${taskid} at: $(date)"
  echo "Output notebook:"
  ls -lh "${OUTPUT}"
  echo
done

echo "============================================================"
echo "All tasks finished at: $(date)"
echo "============================================================"
