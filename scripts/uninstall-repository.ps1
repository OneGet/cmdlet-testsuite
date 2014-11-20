
# where stuff is
$root = resolve-path "$PSScriptRoot\.."
$proget = "$root\proget"
$packages = "$root\packages"
$uninstaller = "$proget\Service\pguninstall.exe"

# check for installed product first.
if( -not (test-path $proget) )  {
    write-warning "ProGet does not appear to be installed at '$proget'" 
    #  write-error "Aborting installation of repository"
    return;
}

#run this elevated
If (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    $CommandLine = $MyInvocation.Line.Replace($MyInvocation.InvocationName, $MyInvocation.MyCommand.Definition)
    Start-Process -FilePath PowerShell.exe -Verb Runas -Wait -WorkingDirectory (pwd)  -ArgumentList "$CommandLine"
    return 
}


#install ProGet
"Uninstalling ProGet (waiting for installer to finish)"
start-process -wait -filepath $uninstaller -ArgumentList "/unincluse /S"

rmdir -recurse -force $proget
"Done!"

