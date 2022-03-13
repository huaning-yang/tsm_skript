$env:SEE_MASK_NOZONECHECKS = 1

if ( Test-Path "C:\Users\Ninghorn\Desktop\Testordner\offene Aufträge\auftrag_*.txt") {
    $items = Get-ChildItem "C:\Users\Ninghorn\Desktop\Testordner\offene Aufträge" -Filter auftrag_*.txt
    foreach ($item in $items){
        $filenameParts = $item.BaseName -split "_"
        $part2 = $filenameParts[1]
        $part3 = $filenameParts[2]
        $file = Get-Content $item.FullName
        if($file){
            if($file[0] -and $file[1] -and $file[2]){
                $name = $file[0]
                $path = $file[1]
                $hash = $file[2]

                Write-Host " Auftraggebende Person: $name `n Zu archivierender Ordner: $path `n $hash `n Auftragsdatei: $filename `n $part2 `n $part3"
                Set-Location $path
                $folderPath = $path + "\*.*"
                $timestamp = $(get-date -f dd-MM-yyyy_hh-mm-ss)
                $hashPath = "C:\Users\Ninghorn\Desktop\Testordner\Aufträge Hashes"
                $hashFilename = "\auftrag_" + $part2 + "_" + $part3 + "_"+ "hashes_$timestamp.csv"
                $hashFile = $hashPath + $hashFilename
            
                if( Test-Path -Path $FolderPath){
                    if($hash -eq "Dateien hashen"){
                        Get-FileHash -Path (Get-ChildItem $FolderPath -Recurse -force) | export-csv $hashFile -NoTypeInformation
                    }
                }

                Robocopy $path C:\Users\Ninghorn\Desktop\Archivordner /MIR /FFT /Z /XA:H /W:5 
                Copy-Item $hashFile -Destination C:\Users\Ninghorn\Desktop\Archivordner

    
                #Start-Process -FilePath J:\TSM\file_log.bat 
                #Start-Process -FilePath J:\TSM\tsm_archiv.bat -Wait

                #Get-ChildItem -Path 'C:\Users\Ninghorn\Desktop\Archivordner' -Recurse| Foreach-object {Remove-item -Recurse -path $_.FullName }
                Move-Item $item.fullName -Destination "C:\Users\Ninghorn\Desktop\Testordner\erledigte Aufträge\"
          }
       }
    }
        
    Read-Host -Prompt "Drücken Sie Enter um dieses Fenster zu schließen"


} else { 
    Exit
}

