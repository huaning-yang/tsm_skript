Add-Type -AssemblyName System.Windows.Forms
$FileBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
$FileBrowser.RootFolder = 'MyComputer'
$null = $FileBrowser.ShowDialog()
$Path = $FileBrowser.SelectedPath + "\*.*"
$PathNewHash =  $FileBrowser.SelectedPath + "\retrieve_hashes_$(get-date -f dd-MM-yyyy_hh-mm-ss).csv"
$PathOutput = $FileBrowser.SelectedPath + "\output.csv"

if(Test-Path -Path $FileBrowser.SelectedPath){
	Get-FileHash -Path (Get-ChildItem $Path -Recurse -force) | export-csv $PathNewHash -NoTypeInformation
}

Set-Location $FileBrowser.SelectedPath

$hashes = @(Get-ChildItem | Sort LastWriteTime | Where-Object { $_.Name -match 'hashes' } | select FullName -Last 2)

$file1 = Import-Csv $hashes[0].FullName
$file2 = Import-Csv $hashes[1].FullName

Write-Host "If the SideIndicator is '<=' something is different in the file " $hashes[0].FullName
Write-Host "If the SideIndicator is '=>' something is different in the file " $hashes[1].FullName


Compare-Object $file1 $file2 -Property Hash -PassThru | export-csv $PathOutput -NoTypeInformation

Read-Host -Prompt "Press Enter to exit"