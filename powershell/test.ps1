$target = "IQA-85691
��ȱ�ݡ�-�����ա�-�������ģʽ��ѡ�����Ĭ���ֳ���Ķ����������ﲻ��ʾ���Ϊ�������գ�Ĭ���ֳ������ʧ"
# �ָ�ԭʼ�ַ���
$lines = $target.Split([Environment]::NewLine)
$line=[Environment]::NewLine
Write-Host Length $line.Length
# �����µ��ַ������飬ȥ������
$target = ""
$num = 0
foreach ($line in $lines) {
    if ($line.Length -ge 1) {
		Write-Host $line.Length
        $target += $line + [Environment]::NewLine
		$num += 1
    }
}
$target
$log1 = "IQA-85691" + [Environment]::NewLine
$log2 = "��ȱ�ݡ�-�����ա�-�������ģʽ��ѡ�����Ĭ���ֳ���Ķ����������ﲻ��ʾ���Ϊ�������գ�Ĭ���ֳ������ʧ" + [Environment]::NewLine
$log = $log1 + $log2
if ($log -like "*$target*") {
	Write-Host "like target"
}
Write-Host "over"