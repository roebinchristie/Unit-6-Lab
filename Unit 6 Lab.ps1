$rdhost = Read-Host "What is the name of the folder?"
$rdhost
$rdhost2 = Read-Host "What is the path to the folder?"
$rdhost2
$answer = Read-Host "Are you sure? (Y/N)"
$num = 5,50,50,3,1
$server = Get-Content serverlist.csv
$Printers = Get-Printer

#This function comes up with a prompt asking the user what the name is for the folder and the path of that folder.
#After answering the prompt, the script creates a folder containing folders which are named after the employees.
#The script then creates a text file within the employee folders which welcomes the employee.
function name {
    if ($answer -eq 'y'){
        Set-Location C:\
        New-Item -Name $rdhost -Type directory -Path $rdhost2
        $Names = Import-Csv employeelist.csv 
        ForEach ($Name in $Names){
            New-Item -Name $Name.Name.Replace(' ','').ToLower() -Type directory -Path C:\fileserver
            New-Item -Name hello.txt -Type file -Value "Welcome, $($Name.Name)!!!!?" -Path C:\fileserver\$($Name.Name.Replace(' ','').ToLower())
        }
    }
}
#This function asks the user to input a number, and it takes that number and multiplies it by 5, 50, 50, 3, 1 in that respective order.
function beans {
    ForEach ($beans in $num){
        $rdhost3 = Read-Host "Insert a number"
        $equal = $beans * $rdhost3
        write-host $equal
    }
}
#This function tests the connection between the host and remote network.
function server-connection {
    ForEach ($servers in $server){
        if (Test-Connection -ComputerName $servers -Quiet){
            write-host "Ping for '$servers' was successful"
        }

        else {
            write-host 'Ping for' $servers 'was unsuccessful'
        }
    }
}

#This function creates a folder containing JSON files of the current printers on the system.
function printer { 
    New-Item -Type directory -Name Printers -Path C:\
    ForEach ($Printer in $Printers.name){
        New-Item -Name $Printer.json -Type file -Path C:\Printers
        Get-Printer | ConvertTo-Json | out-file -FilePath C:\Printers\$Printer.json
        $Printer | Format-List
    }
}

name
beans
server-connection
printer
$Printers.name