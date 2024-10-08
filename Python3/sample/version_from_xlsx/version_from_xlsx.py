import openpyxl
import sys
import os
import pyperclip
from collections import defaultdict
file_name = sys.argv[1]
print(file_name)
# 加载Excel文件
workbook = openpyxl.load_workbook(file_name)
sheet = workbook.active

# 初始化字典用于存储解析后e列的内容
data_dict = defaultdict(list)

# 解析表格中的内容（从第二行开始，假设第一行是表头）
has_wrong = False
for row in sheet.iter_rows(min_row=1, max_col=5, values_only=True):
    try:
        e_value = int(row[4])
    except:
        e_value = row[4]
    c_value = row[2]
    #print(c_value, e_value)
    if c_value != None:
        # 提取关键词（:/到下一个/之间的字符部分）
        try:
            keyword = c_value.split('/')[1]
            if keyword == None:
                has_wrong = True
            else:
                if isinstance(e_value, int):
                    if not e_value in data_dict[keyword]:
                        data_dict[keyword].append(e_value)
                elif e_value != None:
                    print(e_value, "e_value")
                    has_wrong = True
        except IndexError:
            continue
if has_wrong:
    print("has_wrong", has_wrong)
    os.startfile(file_name)
else:
    # 格式化和排序
    item_size = len(data_dict.items())
    show_keyword = None
    #print("item_size", item_size)
    for keyword, entries in sorted(data_dict.items()):
        if len(entries) > 0 :
            entries.sort()  # 排序e列内容
            print(keyword,entries)
            if keyword == "trunk" or item_size == 1 :
                show_keyword = keyword
                string_list = [str(item) for item in entries]
                s_value = ','.join(string_list)
                pyperclip.copy(s_value)
    if show_keyword != None:
        print("%s内容已复制到剪切板" % show_keyword)
