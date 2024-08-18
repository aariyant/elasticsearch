#/bin/bash

file=$1
es_url=$2
index=$3
if [[ -z $1 ]]; then echo "Error: JSON file not found" && exit 1; fi
if [[ -z $2 ]]; then echo "Error: Elasticsearch URL is empty" && exit 1; fi
if [[ -z $3 ]]; then echo "Error: Elasticsearch Index is empty" && exit 1; fi

if [[ ! -e $file ]]; then
    echo "Error: couldn't find $1"
    exit 1
fi

# cat $file | jq -c '. | {"index": {"_index": "'"$index"'"}}, .'
cat $file | jq -c '. | {"index": {"_index": "'"$index"'"}}, .' | curl -XPOST "$es_url/$index/_doc/_bulk?pretty" -H "Content-Type: application/json" --data-binary @-