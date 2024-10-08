# ����XLSX�ļ�·��
Write-Host "��ʼ"
$excelFile = $args[0]
$outputFile = "download"
if (Test-Path $outputFile) {
	Remove-Item -Path $outputFile -Recurse -Force
}
# ����ExcelӦ�ó������
$excel = New-Object -ComObject Excel.Application

# �򿪹�����
$workbook = $excel.Workbooks.Open($excelFile)
$worksheet = $workbook.Worksheets.Item(1)

# ��ȡ���ݷ�Χ
$dataRange = $worksheet.UsedRange
$lastRow = $dataRange.Rows.Count - 1

# ѭ����ȡ���ݲ������ļ�
Write-Host "������"
for ($i = 2; $i -le $lastRow + 1; $i++) {
    # ��ȡtemplateId��roleId��url
    $templateId = $worksheet.Cells.Item($i, 1).Text
    $roleId = $worksheet.Cells.Item($i, 2).Text
    $url = $worksheet.Cells.Item($i, 3).Text
    
    # �����ļ���
    $outputFolder = "download/$roleId"
    New-Item -ItemType Directory -Force -Path $outputFolder
    
    # �����ļ�
    $outputFile = "$outputFolder/$templateId.lua"
    Invoke-WebRequest -Uri $url -OutFile $outputFile -PassThru > $null
    $num = $i-1
    Write-Host "Downloaded file $num/$lastRow"
}

# �ر�ExcelӦ�ó���
$workbook.Close($false)
$excel.Quit()
Write-Host "�������"
