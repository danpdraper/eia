#!/usr/bin/env bash

common_file_path="$(cd "$(dirname $BASH_SOURCE)" && pwd)/legislation/common.sh"
if [ ! -f "$common_file_path" ] ; then
  2>&1 echo "File $common_file_path does not exist."
  exit 1
fi
source "$common_file_path"

country_coordinates_file_path="$(cd "$(dirname $BASH_SOURCE)/../configuration" && pwd)/country_coordinates.csv"
if [ ! -f "$country_coordinates_file_path" ] ; then
  echo_error "File $country_coordinates_file_path does not exist."
  exit 1
fi

if [ "$#" -ne 1 ] ; then
  2>&1 echo "USAGE: $(basename $0) <nodes_file_path>"
  2>&1 echo "PROVIDED: $(basename $0) $*"
  exit 1
fi
nodes_file_path="$1"

if [ ! -f "$nodes_file_path" ] ; then
  echo_error "File $nodes_file_path does not exist."
  exit 1
fi
nodes_file_path_without_suffix="$(echo "$nodes_file_path" | cut -d'.' -f 1)"
nodes_file_suffix="$(basename "$nodes_file_path" | cut -d'.' -f 2)"

nodes_with_coordinates_file_path="${nodes_file_path_without_suffix}_with_coordinates.${nodes_file_suffix}"
echo_info "Writing nodes with coordinates to file ${nodes_with_coordinates_file_path}."

cat "$nodes_file_path" | while read line ; do
  if [ "ID,Label" = "$line" ] ; then
    echo "${line},Latitude,Longitude" > "$nodes_with_coordinates_file_path"
  else
    echo -n "${line}," >> "$nodes_with_coordinates_file_path"
    state="$(echo "$line" | cut -d',' -f 2)"
    echo -n "$(grep -i ",$state$" "$country_coordinates_file_path" | cut -d',' -f 2)," >> "$nodes_with_coordinates_file_path"
    echo "$(grep -i ",$state$" "$country_coordinates_file_path" | cut -d',' -f 3)" >> "$nodes_with_coordinates_file_path"
  fi
done
echo_info "Wrote nodes with coordinates to file ${nodes_with_coordinates_file_path}."
