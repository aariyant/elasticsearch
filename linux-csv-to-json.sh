#!/bin/bash

file=$1
index_name=$2
if [[ -z $1 ]]; then echo "Error: CSV file not found" && exit 1; fi
if [[ -z $2 ]]; then index_name="default"; fi

if [[ ! -e $file ]]; then
    echo "Error: couldn't find $1"
    exit 1
fi

if [[ -f data.json ]]; then rm -rfv data.json; fi

# Read csv headers
headers=$(cat $file |head -1 |tr ',' '\n')
header_length=$(echo "$headers" | wc -l)
max_index=$(echo "$headers" | wc -l)

# Read all line and covert to json format
line=0
while read x
do
    if [[ $line != "0" ]]; then

        # Change comma inside string
        text=`echo "$x" |sed 's/.*\,"//; s/\",.*//'`
        if [[ ! -z $text ]]; then x=`echo "$x" | sed -e 's;"'"$text"'";'"${text//,/#}"';g'`; fi
        values=`echo $x | tr ',' '\n'`

        index=1
        tmp=""
        id=`echo "\"id\": $line,"`
        tmp+=`echo -e $id`

        if [[ $(echo "$values" | wc -l) = "$header_length" ]]; then
            while IFS= read -r value; do
                # set -x
                key=$(echo $(sed -n "${index}p" <<< ${headers,,}) | sed 's/\r$//')
                key="\"$key\""
                value=$(echo "${value//\"/\\\"}")
                value=$(echo "${value//#/,}" | sed 's/\r$//')

                if [[ $value =~ ^[+-]?[0-9]*\.[0-9]+$ ]]; then
                    value="$value"
                elif ! [[ $value =~ ^[0-9]+$ ]]; then
                    if [[ ! -z $value ]]; then
                        value="\"$value\""
                    else
                        value="\"\""
                    fi
                fi

                # set -x

                if [[ $index != "$(echo ${max_index// /})" ]]; then
                    tmp+=$(echo $key: $value,)
                else
                    tmp+=$(echo $key: $value)
                fi
                index=$(($index+1))
            done <<< "$values"
            echo -e "{$tmp}" >> tmp
        fi
    fi
    line=$(($line+1))
    if [[ $line == "25000" ]]; then break; fi
done < $file

# Save new json file
if cat tmp |jq -c '{"index": {"_index": "'"$index_name"'", "_id": .id}}, .' > data.json
then
    echo "rm -f tmp"
fi
