$env:SEE_MASK_NOZONECHECKS = 1

Get-ChildItem "C:\Users\iqb_archivar\Desktop\Aufträge" -Filter *.txt | Foreach-Object{
    $file = Get-Content $_.FullName
    $name = $file[0]
    $path = $file[1]
    $hash = $file[2]

    Write-Host "
    $name
    $path
    $hash"
    Set-Location $path

    $FolderPath = $path + "\*.*"
    $hashPath = $path + "\hashes_$(get-date -f dd-MM-yyyy_hh-mm-ss).csv"

    
    if( Test-Path -Path $FolderPath){
        if($hash -eq "Dateien hashen"){
            Get-FileHash -Path (Get-ChildItem $FolderPath -Recurse -force) | export-csv $hashPath -NoTypeInformation
        }
    }

    Robocopy $path J:\ARCH /MIR /FFT /Z /XA:H /W:5

    Start-Process -FilePath J:\TSM\file_log.bat 
    Start-Process -FilePath J:\TSM\tsm_archiv.bat -Wait

    Get-ChildItem -Path 'J:\ARCH' -Recurse| Foreach-object {Remove-item -Recurse -path $_.FullName }
  
}
Read-Host -Prompt "Press Enter to exit"


