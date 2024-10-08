# ����Excel�ļ�
$outputFile = "output.xlsx"
Write-Host "��������ر�$outputFile"

# ���������ļ��ĸ�Ŀ¼
$downloadRoot = "download"

# ����ExcelӦ�ó������
$excel = New-Object -ComObject Excel.Application

# �����������͹�����
$workbook = $excel.Workbooks.Add()
$worksheet = $workbook.Worksheets.Item(1)

# �����б���
$worksheet.Cells.Item(1, 1) = "��ɫid"
$worksheet.Cells.Item(1, 2) = "ģ��id"
$worksheet.Cells.Item(1, 3) = "�ֳ���Ʒid"

# ��ȡ�����ļ����е��������ļ���
$subFolders = Get-ChildItem -Path $downloadRoot -Directory

# ѭ���������ļ���
$rowIndex = 2
foreach ($subFolder in $subFolders) {
    $roleId = $subFolder.Name
    
    # ��ȡ���ļ��������е�.lua�ļ�
    $luaFiles = Get-ChildItem -Path "$downloadRoot\$roleId" -Filter "*.lua" -File
    
    foreach ($luaFile in $luaFiles) {
        # ��ȡģ��id
        $templateId = $luaFile.BaseName
        
        # ��ȡ�ļ����ݣ�����Carry = $id��ֵ
        $content = Get-Content -Path $luaFile.FullName
        $carryIds = $content | ForEach-Object {
            if ($_ -cmatch "Carry\s*=\s*([A-Za-z0-9]+);") {
                $matches[1]
            }
        }
        
        # ����ɫid��ģ��id���ֳ���Ʒidд����
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

# �رչ�������ExcelӦ�ó���
$workbook.Close($false)
$excel.Quit()

Write-Host "���ɵ�: $outputFile"