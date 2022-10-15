﻿# 引入工具库
. $PSScriptRoot\utils.ps1
. $PSScriptRoot\install.ps1

$root = get_root_path

if ($root) {
    Write-Host "root: $root" -ForegroundColor Red
} else {
    Write-Host ".openrestyrc 文件不存在" -ForegroundColor Red
    return
}

try {
    $conf = Get-Content "$root/.openrestyrc" | ConvertFrom-JSON
} catch {
    Write-Host ".openrestyrc 文件读取失败" -ForegroundColor Red
    return
}

if (-not $conf.lua_resty_libs) {
    Write-Host "尚未安装 lua-resty-libs" -ForegroundColor Red
    return
}

function update_lib_ver($lib, $ver) {
    Write-Host "$lib@$ver" -ForegroundColor Yellow -NoNewline

    try {
        $url   = "https://github.com/$lib/tags"
        $links = (Invoke-WebRequest -Uri "$url").Links |
            Where-Object { $_.href -like "/$lib/archive/refs/tags/*.zip" }

        if ($links[0].href -match "/$lib/archive/refs/tags/(.+)\.zip") {
            if ($ver -eq $Matches[1]) {
                Write-Host " (版本一致) " -ForegroundColor Blue
            } else {
                $ver = $Matches[1]
                Write-Host " >> " -ForegroundColor Red -NoNewline
                install "$lib@$ver"
            }
            return
        }
    } catch {}

    Write-Host " (获取版本失败) " -ForegroundColor Red -NoNewline
    Write-Host "$url"
}

foreach($lib in $conf.lua_resty_libs.PSObject.Properties)
{
    if (-not ($lib.Value.StartsWith("#")) ) {
        update_lib_ver $lib.Name $lib.Value
    }
}
