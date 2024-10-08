import openpyxl
import sys
import os
file_name = sys.argv[1]
print(file_name)

workbook = openpyxl.load_workbook(file_name)
sheet = workbook.active
my_list = []
for row in sheet.iter_rows(min_row=1, max_col=5, values_only=True):
    c_value = row[1]
    if c_value != None and c_value != "deviceid":
        my_list.append(c_value)
with open("1.txt", "w") as file:
    file.write(",".join(my_list))

