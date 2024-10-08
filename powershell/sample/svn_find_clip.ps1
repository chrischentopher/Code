$folderPath = $args[0]
$recordCount = 100
# ִ��svn info�����ȡSVN��ַ
$svnInfo = svn info $folderPath
# ��ȡSVN��ַ
$svnURL = ($svnInfo -split "`n" | Select-String "URL: svn").ToString().Substring(5)
$svnURL
$keyword = Get-Clipboard


if ([string]::IsNullOrEmpty($keyword)) {
    Write-Host "����������Ϊ��"
	Exit
}

#�滻����
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
# ִ��svn log������XML��ʽ��ȡ���100����¼
$svnLog = svn log $svnURL -v -l $recordCount


# ��ʼ���������
$result = ""
$target = "split"
$messageFile = ""
$filesFile = ""
$infoFile = ""
$findTargetReady = 0
# ����ÿ���ύ��¼
foreach ($line in $svnLog) {
    # �ж��Ƿ�����ؼ���
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
            # ��ִ���κβ���
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
	 Write-Host "δ���������а�����$keyword"
	 Exit
}
$result >> $outputFile 
Set-Clipboard -Value $result
Write-Host "$keyword ��ص�svn��¼�Ѹ��Ƶ����а���ļ�$outputFile"