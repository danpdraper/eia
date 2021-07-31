#!/bin/bash

common_file_path="$(dirname ${BASH_SOURCE[0]})/common.sh"
if [ ! -f "$common_file_path" ] ; then
  echo "Missing file. $common_file_path does not exist."
  exit 1
fi

source "$common_file_path"

deactivate_after_creating_links=false

if [ -z "$VIRTUAL_ENV" ] ; then
  activate_virtual_environment
  deactivate_after_creating_links=true
fi

repository_root_directory_path="$(cd ${VIRTUAL_ENV}/.. && pwd)"

for file_path in "$repository_root_directory_path"/githooks/* ; do
  if [[ ! "$(basename $file_path)" =~ '.' ]] ; then
    symbolic_link_path="${repository_root_directory_path}/.git/hooks/$(basename $file_path)"
    if [ -L "$symbolic_link_path" ] ; then
      echo "Symbolic link $symbolic_link_path already exists; no need to recreate."
      continue
    fi
    echo "Creating symbolic link $symbolic_link_path with target $file_path"
    ln -s "$file_path" "$symbolic_link_path"
  fi
done

if $deactivate_after_creating_links ; then
  deactivate_virtual_environment
fi
