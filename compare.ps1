$file1 = Import-Csv -Path "C:\Users\yanghuan\Desktop\Test1\hashes_06-08-2021_03-26-47.csv"
$file2 = Import-Csv -Path "C:\Users\yanghuan\Desktop\Test1\hashes_06-08-2021_03-27-06.csv"
Compare-Object $file1 $file2 -Property Hash,Path | export-csv C:\Users\yanghuan\Desktop\Test1\output.csv
