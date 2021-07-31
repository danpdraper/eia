#!/bin/bash

function activate_virtual_environment {
  directory_path="$(pwd)"
  while [ -z "$(find $directory_path -maxdepth 1 -type d -name env)" ] && [ ! "$directory_path" = / ] ; do
    directory_path="$(cd $directory_path/.. && pwd)"
  done

  if [ "$directory_path" = / ] ; then
    echo "Failed to locate directory containing env directory in path to $(pwd)"
    exit 1
  fi
  
  source "${directory_path}/env/bin/activate"

  echo 'Activated virtual environment.'
}

function deactivate_virtual_environment {
  deactivate
  echo 'Deactivated virtual environment.'
}
