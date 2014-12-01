#placeholder 

[CmdletBinding(SupportsShouldProcess=$true)]
Param(
    [string]$moduleLocation = 'oneget',
    [string]$action = 'test'
)

$origdir = (pwd)
cd $PSScriptRoot

try {

    switch( $action ) {
        'test' { 
            if( -not (test-path $PSScriptRoot\Pester\Vendor\packages) )  {
                write-error "Run test-oneget -action setup first."
                return $false
            }
            
            if( -not (& $PSScriptRoot\scripts\test-pester.ps1) )  {
                write-error "Run test-oneget -action setup first."
                return $false
            }
            
            # Set the environment variable to the OneGet module we want to test
            $env:OneGetModuleTest = $moduleLocation
            
            # adn the important parts about what we're testing
            $pester = "$PSScriptRoot\Pester\pester.psd1"
            $testPath =  "$PSScriptRoot\Tests"
            $output = "$PSScriptRoot\OneGet.Results.XML"
            
            # Run using the powershell.exe so that the tests will load the OneGet
            # module using the version that gets specified (and not one that
            # may be in this session already)
            . powershell.exe "ipmo '$pester' ; Invoke-Pester -Path '$testPath' -OutputFile '$output' -OutputFormat NUnitXml"

            # load the results from the output
            [xml]$results= Get-Content $output
            
            $total = $results.'test-results'.total
            $failures = $results.'test-results'.failures
            $successes = $total - $failures 
            
            write-host "RESULTS: Ran $total test-suites." -foregroundcolor  white 
            
            write-host "    Succeeded: $successes" -foregroundcolor  green 
            
            if( $failures -gt 0 ) {
                write-host "    Failed: $failures `n" -foregroundcolor red 
                return $false
            } else {
            
            }
            return $true
        } 
        
        'setup' { 
            # install ProGet
            if( (& $PSScriptRoot\scripts\test-proget.ps1) )  {
                write-verbose "ProGet previously installed"
            } else {
                write-verbose "Installing ProGet"
                . $PSScriptRoot\scripts\install-repository.ps1
            }

            #make sure that pester is configured correctly
            if( (& $PSScriptRoot\scripts\test-pester.ps1) )  {
                write-verbose "Pester appears correct"
            } else {
                cd $PSScriptRoot\Pester
                write-verbose "Running Pester Build"
                . $PSScriptRoot\Pester\build.bat package
            }
        }
        
        'cleanup' { 
            if( (& $PSScriptRoot\scripts\test-proget.ps1) )  {
                write-verbose "Removing ProGet"
                . $PSScriptRoot\scripts\uninstall-repository.ps1
            } else {
                write-verbose "ProGet not installed"
            }
        
        }
    }
} finally {
    $env:OneGetModuleTest  = $ull
    cd $origdir 
}