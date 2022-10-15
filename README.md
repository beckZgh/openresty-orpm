# openresty-orpm

OpenResty Package Management

## 安装 orpm

```PowerShell

# 添加 dev 仓库
scoop bucket add dev https://github.com/killsen/scoop-dev

# 通过 scoop 安装 orpm
scoop install dev/orpm

```

## orpm 常用命令

```PowerShell

orpm version  # 版本 v1.1.0
orpm homepage # https://github.com/killsen/openresty-orpm

orpm init     # 创建 .openrestyrc 配置文件
orpm start    # 启动 nginx 服务
orpm stop     # 停止 nginx 服务

orpm update   # 升级 lua-resty-libs
orpm install  # 安装 lua-resty-libs

```

## 安装 lua-resty-lib

```PowerShell

orpm install  bungle/lua-resty-template@v2.0
orpm install  ledgetech/lua-resty-http@v0.16.1
orpm install  thibaultcha/lua-resty-mlcache@2.5.0

```
