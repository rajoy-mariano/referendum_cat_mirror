#!/bin/bash

export db_url_prefix=https://onvotar.garantiespelreferendum.com/db.20170930
hex_values=`printf "%02x " {0..255}`
download_list=download_list.txt
parallel_downloads=50

function check_md5() {
  local file=$1
  local file_url=${db_url_prefix}/${file}
  echo -n "Checking if file ${file} needs to be updated ... "
  origin_md5=`curl -s ${file_url} -o- | md5sum | awk '{print $1}'`
  dest_md5=`md5sum ${file} | awk '{print $1}'`
  if [ ${origin_md5} == ${dest_md5} ]; then
    return 0
  fi
  return 1
}

export -f check_md5

function download_db() {
  local file=$1
  local file_url=${db_url_prefix}/${file}
  echo "Downloading file ${file_url} into ${file} ..."

  if [ ! -e ${file} ]; then
    curl -s ${file_url} -o ${file}
  elif [ `wc -l ${file} | awk '{print $1}'` -eq 0 ]; then
    rm -f ${file}
    curl -s ${file_url} -o ${file}
  elif grep "Connection timed out" ${file} >/dev/null; then
    rm -f ${file}
    curl -s ${file_url} -o ${file}
  elif ! check_md5 ${file}; then
    echo "Updating file ${file} ..."
    rm -f ${file}
    curl -s ${file_url} -o ${file}
  fi
}

export -f download_db

echo -n > ${download_list}
for folder in ${hex_values}; do
  for file in ${hex_values}; do
    echo ${folder}/${file}.db >> ${download_list}
  done
done

cat ${download_list} | parallel -j ${parallel_downloads} download_db {}
