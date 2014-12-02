# ------------------ OneGet Test  -----------------------------------------
ipmo "$PSScriptRoot\module-loader.ps1"


# ------------------------------------------------------------------------------
# Actual Tests:

Describe "get-packageprovider" -tag common {

    It "does something useful" {
        $true | should be $false
    }
}



Describe "happy" -tag common {

    # make sure that oneget is loaded
    import-oneget
    
    It "does something useful" {
        $true | should be $true
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
    
    It "does something useful" {
        $true | should be $true
    }
}

Describe "mad" -tag pristine {
    
    It "does something useful too" {
        $true | should be $true
    }
}



