$folderPath = $args[0]
$recordCount = 100
# 执行svn info命令，获取SVN地址
$svnInfo = svn info $folderPath
# 获取SVN地址
$svnURL = ($svnInfo -split "`n" | Select-String "URL: svn").ToString().Substring(5)
$svnURL
$keyword = Get-Clipboard


if ([string]::IsNullOrEmpty($keyword)) {
    Write-Host "剪贴板内容为空"
	Exit
}

#替换换行
$lines = $keyword.Split([Environment]::NewLine)
$keyword = ""
foreach ($line in $lines) {
    if ($line.Length -ge 1) {
		if ($keyword -ne "") {
			$keyword += "`n"
		}
        $keyword += $line 
    }
}
$keyword
# 执行svn log命令以XML格式获取最近100条记录
$svnLog = svn log $svnURL -v -l $recordCount


# 初始化结果变量
$result = ""
$target = "split"
$messageFile = ""
$filesFile = ""
$infoFile = ""
$findTargetReady = 0
# 遍历每条提交记录
foreach ($line in $svnLog) {
    # 判断是否包含关键词
	if ($target -eq "split") {
        if ($line -eq "------------------------------------------------------------------------") {
            if ($messageFile -like "*$keyword*") {
                $findTargetReady = 1
            }
			
            if ($filesFile -like "*$keyword*") {
                $findTargetReady = 1
            }
			
            if ($infoFile -like "*$keyword*") {
                $findTargetReady = 1
            }
			
            if ($findTargetReady -eq 1) {
				$result += $infoFile
                $result += "Message:"
				$result += $messageFile
				$result += "----" + "`n"
				$result += $filesFile
            }
            $target = "version"
			$messageFile = ""
			$filesFile = ""
			$infoFile = ""
            $findTargetReady = 0
        } else {
			$messageFile += $line + "`n"
        }
    } elseif ($target -eq "version") {
        if ($line.Substring(0, 1) -eq "r") {
            $target = "files"
            $lineParts = $line -split "\|"
            $revision = $lineParts[0].Substring(1).Trim()
            $author = $lineParts[1].Trim()
            $date = ($lineParts[2].Substring(0,20)).Trim()
			if ($result -ne "") {
                $infoFile += "`n"
            }
            $infoFile += "Revision: $revision" + "`n"
            $infoFile += "Author: $author" + "`n"
            $infoFile += "Date: $date" + "`n"
        }
    } elseif ($target -eq "files") {
        if ($line.Length -ge 9 -and $line.Substring(3, 3) -eq "M /") {
            $filesFile += "Modified : " + $line.Substring(5) + "`n" 
        } elseif ($line.Length -ge 9 -and $line.Substring(3, 3) -eq "A /") {
            $filesFile += "Added : " + $line.Substring(5) + "`n"
        } elseif ($line -eq "Changed paths:") {
            # 不执行任何操作
        } else {
            $messageFile += $line + "`n"
            $target = "split"
        }
    }    
}
$outputFile = "svn_find_res.log"
if (Test-Path $outputFile) {
	Remove-Item -Path $outputFile
}
if ($result -eq "") {
	 Write-Host "未搜索到剪切版内容$keyword"
	 Exit
}
$result >> $outputFile 
Set-Clipboard -Value $result
Write-Host "$keyword 相关的svn记录已复制到剪切版和文件$outputFile"