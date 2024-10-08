# 定义XLSX文件路径
Write-Host "开始"
$excelFile = $args[0]
$outputFile = "download"
if (Test-Path $outputFile) {
	Remove-Item -Path $outputFile -Recurse -Force
}
# 创建Excel应用程序对象
$excel = New-Object -ComObject Excel.Application

# 打开工作簿
$workbook = $excel.Workbooks.Open($excelFile)
$worksheet = $workbook.Worksheets.Item(1)

# 获取数据范围
$dataRange = $worksheet.UsedRange
$lastRow = $dataRange.Rows.Count - 1

# 循环读取数据并下载文件
Write-Host "下载中"
for ($i = 2; $i -le $lastRow + 1; $i++) {
    # 获取templateId、roleId和url
    $templateId = $worksheet.Cells.Item($i, 1).Text
    $roleId = $worksheet.Cells.Item($i, 2).Text
    $url = $worksheet.Cells.Item($i, 3).Text
    
    # 创建文件夹
    $outputFolder = "download/$roleId"
    New-Item -ItemType Directory -Force -Path $outputFolder
    
    # 下载文件
    $outputFile = "$outputFolder/$templateId.lua"
    Invoke-WebRequest -Uri $url -OutFile $outputFile -PassThru > $null
    $num = $i-1
    Write-Host "Downloaded file $num/$lastRow"
}

# 关闭Excel应用程序
$workbook.Close($false)
$excel.Quit()
Write-Host "下载完成"
