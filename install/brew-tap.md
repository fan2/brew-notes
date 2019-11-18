
## brew 包源

[phinze/cask](https://github.com/phinze/homebrew-cask)  
[buo/cask-upgrade](https://github.com/buo/homebrew-cask-upgrade)  
[homebrew/cask-versions](https://github.com/Homebrew/homebrew-cask-versions)  
[homebrew/cask-fonts](https://github.com/Homebrew/homebrew-cask-fonts)  
[homebrew/cask-drivers](https://github.com/Homebrew/homebrew-cask-drivers)  

### tap

`brew tap <user/repo>`：添加软件源 —— https://github.com/user/homebrew-repo.  
`brew tap <URL>`：添加软件源 —— 任意 URL（git repo 地址）.  

执行 `brew help tap` 查看说明：

```Shell
--- ~ » brew help tap
Usage: brew tap [options] user/repo [URL]

Tap a formula repository.

List all installed taps when no arguments are passed.
```

不指定参数执行 `brew tap` 将会列举出现有 taps，一般会先更新现有 taps。

**常用命令**：

`brew tap <tap_name>`：将指定 tap 安装到本地。  
`brew untap <tap_name>`: Remove a tapped repository.

`brew tap`：查看本地所有已安装的 tap 列表（List all installed taps）。  

`brew tap-info`：查看本地所有已安装 tap 的概要信息（Display a brief summary of all installed taps）。  
`brew tap-info --installed`：查看本地所有已安装 tap 的信息（Display detailed information about one or more taps.）  
`brew tap-info <tap_name>`：查看本地具体某个已安装的 tap 信息。  

`brew tap-pin tap`: Pin tap, prioritizing its formulae over core when formula names are supplied by the user. See also tap-unpin.  
`brew tap --list-pinned`: List all pinned taps.  
`brew tap-unpin tap`: Unpin tap so its formulae are no longer prioritized. See also tap-pin.  

#### tap phinze/homebrew-cask

由于 brew 和包含的包源都是通过 github 来管理，人为的维护管理。除了默认的仓库，还允许别人的源添加进来。通过 [`brew tap`](http://icyleaf.com/2014/01/homebrew-hidden-commands/) 指定第三方包源。

默认的源是 `caskroom/cask`，以下显式 tap 原作者的源（`phinze/homebrew-cask`）：

```Shell
brew tap phinze/homebrew-cask
```

再执行 `brew install brew-cask` 即可从 phinze/homebrew-cask 安装 brew-cask。

```Shell
faner@MBP-FAN:~|⇒  brew install brew-cask
==> Installing brew-cask from phinze/homebrew-cask
==> Cloning https://github.com/caskroom/homebrew-cask.git
Cloning into '/Library/Caches/Homebrew/brew-cask--git'...

```

#### tap-info

`brew tap-info <tap>`：查看某个 tap 的具体信息。

执行 `brew help tap-info` 查看说明：

```Shell
--- ~ » brew help tap-info
Usage: brew tap-info [options] [taps]

Display detailed information about one or more provided taps.
Display a brief summary of all installed taps if no taps are passed.

        --installed                  Display information on all installed taps.
```

执行 `brew tap-info phinze/cask` 查看源 phinze/cask 的信息：

```Shell
~ ‹›  $ brew tap-info phinze/cask
phinze/cask: unpinned, 1 command, 4049 casks
/usr/local/Homebrew/Library/Taps/phinze/homebrew-cask (5,689 files, 149.6MB)
From: https://github.com/phinze/homebrew-cask
```

不指定参数执行 `brew tap-info`（`--installed`）查看所有已安装源的信息。

### untap

`brew untap <tap>`: 移除一个 tap 仓库（Remove a tapped repository）.

### tap-pin

`brew tap−pin <tap>`: Pin tap, **prioritizing** its formulae over core when formula names are supplied by the user.  

`brew tap --list-pinned` 可列举出所有已经固定的源（List all pinned taps）.

### tap−unpin

`brew tap−unpin tap`: Unpin tap so its formulae are **no longer prioritized**.  

`uninstall, rm, remove [−−force] [−−ignore−dependencies] formula`: Uninstall formula.

If `−−force` (or `−f`) is passed, and there are multiple versions of formula installed, delete all installed versions.  
If `−−ignore−dependencies` is passed, uninstalling won´t fail, even if formulae depending on formula would still be installed.  

## tap cask-versions

```Shell
~ » brew search IINA
==> Casks
iina                                iina                                homebrew/cask-versions/iina-beta
```

`直接执行 brew cask install iina` 可安装 iina；如果想安装 iina-beta，可指定 tap 路径执行 `brew cask install homebrew/cask-versions/iina-beta`。

相当于先执行 `brew tap homebrew/cask-versions`，再执行 `brew cask install iina-beta`。

```Shell
~ » brew tap homebrew/cask-versions
==> Tapping homebrew/cask-versions
Cloning into '/usr/local/Homebrew/Library/Taps/homebrew/homebrew-cask-versions'...
remote: Counting objects: 215, done.
remote: Compressing objects: 100% (211/211), done.
remote: Total 215 (delta 17), reused 41 (delta 3), pack-reused 0
Receiving objects: 100% (215/215), 85.83 KiB | 17.17 MiB/s, done.
Resolving deltas: 100% (17/17), done.
Tapped 195 casks (234 files, 321.9KB).
```

### brew search iina

```Shell
~ » brew search iina
==> Casks
iina                                iina                                iina-beta
```

### brew cask info iina

```Shell
~ » brew cask info iina
iina: 0.0.15.1 (auto_updates)
https://lhc70000.github.io/iina/
Not installed
From: https://github.com/Homebrew/homebrew-cask/blob/master/Casks/iina.rb
==> Name
IINA
==> Artifacts
IINA.app (App)
/Applications/IINA.app/Contents/MacOS/iina-cli -> iina (Binary)

~ » brew cask info iina-beta
iina-beta: 1.0.0-beta4-build91 (auto_updates)
https://lhc70000.github.io/iina/
Not installed
From: https://github.com/Homebrew/homebrew-cask-versions/blob/master/Casks/iina-beta.rb
==> Name
IINA
==> Artifacts
IINA.app (App)
/Applications/IINA.app/Contents/MacOS/iina-cli -> iina (Binary)
```

```Shell
~ » brew cask audit iina
audit for iina: passed

~ » brew cask audit iina-beta
audit for iina-beta: passed
```

### brew cask install iina-beta

```Shell
~ » brew cask install iina-beta
Updating Homebrew...
==> Satisfying dependencies
==> Downloading https://dl-portal.iina.io/IINA.v1.0.0-beta4-build91.dmg
==> Downloading from https://mirrors.tuna.tsinghua.edu.cn/iina/IINA.v1.0.0-beta4-build91.dmg
######################################################################## 100.0%
==> Verifying SHA-256 checksum for Cask 'iina-beta'.
==> Installing Cask iina-beta
==> Moving App 'IINA.app' to '/Applications/IINA.app'.
==> Linking Binary 'iina-cli' to '/usr/local/bin/iina'.
🍺  iina-beta was successfully installed!
```
