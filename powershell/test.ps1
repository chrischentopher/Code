$target = "IQA-85691
【缺陷】-【拍照】-宠物合拍模式下选择带有默认手持物的动作，将宠物不显示或改为人物拍照，默认手持物会消失"
# 分割原始字符串
$lines = $target.Split([Environment]::NewLine)
$line=[Environment]::NewLine
Write-Host Length $line.Length
# 创建新的字符串数组，去除空行
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
$log2 = "【缺陷】-【拍照】-宠物合拍模式下选择带有默认手持物的动作，将宠物不显示或改为人物拍照，默认手持物会消失" + [Environment]::NewLine
$log = $log1 + $log2
if ($log -like "*$target*") {
	Write-Host "like target"
}
Write-Host "over"