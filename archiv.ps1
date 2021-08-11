$param1 = $args[0]
$env:SEE_MASK_NOZONECHECKS = 1

if( Test-Path -Path "C:\Users\iqb_archivar\Desktop\Testordner\*.*"){
    if($param1 -eq "hash"){
        Get-FileHash -Path (Get-ChildItem "C:\Users\iqb_archivar\Desktop\Testordner\*.*" -Recurse -force) | export-csv "C:\Users\iqb_archivar\Desktop\Testordner\hashes_$(get-date -f dd-MM-yyyy_hh-mm-ss).csv" -NoTypeInformation
    }
}

Robocopy C:\Users\iqb_archivar\Desktop\Testordner J:\ARCH /MIR /FFT /Z /XA:H /W:5

Start-Process -FilePath J:\TSM\file_log.bat 
Start-Process -FilePath J:\TSM\tsm_archiv.bat -Wait

Get-ChildItem -Path 'J:\ARCH' -Recurse| Foreach-object {Remove-item -Recurse -path $_.FullName }
