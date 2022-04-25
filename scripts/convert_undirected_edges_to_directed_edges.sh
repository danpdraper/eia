#!/usr/bin/env bash

common_file_path="$(cd "$(dirname $BASH_SOURCE)" && pwd)/legislation/common.sh"
if [ ! -f "$common_file_path" ] ; then
  2>&1 echo "File $common_file_path does not exist."
  exit 1
fi
source "$common_file_path"

enactment_years_file_path="$(cd "$(dirname $BASH_SOURCE)/../configuration" && pwd)/enactment_years.csv"
if [ ! -f "$enactment_years_file_path" ] ; then
  echo_error "File $enactment_years_file_path does not exist."
  exit 1
fi

if [ "$#" -ne 2 ] ; then
  2>&1 echo "USAGE: $(basename $0) <nodes_file_path> <edges_file_path>"
  2>&1 echo "PROVIDED: $(basename $0) $*"
  exit 1
fi
nodes_file_path="$1"
edges_file_path="$2"

if [ ! -f "$nodes_file_path" ] ; then
  echo_error "File $nodes_file_path does not exist."
  exit 1
fi

if [ ! -f "$edges_file_path" ] ; then
  echo_error "File $edges_file_path does not exist."
  exit 1
fi

edges_file_path_without_suffix="$(echo "$edges_file_path" | cut -d'.' -f 1)"
edges_file_suffix="$(basename "$edges_file_path" | cut -d'.' -f 2)"

directed_edges_file_path="${edges_file_path_without_suffix}_directed.${edges_file_suffix}"
echo_info "Writing directed edges to file ${directed_edges_file_path}."

cat "$edges_file_path" | while read edges_line ; do
  if [ 'ID,Source,Target,Type,Weight' = "$edges_line" ] ; then
    echo "$edges_line" > "$directed_edges_file_path"
    continue
  fi
  edge_id="$(echo "$edges_line" | cut -d',' -f 1)"
  source_node_id="$(echo "$edges_line" | cut -d',' -f 2)"
  target_node_id="$(echo "$edges_line" | cut -d',' -f 3)"
  edge_weight="$(echo "$edges_line" | cut -d',' -f 5)"
  source_node_label="$(grep "^${source_node_id}," "$nodes_file_path" | cut -d',' -f 2)"
  target_node_label="$(grep "^${target_node_id}," "$nodes_file_path" | cut -d',' -f 2)"
  source_node_enactment_year="$(grep "^${source_node_label}," "$enactment_years_file_path" | cut -d',' -f 2)"
  echo_info "Found enactment year $source_node_enactment_year for node ${source_node_label}."
  target_node_enactment_year="$(grep "^${target_node_label}," "$enactment_years_file_path" | cut -d',' -f 2)"
  echo_info "Found enactment year $target_node_enactment_year for node ${target_node_label}."
  if [ "$source_node_enactment_year" -gt "$target_node_enactment_year" ] ; then
    log_message="Swapping source node $source_node_label (${source_node_id}) with enactment year $source_node_enactment_year with "
    log_message+="$target_node_label (${target_node_id}) with enactment year ${target_node_enactment_year}."
    echo_info "$log_message"
    echo "${edge_id},${target_node_id},${source_node_id},Directed,${edge_weight}" >> "$directed_edges_file_path"
  else
    log_message="Not swapping source node $source_node_label (${source_node_id}) with enactment year $source_node_enactment_year "
    log_message+="with $target_node_label (${target_node_id}) with enactment year ${target_node_enactment_year}."
    echo_info "$log_message"
    echo "${edge_id},${source_node_id},${target_node_id},Directed,${edge_weight}" >> "$directed_edges_file_path"
  fi
done

echo_info "Wrote directed edges to file ${directed_edges_file_path}."
