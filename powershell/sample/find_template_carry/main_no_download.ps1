# 保存Excel文件
$outputFile = "output.xlsx"
Write-Host "生成中请关闭$outputFile"

# 定义下载文件的根目录
$downloadRoot = "download"

# 创建Excel应用程序对象
$excel = New-Object -ComObject Excel.Application

# 创建工作簿和工作表
$workbook = $excel.Workbooks.Add()
$worksheet = $workbook.Worksheets.Item(1)

# 定义列标题
$worksheet.Cells.Item(1, 1) = "角色id"
$worksheet.Cells.Item(1, 2) = "模板id"
$worksheet.Cells.Item(1, 3) = "手持物品id"

# 获取下载文件夹中的所有子文件夹
$subFolders = Get-ChildItem -Path $downloadRoot -Directory

# 循环遍历子文件夹
$rowIndex = 2
foreach ($subFolder in $subFolders) {
    $roleId = $subFolder.Name
    
    # 获取子文件夹中所有的.lua文件
    $luaFiles = Get-ChildItem -Path "$downloadRoot\$roleId" -Filter "*.lua" -File
    
    foreach ($luaFile in $luaFiles) {
        # 提取模板id
        $templateId = $luaFile.BaseName
        
        # 读取文件内容，查找Carry = $id的值
        $content = Get-Content -Path $luaFile.FullName
        $carryIds = $content | ForEach-Object {
            if ($_ -cmatch "Carry\s*=\s*([A-Za-z0-9]+);") {
                $matches[1]
            }
        }
        
        # 将角色id、模板id和手持物品id写入表格
        foreach ($carryId in $carryIds) {
            $worksheet.Cells.Item($rowIndex, 1) = "'$roleId"
            $worksheet.Cells.Item($rowIndex, 2) = "'$templateId"
            $worksheet.Cells.Item($rowIndex, 3) = $carryId
            $rowIndex++
        }
    }
}



if (Test-Path $outputFile) {
	Remove-Item -Path $outputFile
}
$workbook.SaveAs("$PSScriptRoot\$outputFile")

# 关闭工作簿和Excel应用程序
$workbook.Close($false)
$excel.Quit()

Write-Host "生成到: $outputFile"