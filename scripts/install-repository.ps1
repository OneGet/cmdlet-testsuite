# 
#  Copyright (c) Microsoft Corporation. All rights reserved. 
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#  http://www.apache.org/licenses/LICENSE-2.0
#  
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#  



$origdir = (pwd)

cd $PSScriptRoot


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
    
    cd $origdir 
    return;
}

#run this elevated
If (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    $CommandLine = $MyInvocation.Line.Replace($MyInvocation.InvocationName, $MyInvocation.MyCommand.Definition)
    Start-Process -FilePath PowerShell.exe -Verb Runas -Wait -WorkingDirectory (pwd)  -ArgumentList "$CommandLine"
    cd $origdir 
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
$me = '"automated robot"'

start-process -wait -filepath $installer -ArgumentList "/S /Edition=Express /EmailAddress=script@mailinator.com /FullName=$me /TargetPath=$proget /PackagesPath=$packages /ASPNETTempPath=$temp /port=5555 /UseIntegratedWebServer=true /InstallSqlExpress"

"Done!"
cd $origdir 