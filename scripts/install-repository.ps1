
# where stuff is
$root = resolve-path "$PSScriptRoot\.."
$tools = "$root\tools"
$proget = "$root\proget"
$packages = "$root\packages"
$temp= "$proget\temp"
$installer = "$tools\proget-install.exe"

# check for installed product first.
if( test-path $proget )  {
    write-warning "ProGet appears to be installed at '$proget'" 
    write-warning "Uninstall it before calling this script." 
    #  write-error "Aborting installation of repository"
    return;
}

#run this elevated
If (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    $CommandLine = $MyInvocation.Line.Replace($MyInvocation.InvocationName, $MyInvocation.MyCommand.Definition)
    Start-Process -FilePath PowerShell.exe -Verb Runas -Wait -WorkingDirectory (pwd)  -ArgumentList "$CommandLine"
    return 
}

# ensure we have a download path
$null = if ( -not (test-path $tools) )  { 
    mkdir $tools 
}

#download ProGet
if ( -not (test-path $installer) )  { 
    "Downloading ProGet installer"
    wget http://inedo.com/proget/download/sql/3.2.1 -outfile  "$tools\proget-install.exe"
}

#install ProGet
"Installing ProGet (waiting for installer to finish)"
start-process -wait -filepath $installer -ArgumentList "/S /Edition=Express /EmailAddress=script@mailinator.com /TargetPath=$proget /PackagesPath=$packages /ASPNETTempPath=$temp /port=5555 /UseIntegratedWebServer=true /InstallSqlExpress"

"Done!"
