Add-Type -AssemblyName System.Windows.Forms

Write-Host "Dieses Skript erstellt einen Archivierungsauftrag für die Langzeitarchivierung.
Dafür werden folgende Informationen benötigt: Name der auftraggebenden Person, Ort der zu archivierenden Daten und ob die Daten gehasht werden sollen"
$Name = Read-Host -Prompt "Bitte geben Sie den Namen der auftraggebenden Person ein"
Write-Host "Bitte wählen Sie den Ordner der zu archivierenden Daten aus"
$FileBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
$FileBrowser.RootFolder = 'MyComputer'
$null = $FileBrowser.ShowDialog()
$Path = $FileBrowser.SelectedPath
Write-Host "Bitte wählen Sie aus ob die Daten gehasht werden sollen"
$Input = "Dateien hashen", "Dateien nicht hashen" | Out-GridView -PassThru -Title "Hashoperation wählen"
$creation_date = get-date -f dd-MM-yyyy_hh-mm-ss
"$Name
$Path
$Input" | Set-Content "C:\Users\yanghuan\Desktop\Testordner\offene Aufträge\auftrag_$creation_date.txt"
Write-Host "Der Auftrag wurde erstellt. Die gesammelten Informationen befinden sich inC:\Users\yanghuan\Desktop\Testordner\offene Aufträge\auftrag_$creation_date.txt"
Read-Host -Prompt "Drücken Sie Enter um dieses Fenster zu schließen"