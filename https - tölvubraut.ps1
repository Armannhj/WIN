$notendur = Import-Csv C:\Users\Administrator\Documents\Powershell\file.csv

foreach($n in $notendur){
    


        $Sam = $n.samaccountname

        $Sam
        

        
        New-Item $("C:\inetpub\wwwroot\" + $Sam + ".eep.is") -ItemType Directory
        New-Item $("C:\inetpub\wwwroot\" + $Sam + ".eep.is\index.html") -ItemType File -Value $("Notendasiða " + $Sam + "")
        New-Website -Name $($Sam + ".eep.is") -HostHeader $($Sam + ".eep.is") -PhysicalPath $("C:\inetpub\wwwroot\" + $Sam + ".eep.is\")



}