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
# ------------------ OneGet Test  ----------------------------------------------
ipmo "$PSScriptRoot\utility.psm1"


# ------------------------------------------------------------------------------
# Actual Tests:

Describe "get-packageprovider" {
    # make sure that oneget is loaded
    import-oneget
    
    It "lists package providers installed" {
        $x = (get-packageprovider).name | should match "nuget"
    }
}

Describe "happy" -tag common {
    # make sure that oneget is loaded
    import-oneget
    
    It "looks for packages in bootstrap" {
        (find-package -provider bootstrap).Length | write-host 
    }
    
    It "does something else" {
        $false | should be $false
    }
}

Describe "mediocre" -tag common,pristine {
    # make sure that oneget is loaded
    import-oneget
    
    It "does something useful" {
        $true | should be $true
    }
}

Describe "sad" -tag pristine {
    # make sure that oneget is loaded
    import-oneget
    
    It "does something useful" {
        $true | should be $true
    }
}

Describe "mad" -tag pristine {
    # make sure that oneget is loaded
    import-oneget
    
    It "does something useful too" {
        $true | should be $true
    }
}



