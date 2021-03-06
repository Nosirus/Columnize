#!/bin/bash
# columnize.sh

# Take a list of values and output them in a nicely formatted column view.

# Author: Loïc Cattani "Arko" <loic cattani at gmail com>

values=($*)
longest_value=0

# Find the longest value
for value in ${values[@]}
do
  if [[ ${#value} -gt $longest_value ]]; then
    longest_value=${#value}
  fi
done

# Compute column span
term_width=$(tput cols)
(( columns = $term_width / ($longest_value + 2) ))

# Print values with pretty column width
curr_col=0
for value in ${values[@]}
do
  value_len=${#value}
  echo -n $value
  (( spaces_missing = $longest_value - $value_len + 2 ))
  printf "%*s" $spaces_missing
  (( curr_col++ ))
  if [[ $curr_col == $columns ]]; then
    echo
    curr_col=0
  fi
done

# Make sure there is a newline at the end
if [[ $curr_col != 0 ]]; then
  echo
fi
