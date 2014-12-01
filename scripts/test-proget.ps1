$origdir = (pwd)

try {
    cd $PSScriptRoot

    # where stuff is
    $root = resolve-path "$PSScriptRoot\.."
    $tools = "$root\tools"
    $proget = "$root\proget"
    $packages = "$root\packages"
    $temp= "$proget\temp"
    if( test-path $proget )  {
        return $true
    }
} finally {
    cd $origdir 
}

return $false