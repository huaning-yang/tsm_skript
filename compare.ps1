Set-Location -Path 'C:\Users\iqb_archivar\Desktop\Testordner2\ARCH'

Get-FileHash -Path (Get-ChildItem "C:\Users\iqb_archivar\Desktop\Testordner2\ARCH\*.*" -Recurse -force) | export-csv "C:\Users\iqb_archivar\Desktop\Testordner2\ARCH\retrieve_hashes_$(get-date -f dd-MM-yyyy_hh-mm-ss).csv" -NoTypeInformation

$hashes = @(Get-ChildItem | Sort LastWriteTime | Where-Object { $_.Name -match 'hashes' } | select FullName -Last 2)

$file1 = Import-Csv $hashes[0].FullName
$file2 = Import-Csv $hashes[1].FullName


Compare-Object $file1 $file2 -Property Hash -PassThru | export-csv 'C:\Users\iqb_archivar\Desktop\Testordner2\ARCH\output.csv' -NoTypeInformation

Set-Location -Path 'C:\Users\iqb_archivar\Desktop\'