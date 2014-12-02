
function test-onegetloaded {
    if( get-module -name oneget ) {
        return $true
    }

    return $false
}

function import-oneget {
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