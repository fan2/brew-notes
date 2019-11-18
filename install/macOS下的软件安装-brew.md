Homebrew is written in Ruby,

It's all `Git` and `Ruby` underneath

[Homebrew Documentation](https://docs.brew.sh/)

# brew (homebrew)

**brew** 是从软件包仓库下载源代码码到本地进行解压，进而执行 `./configure` && `make install` ，将软件编译安装到单独的目录（`/usr/local/Cellar`）下，然后软链（symlink）到 `/usr/local` 目录下，同时会自动检测下载相关依赖库，并自动配置好各种环境变量。  
这个对程序员来说简直是福音，使用简单的指令就能快速安装、升级和卸载本地的各种开发环境。

## 安装 brew

brew 的安装很简单，使用一条 ruby 命令调用 curl 下载安装即可。

**1.macOS 上默认已安装 [ruby](https://www.ruby-lang.org/)：**

```Shell
faner@MBP-FAN:~|⇒  ruby -v
ruby 2.0.0p645 (2015-04-13 revision 50299) [universal.x86_64-darwin15]
```

**2.macOS 上默认已内置了 [curl](http://curl.haxx.se/)（Command Line URL Viewer）：**

```Shell
faner@MBP-FAN:~|⇒  curl --version
curl 7.43.0 (x86_64-apple-darwin15.0) libcurl/7.43.0 SecureTransport zlib/1.2.5
Protocols: dict file ftp ftps gopher http https imap imaps ldap ldaps pop3 pop3s rtsp smb smbs smtp smtps telnet tftp 
Features: AsynchDNS IPv6 Largefile GSS-API Kerberos SPNEGO NTLM NTLM_WB SSL libz UnixSockets
```

**说明：**

> **curl** 是基于跨平台网络协议库 [libcurl](http://blog.csdn.net/mac_cm/article/details/6670154) 的利用 URL 语法在命令行方式下工作的开源文件传输工具。  
> [curl常用命令](http://www.cnblogs.com/gbyukg/p/3326825.html) 可参考  [curl 详解](http://blog.csdn.net/fudesign2008/article/details/7608619)、[curl网站开发指南](http://www.ruanyifeng.com/blog/2011/09/curl.html)。  

### [旧的安装](http://blog.csdn.net/jiajiayouba/article/details/44261011)

很早之前，homebrew 的安装 url 是 `https://raw.github.com/Homebrew/homebrew/go/install`：

```Shell
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)" 
```

首次执行 `brew install` 安装软件时，将提示不能创建 `/usr/local/Cellar` 目录，原因是没有 `/usr/local` 的写权限。

```Shell
➜  ~  brew install node
Error: Could not create /usr/local/Cellar
Check you have permission to write to /usr/local
```

**[解决方法](http://segmentfault.com/q/1010000000505091)：**

> 执行 `chown` 命令改变 `/usr/local` 的所有者为 `whoami` ，`-R` 表示递归（Recursive）。

```Shell
➜  ~  whoami
faner

➜  ~  sudo chown -R faner /usr/local
```

### 新的安装

可以在 [brew 的官网首页](http://brew.sh/index.html) 中看到 Install Homebrew 安装指引：

```Shell
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

> 如果 `/usr/bin/` 已经在 PATH 中，可以执行 `ruby -e`。

最新的安装过程中将会要求输入密码授权 `sudo chown ${whoami} /usr/local/*` ：

```Shell
~ $ brew
-bash: brew: command not found

~ $ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
==> This script will install:
/usr/local/bin/brew
/usr/local/Library/...
/usr/local/share/man/man1/brew.1
==> The following directories will be made group writable:
/usr/local/.
/usr/local/bin
/usr/local/include
/usr/local/lib
/usr/local/lib/pkgconfig
==> The following directories will have their owner set to fan:
/usr/local/.
/usr/local/bin
/usr/local/include
/usr/local/lib
/usr/local/lib/pkgconfig
==> The following directories will have their group set to admin:
/usr/local/.
/usr/local/bin
/usr/local/include
/usr/local/lib
/usr/local/lib/pkgconfig

Press RETURN to continue or any other key to abort
==> /usr/bin/sudo /bin/chmod g+rwx /usr/local/. /usr/local/bin /usr/local/include /usr/local/lib /usr/local/lib/pkgconfig
Password:
==> /usr/bin/sudo /usr/sbin/chown fan /usr/local/. /usr/local/bin /usr/local/include /usr/local/lib /usr/local/lib/pkgconfig
==> /usr/bin/sudo /usr/bin/chgrp admin /usr/local/. /usr/local/bin /usr/local/include /usr/local/lib /usr/local/lib/pkgconfig
==> /usr/bin/sudo /bin/mkdir /Library/Caches/Homebrew
==> /usr/bin/sudo /bin/chmod g+rwx /Library/Caches/Homebrew
==> /usr/bin/sudo /usr/sbin/chown fan /Library/Caches/Homebrew
==> Downloading and installing Homebrew...
remote: Counting objects: 3847, done.
remote: Compressing objects: 100% (3691/3691), done.
remote: Total 3847 (delta 40), reused 520 (delta 21), pack-reused 0
Receiving objects: 100% (3847/3847), 3.31 MiB | 105.00 KiB/s, done.
Resolving deltas: 100% (40/40), done.
From https://github.com/Homebrew/homebrew
 * [new branch]      master     -> origin/master
HEAD is now at e191c00 jsonnet: update 0.8.5 bottle.
==> Installation successful!
==> Next steps
Run `brew help` to get started
~ $ 
```

## brew -v

安装完 brew，执行 `brew -v(--version)` 命令可以查看安装的 brew 版本信息：

```Shell
faner@MBP-FAN:~|⇒  brew -v
Homebrew 2.1.16
Homebrew/homebrew-core (git revision 4e6479; last commit 2019-11-16)
Homebrew/homebrew-cask (git revision 45cf4; last commit 2019-11-15)
```

## brew -h

执行 `brew -h` 或 `brew help` 查看帮助概要（Example usage、Troubleshooting、Brewing）：

> -h / --h / --help / help

```Shell
faner@MBP-FAN:~|⇒  brew
Example usage:
  brew search [TEXT|/REGEX/]
  brew info [FORMULA...]
  brew install FORMULA...
  brew update
  brew upgrade [FORMULA...]
  brew uninstall FORMULA...
  brew list [FORMULA...]

Troubleshooting:
  brew config
  brew doctor
  brew install --verbose --debug FORMULA

Contributing:
  brew create [URL [--no-fetch]]
  brew edit [FORMULA...]

Further help:
  brew commands
  brew help [COMMAND]
  man brew
  https://docs.brew.sh
```

1. 执行 `man brew` 可查看详细的 brew 帮助文档。  
2. 执行 `brew home` 可调用浏览器打开 brew 官方网站。  

## brew 常用命令

| 命令                   | 说明                                                          |
| ---------------------- | ------------------------------------------------------------|
| brew update            | 更新 brew                                                    |
| brew search FORMULA    | 查找软件包，可使用正则表达式                                     |
| brew info FORMULA      | 显示软件的信息                                                 |
| brew deps FORMULA      | 显示包依赖                                                    |
| brew install FORMULA   | [安装软件包](http://www.cnblogs.com/TankXiao/p/3247113.html)  |
| brew uninstall FORMULA | 卸载软件包                                                    |
| brew list              | 列出已安装的软件包，可指定 FORMULA                               |
| brew outdated          | 列出可升级的软件包                                             |
| brew upgrade           | 更新已安装的软件包，可指定 FORMULA                              |
| brew doctor            | 诊断 homebrew 环境                                           |
| brew prune             | 删除 /usr/local 下的无效链接(remove broken symlinks)           |

### brew info

**`brew info`** 显示软件包信息，一般包括：

- 软件概要信息
- 本地是否已安装：Not installed / Poured from bottle
- 依赖包：==> Dependencies，Build、Required、Recommended、Optional
- 编译、安装选项： ==> Options
- 预警信息：==> Caveats

[brew info 查看 plist 文件](https://ruby-china.org/topics/21050)

### brew install

#### brew install tree

linux 下的 **[tree](http://mama.indstate.edu/users/ice/tree/)** 命令以树形结构显示文件目录结构，Mac 下默认并没有该命令，只有普通的 **`ls`** 命令。可以利用 brew 查找并安装 tree 命令行工具：

```Shell
faner@MBP-FAN:~|⇒  brew search tree
git-stree       mvptree         pstree          tree            treecc          treeline
homebrew/emacs/dict-tree        homebrew/science/quicktree      Caskroom/cask/treemaker
homebrew/emacs/undo-tree        homebrew/x11/prooftree          Caskroom/cask/treesheets
homebrew/emacs/ztree-emacs      Caskroom/cask/figtree
homebrew/science/fasttree       Caskroom/cask/sourcetree

faner@MBP-FAN:~|⇒  brew info tree
tree: stable 1.7.0 (bottled)
Display directories as trees (with optional color/HTML output)
http://mama.indstate.edu/users/ice/tree/
Not installed
From: https://github.com/Homebrew/homebrew/blob/master/Library/Formula/tree.rb
faner@MBP-FAN:~|⇒  brew deps tree

faner@MBP-FAN:~|⇒  brew install tree
==> Downloading https://homebrew.bintray.com/bottles/tree-1.7.0.el_capitan.bottle.1.tar.gz
######################################################################## 100.0%
==> Pouring tree-1.7.0.el_capitan.bottle.1.tar.gz
🍺  /usr/local/Cellar/tree/1.7.0: 7 files, 128K

faner@MBP-FAN:~|⇒  tree --version
tree v1.7.0 (c) 1996 - 2014 by Steve Baker, Thomas Moore, Francesc Rocher, Florian Sesser, Kyosuke Tokoro
```

1. homebrew 下载已经编译好的二进制包 tree 到缓存目录 `/Library/Caches/Homebrew/tree-1.7.0.el_capitan.bottle.1.tar.gz`；  
2. 解压 `tree-1.7.0.el_capitan.bottle.1.tar.gz` 到 `/usr/local/Cellar/tree/` 目录，根据版本存放到文件夹 `1.7.0` 下；  
3. 将 `/usr/local/Cellar/tree/1.7.0/bin/tree` 软链到 `/usr/local/bin/tree`，后者是前者的替身，执行 **tree** 命令时，真正调用的是其在 Cellar 中的真身。

#### brew install axel

以下示例查找比 wget 下载速度高几倍的支持[断点续传](http://www.pooy.net/axel-download-helper.html)的[多线程](http://www.cnblogs.com/SunWentao/archive/2008/07/10/1239924.html)下载 CLI 命令行工具 **[axel](http://wilmer.gaast.net/main.php/axel.html)**，并显示软件包信息和依赖关系，然后安装该工具：

```Shell
faner@MBP-FAN:~|⇒  brew search axel
axel

faner@MBP-FAN:~|⇒  brew info axel
axel: stable 2.4 (bottled)
Light UNIX download accelerator
https://packages.debian.org/sid/axel
Not installed
From: https://github.com/Homebrew/homebrew/blob/master/Library/Formula/axel.rb

faner@MBP-FAN:~|⇒  brew deps axel
faner@MBP-FAN:~|⇒  

faner@MBP-FAN:~|⇒  brew install axel
==> Downloading https://homebrew.bintray.com/bottles/axel-2.4.el_capitan.bottle.1.tar.gz
###############################################                           66.5%
curl: (56) SSLRead() return error -9806
Error: Failed to download resource "axel"
Download failed: https://homebrew.bintray.com/bottles/axel-2.4.el_capitan.bottle.1.tar.gz
Warning: Bottle installation failed: building from source.
==> Downloading https://mirrors.ocf.berkeley.edu/debian/pool/main/a/axel/axel_2.4.orig.tar.gz
######################################################################## 100.0%
==> ./configure --prefix=/usr/local/Cellar/axel/2.4 --debug=0 --i18n=0
==> make
==> make install
🍺  /usr/local/Cellar/axel/2.4: 8 files, 104K, built in 13 seconds
faner@MBP-FAN:~|⇒  axel -V
Axel version 2.4 (Darwin)

Copyright 2001-2002 Wilmer van der Gaast.
```

1. 从 homebrew 官方仓库 `homebrew.bintray.com` 下载 axel 失败后，自动从镜像源 `mirrors.ocf.berkeley.edu` 重新下载。下载的源码缓存到目录 `/Library/Caches/Homebrew/axel-2.4.tar.gz`；  
2. 下载完成后，依次执行 `./configure`、`make` 和 `make install` 将软件编译安装到 `/usr/local/Cellar/axel/` 目录下，根据版本存放到文件夹 `2.4` 下；  
3. 将 `usr/local/Cellar/axel/2.4/bin/axel` 软链到 `/usr/local/bin/axel`，后者是前者的替身，执行 axel 命令时，真正调用的是其在 Cellar 中的真身。

#### brew install [subversion](https://subversion.apache.org/packages.html#osx)

`search-info-deps-install` 过程日志参考 [brew install subversion.log](http://pan.baidu.com/s/1genD2JT)。
