VAR_PUB_BRANCH_SUFFIX="branch_obn2"
VAR_DEVICE_PLAT="win"
AZURE_PC_MODE="true"
BASE_LANGUAGE="zh"
REVERT_VERSION_STR="111"

work_dir=D:\\mb
if [ "$VAR_PUB_BRANCH_SUFFIX" = "branch_obn" ]; then
	work_dir=E:\\mb
fi
dst_dir_name="dst_${VAR_PUB_BRANCH_SUFFIX}_${VAR_DEVICE_PLAT}_mini"
if [ "$VAR_DEVICE_PLAT" = "win" ] && [ "$AZURE_PC_MODE" = "true" ]; then
   dst_dir_name="${dst_dir_name}_azurepcmode"
fi

now_path="$(dirname "$0")"
work_path="${work_dir}/${dst_dir_name}"

if [ "$BASE_LANGUAGE" = "zh" ]; then
    base_language_dir=""
else
    base_language_dir="${BASE_LANGUAGE}/"
fi

base_language_dir_config="${base_language_dir}Output/config"
work_path_config="${work_path}/${base_language_dir_config}"

base_language_dir="${base_language_dir}Output/assets"
work_path="${work_path}/${base_language_dir}"

work_path=F:\\trunk/Azure/Output/Lua
work_path_config=D:\\Projects\\tmp_config
echo "$work_path" "$work_path_config"
cd "$work_path_config" || { echo "cd $work_path_config failed"; exit 1; }
# Move to the work directory
cd "$work_path" || { echo "cd $work_path failed"; exit 1; }

# Get SVN URL
svn_url=$(svn info 2>/dev/null | grep -E "^URL" | awk '{print $2}')
if [ -z "$svn_url" ]; then
    echo "svn info error"
    exit 1
else
    echo "$svn_url"
fi

IFS=', ' read -r -a array <<< "$REVERT_VERSION_STR"
index=${#array[@]}
if [ $index -eq 0 ]; then
    echo "version_str error"
    exit 1
fi
for ((i=0; i<index; i++)); do
    for ((j=i+1; j<index; j++)); do
        if [ ${array[i]} -le ${array[j]} ]; then
            temp=${array[i]}
            array[i]=${array[j]}
            array[j]=$temp
        fi
    done
done
for ((i=0; i<index; i++)); do
    echo ${array[i]}
done

temp_path=c:\\tempfile.txt
svn up
svn_index=0
correct_index=0
svn log -l "$index" --xml | sed -n 's/.*revision="\([^"]*\)".*/\1/p' > temp_path
while read -r version; do
    if [ "${version}" == "${array[svn_index]}" ]; then
        correct_index=$correct_index+1
    fi
    echo "${version}" "$svn_index" "${array[svn_index]}"
    svn_index=$svn_index+1
done < temp_path
rm temp_path

if [[ $correct_index -eq $index ]]; then
    for ((i=0; i<index; i++)); do
        cmd /c "svn merge -c -${array[i]} $svn_url"
    done
	#svn commit -m "revert %REVERT_VERSION_STR%"
    echo "revert $REVERT_VERSION_STR"
else
    echo "$REVERT_VERSION_STR not match new and continuous need $index but $correct_index"
    #exit 1
fi

cd "$work_path_config"

for element in "${array[@]}"; do
    grep -v "\<$element\>" history.txt > temp_path #我们使用\<和\>来限定一个完整的单词匹配
    mv temp_path history.txt
done

for element in "${array[@]}"; do
    grep -v "\<$element\>" tags.txt > temp_path
    mv temp_path tags.txt
done
#svn commit -m "revert %REVERT_VERSION_STR%"
