#!/usr/bin/env bash

common_file_path="$(cd "$(dirname $BASH_SOURCE)" && pwd)/legislation/common.sh"
if [ ! -f "$common_file_path" ] ; then
  2>&1 echo "File $common_file_path does not exist."
  exit 1
fi
source "$common_file_path"

enactment_years_file_path="$(cd "$(dirname $BASH_SOURCE)/../raw_data" && pwd)/enactment_years.csv"
if [ ! -f "$enactment_years_file_path" ] ; then
  echo_error "File $enactment_years_file_path does not exist."
  exit 1
fi

if [ "$#" -ne 3 ] ; then
  2>&1 echo "USAGE: $(basename $0) <nodes_file_path> <edges_file_path> <output_directory_path>"
  2>&1 echo "PROVIDED: $(basename $0) $*"
  exit 1
fi
nodes_file_path="$1"
edges_file_path="$2"
output_directory_path="$3"

if [ ! -f "$nodes_file_path" ] ; then
  echo_error "File $nodes_file_path does not exist."
  exit 1
fi

if [ ! -f "$edges_file_path" ] ; then
  echo_error "File $edges_file_path does not exist."
  exit 1
fi

if [ ! -d "$output_directory_path" ] ; then
  echo_error "Directory "$output_directory_path" does not exist."
  exit 1
fi

output_file_path="${output_directory_path}/weighted_degree_by_enactment_year.csv"
echo_info "Writing nodes, weighted degrees and enactment years to ${output_file_path}."

echo 'State,Weighted Degree,Enactment Year' > "$output_file_path"
cat "$nodes_file_path" | while read nodes_line ; do
  if [ 'ID,Label' = "$nodes_line" ] ; then continue ; fi
  node_id="$(echo "$nodes_line" | cut -d',' -f 1)"
  state="$(echo "$nodes_line" | cut -d',' -f 2)"
  weighted_degree=0;
  while read edges_line ; do
    echo_info "Found line $edges_line in $edges_file_path for node $node_id (state ${state})."
    weight="$(echo "$edges_line" | cut -d',' -f 5)"
    echo_info "Adding weight $weight to weighted degree ${weighted_degree}."
    weighted_degree="$(( $weight + $weighted_degree ))"
  done < <(grep ",${node_id}," "$edges_file_path")
  echo_info "Calculated total weighted degree $weighted_degree for ${state}."
  enactment_year="$(grep "^${state}," "$enactment_years_file_path" | cut -d',' -f 2)"
  echo "${state},${weighted_degree},${enactment_year}" >> "$output_file_path"
done 

echo_info "Wrote nodes, weighted degrees and enactment years to ${output_file_path}."
