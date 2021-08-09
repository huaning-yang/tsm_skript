Set-Location -Path C:\Users\yanghuan\Desktop\Test1

$hashes = @(Get-ChildItem | Sort LastWriteTime | Where-Object { $_.Name -match 'hashes' } | select FullName -Last 2)

$file1 = Import-Csv $hashes[0].FullName
$file2 = Import-Csv $hashes[1].FullName
Compare-Object $file1 $file2 -Property Hash,Path | export-csv C:\Users\yanghuan\Desktop\Test1\output.csv
