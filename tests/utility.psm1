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

<#
.SYNOPSIS
Removes all installed OneGet providers from: 
    $Env:ProgramFiles/OneGet/ProviderAssemblies
    $Env:LocalAppData/OneGet/ProviderAssemblies

#>
function Remove-AllOneGetProviders {

}


<#
.SYNOPSIS
Checks to see if the OneGet Module is loaded.

#>
function Test-IsOneGetLoaded {
    if( get-module -name oneget ) {
        return $true
    }

    return $false
}

<#
.SYNOPSIS
Imports the OneGet Module (using the environment variable to select the right one)
#>
function Import-Oneget {
    <# 
        OneGet tests should have the $moduleLocation set by the calling script
        otherwise it will use the default (loading OneGet from the PSModulePath)
    #>

    if (-not $env:OneGetModuleTest ) {
        $env:OneGetModuleTest = "oneget"
    }

    echo "Importing OneGet Module from $env:OneGetModuleTest"
    ipmo $env:OneGetModuleTest
    return $true
}