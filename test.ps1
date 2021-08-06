$param1 = $args[0]

if( Test-Path -Path "C:\Users\yanghuan\Desktop\Test1\*.*"){
    if($param1 -eq "hash"){
        Get-FileHash -Path (Get-ChildItem "C:\Users\yanghuan\Desktop\Test1\*.*" -Recurse -force) | export-csv "C:\Users\yanghuan\Desktop\Test1\hashes_$(get-date -f dd-MM-yyyy_hh-mm-ss).csv"
    }
}

Robocopy C:\Users\yanghuan\Desktop\Test1 C:\Users\yanghuan\Desktop\Test2 /MIR /FFT /Z /XA:H /W:5

# start the logging script
# run the archive script (bat file)

# delete the source folder Get-ChildItem -Path "folderPath" -Recurse| Foreach-object {Remove-item -Recurse -path $_.FullName }
#sync folders again Robocopy source destination /MIR /FFT /Z /XA:H /W:5