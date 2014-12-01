# ------------------ OneGet Test  -----------------------------------------

<# 
    OneGet tests should have the $moduleLocation set by the calling script
    otherwise it will use the default (loading OneGet from the PSModulePath)
#>

if (-not $env:OneGetModuleTest ) {
    $env:OneGetModuleTest = "oneget"
}

echo "Importing OneGet Module from $env:OneGetModuleTest"
ipmo $env:OneGetModuleTest

# ------------------------------------------------------------------------------
# Actual Tests:

Describe "get-packageprovider" {

    It "does something useful" {
        $true | should be $false
    }
}


Describe "happy" {

    It "does something useful" {
        $true | should be $true
    }
}


