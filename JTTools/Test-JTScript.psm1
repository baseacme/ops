function Test-JTScript {   
    function TF {
        param (
            $TFParam,
            $TFParam2
        )
        Write-host -ForegroundColor Yellow "Inside TF Function"
        $MyInvocation
    }
    Write-host -ForegroundColor Yellow "Inside Test-JTSCript function"
    $MyInvocation
    TF -TFParam TFParamInput -TFParam2 TFParamInput2
}
Export-ModuleMember -Function Test-JTScript