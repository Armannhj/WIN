$notendur = Import-Csv C:\Users\Administrator\Documents\Powershell\file.csv

foreach($n in $notendur){
    


        $Sam = $n.samaccountname

        $Sam
        

        
        Invoke-Sqlcmd -ServerInstance '(local)' -Query "use master 
        go
        create database $Sam
        go
        CREATE LOGIN [EEP-ARMANN\$Sam] FROM WINDOWS WITH DEFAULT_DATABASE=[$Sam]
        go
        use $Sam"


}