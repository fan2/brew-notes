brew cask installs macOS apps, fonts and plugins and other non-open source software.

```Shell
linkapps      -- symlink .app bundles provided by formulae into /Applications
```

# [brew cask](http://www.zhihu.com/question/22624898)

Homebrew 作为 Ruby 社区极富想象力的作品，使得 Mac 下安装 Mysql 等常用包不再困难。那么，是否也可以通过 `brew install mysql` 这样简单的方式来安装 Google Chrome 浏览器呢？为解决这一问题，phinze 的作品 [homebrew-cask](https://github.com/phinze/homebrew-cask) 应运而生。

## 关于（about）

Homebrew 可以管理 Mac 下的命令行工具（wget、node），**brew cask** 则是一套建立在 brew 上的**增强**命令行工具，支持管理 Mac 下的 GUI 程序，例如 qq、 google-chrome、evernote 等。  
cask 从镜像源下载已经编译好了的[应用软件二进制包](https://github.com/phinze/homebrew-cask/tree/master/Casks)（.dmg/.pkg）到本地解压到单独的目录（`/opt/homebrew-cask/Caskroom`）下，然后软链（symlink）到 `/Applications` 目录下。  
cask 包含了很多在 AppStore 里没有的常用软件，省掉了手动下载、解压、拖拽（安装）等步骤，且卸载也相当容易与干净，使用起来非常方便。

假设你已安装好了 Homebrew，执行以下命令查找 `cask` 包并显示软件包信息和依赖关系：

```Shell
faner@MBP-FAN:~|⇒  brew search cask
cask
homebrew/completions/brew-cask-completion

faner@MBP-FAN:~|⇒  brew info cask
cask: stable 0.7.3, HEAD
Emacs dependency management
https://cask.readthedocs.org/
Not installed
From: https://github.com/Homebrew/homebrew/blob/master/Library/Formula/cask.rb

faner@MBP-FAN:~|⇒  brew deps cask
emacs
```

## 安装（install）

安装 cask 极其简单，打开终端输入：

```Shell
brew tap phinze/homebrew-cask
brew install brew-cask
```

### brew tap phinze/homebrew-cask

由于 brew 和包含的包源都是通过 github 来管理，人为的维护管理。除了默认的仓库，还允许别人的源添加进来。通过 [`brew tap`](http://icyleaf.com/2014/01/homebrew-hidden-commands/) 指定第三方包源：

> $ brew tap <gihhub_user/repo>

默认的源是 `caskroom/cask`，以下显式 tap 原作者的源（`phinze/homebrew-cask`）：

```
faner@MBP-FAN:~|⇒  brew tap phinze/homebrew-cask
==> Tapping phinze/cask
Cloning into '/usr/local/Library/Taps/phinze/homebrew-cask'...
remote: Counting objects: 3278, done.
remote: Compressing objects: 100% (3202/3202), done.
remote: Total 3278 (delta 83), reused 731 (delta 59), pack-reused 0
Receiving objects: 100% (3278/3278), 5.82 MiB | 428.00 KiB/s, done.
Resolving deltas: 100% (83/83), done.
Checking connectivity... done.
Tapped 1 formula (3257 files, 24M)
```

### brew install brew-cask

```Shell
faner@MBP-FAN:~|⇒  brew install brew-cask
==> Installing brew-cask from phinze/homebrew-cask
==> Cloning https://github.com/caskroom/homebrew-cask.git
Cloning into '/Library/Caches/Homebrew/brew-cask--git'...
remote: Counting objects: 3248, done.
remote: Compressing objects: 100% (3172/3172), done.
remote: Total 3248 (delta 82), reused 771 (delta 59), pack-reused 0
Receiving objects: 100% (3248/3248), 5.82 MiB | 467.00 KiB/s, done.
Resolving deltas: 100% (82/82), done.
Checking connectivity... done.
Note: checking out 'd39c95942f4226fb6c0e1a56c11008695ddeeade'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by performing another checkout.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -b with the checkout command again. Example:

  git checkout -b <new-branch-name>

==> Checking out tag v0.59.0
🍺  /usr/local/Cellar/brew-cask/0.59.0: 2976 files, 12M, built in 32 seconds
```

本机已经安装了 `brew-cask` 的依赖软件 **`emacs`** :

```Shell
faner@MBP-FAN:~|⇒  whereis emacs
/usr/bin/emacs

faner@MBP-FAN:~|⇒  emacs --version
GNU Emacs 22.1.1
Copyright (C) 2007 Free Software Foundation, Inc.
GNU Emacs comes with ABSOLUTELY NO WARRANTY.
You may redistribute copies of Emacs
under the terms of the GNU General Public License.
For more information about these matters, see the file named COPYING.
```

如果没有安装 **`emacs`**，则 brew 在安装 cask 之前会自动帮我们下载安装 `emacs`：

```Shell
==> Installing dependencies for cask: emacs
==> Installing cask dependency: emacs
==> Downloading https://homebrew.bintray.com/bottles/emacs-24.5.yosemite.bottle.1.tar.gz
######################################################################## 100.0%
==> Pouring emacs-24.5.yosemite.bottle.1.tar.gz
==> Caveats
To have launchd start emacs at login:
  ln -sfv /usr/local/opt/emacs/*.plist ~/Library/LaunchAgents
Then to load emacs now:
  launchctl load ~/Library/LaunchAgents/homebrew.mxcl.emacs.plist
==> Summary
🍺  /usr/local/Cellar/emacs/24.5: 3915 files, 105M
```

## 常用子命令

执行 `brew cask` 或 `brew-cask` 可查看帮助概要（首次需输入 sudo 密码）：

```Shell
faner@MBP-FAN:~|⇒  brew cask
==> We need to make Caskroom for the first time at /opt/homebrew-cask/Caskroom
==> We'll set permissions properly so we won't need sudo in the future
Password:
brew-cask provides a friendly homebrew-style CLI workflow for the
administration of Mac applications distributed as binaries.

!! 
!! no command verb: 
!! 

Commands:

    audit      verifies installability of Casks
    cat        dump raw source of the given Cask to the standard output
    cleanup    cleans up cached downloads and tracker symlinks
    create     creates the given Cask and opens it in an editor
    doctor     checks for configuration issues
    edit       edits the given Cask
    fetch      downloads Cask resources to local cache
    home       opens the homepage of the given Cask
    info       displays information about the given Cask
    install    installs the given Cask
    list       with no args, lists installed Casks; given installed Casks, lists staged files
    search     searches all known Casks
    uninstall  uninstalls the given Cask
    update     a synonym for 'brew update'
    zap        zaps all files associated with the given Cask

See also "man brew-cask"
```

**brew cask 大部分命令和 brew 保持一致，新增了以下几条命令：**

命令				 | 说明
------------------|----------------------------
brew cask audit   | 查询指定 Cask 的可安装性
brew cask cat     | 查看指定 Cask 安装源信息
brew cask zap     | 打包指定 Cask
brew cask cleanup | 清理缓存及软链

安装了 cask 之后，就可以像 brew 一样来搜索安装软件，以下示例 google-chrome ：

## 搜索安装包

```Shell
faner@MBP-FAN:~|⇒  brew cask search google-chrome
==> Exact match
google-chrome
```

### 查询安装性

```Shell
faner@MBP-FAN:~|⇒  brew cask audit google-chrome
audit for google-chrome: passed
```

### 查询包信息

1.执行 `brew cask cat ` 查询指定 Cask 的源信息：

```Shell
faner@MBP-FAN:~|⇒  brew cask cat google-chrome
cask :v1 => 'google-chrome' do
  version :latest
  sha256 :no_check

  url 'https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg'
  name 'Google Chrome'
  homepage 'https://www.google.com/chrome/'
  license :gratis
  tags :vendor => 'Google'

  app 'Google Chrome.app'

  zap :delete => [
                  '~/Library/Application Support/Google/Chrome',
                  '~/Library/Caches/Google/Chrome',
                  '~/Library/Caches/com.google.Chrome',
                  '~/Library/Caches/com.google.Chrome.helper.EH',
                  '~/Library/Caches/com.google.Keystone.Agent',
                  '~/Library/Caches/com.google.SoftwareUpdate',
                  '~/Library/Google/GoogleSoftwareUpdate',
                  '~/Library/Logs/GoogleSoftwareUpdateAgent.log',
                 ],
      :rmdir  => [
                  '~/Library/Caches/Google',
                  '~/Library/Google',
                 ]

  caveats <<-EOS.undent
    The Mac App Store version of 1Password won't work with a Homebrew-Cask-linked Google Chrome. To bypass this limitation, you need to either:

      + Move Google Chrome to your /Applications directory (the app itself, not a symlink).
      + Install 1Password from outside the Mac App Store (licenses should transfer automatically, but you should contact AgileBits about it).
  EOS
end
```

2.执行 `brew cask info ` 查询指定 Cask 的包信息：

```Shell
faner@MBP-FAN:~|⇒  brew cask info google-chrome
google-chrome: latest
Google Chrome
https://www.google.com/chrome/
Not installed
https://github.com/phinze/homebrew-cask/blob/master/Casks/google-chrome.rb
==> Contents
  Google Chrome.app (app)
==> Caveats
The Mac App Store version of 1Password won't work with a Homebrew-Cask-linked Google Chrome. To bypass this limitation, you need to either:

  + Move Google Chrome to your /Applications directory (the app itself, not a symlink).
  + Install 1Password from outside the Mac App Store (licenses should transfer automatically, but you should contact AgileBits about it).

```

### 安装/卸载 应用

`brew-cask` 安装和卸载的命令同 `brew` ，都是使用 `install / uninstall` 。

1.执行 `brew cask install google-chrome` 命令安装 google-chrome：

```Shell
brew cask install google-chrome
faner@MBP-FAN:~|⇒  brew cask install google-chrome   
==> Caveats
The Mac App Store version of 1Password won't work with a Homebrew-Cask-linked Google Chrome. To bypass this limitation, you need to either:

  + Move Google Chrome to your /Applications directory (the app itself, not a symlink).
  + Install 1Password from outside the Mac App Store (licenses should transfer automatically, but you should contact AgileBits about it).

==> Downloading https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg
######################################################################## 100.0%
==> Symlinking App 'Google Chrome.app' to '/Users/faner/Applications/Google Chrome.app'
🍺  google-chrome staged at '/opt/homebrew-cask/Caskroom/google-chrome/latest' (216 files, 183M)

```

2.执行 `brew cask uninstall google-chrome` 命令卸载 google-chrome：

```Shell
faner@MBP-FAN:~|⇒  brew cask uninstall google-chrome
==> Removing App symlink: '/Users/faner/Applications/Google Chrome.app'
```

`uninstall` 命令将删除 `/opt/homebrew-cask/Caskroom/google-chrome` 及其在 `~/Applications/` 下的软链（symlink）。  
我们也可手动删除 homebrew 下载目录中缓存的 google-chrome 安装包  `/Library/Caches/Homebrew/google-chrome-latest.dmg` 及其软链 `/Library/Caches/Homebrew/Casks/google-chrome-latest.dmg` 。

### [升级更新软件](https://github.com/phinze/homebrew-cask/issues/309)

brew-cask 提供了 `outdated` 命令检测可升级性，然后执行 `upgrade` 命令可执行升级。

也可通过 DIY 升级具体软件：

1. 进入应用软件的【关于】，手动检查是否可更新升级，使用软件自己的更新流程。
2. 也可执行 `brew cask reinstall` (`brew cask uninstall ` && `brew cask install`) 重装，实现间接升级。

## brew-cask install 示例

### [文件预览插件](http://www.cocoachina.com/mac/20141112/10198.html)
有些插件可以让 Mac 上的文件预览更有效，比如语法高亮、markdown 渲染、json 预览等等。通过 `brew cask install` 命令可以安装这些插件：

```Shell
$ brew cask install qlcolorcode
$ brew cask install qlstephen
$ brew cask install qlmarkdown
$ brew cask install quicklook-json
$ brew cask install qlprettypatch
$ brew cask install quicklook-csv
$ brew cask install betterzipql
$ brew cask install webp-quicklook
$ brew cask install suspicious-package
```

### [Visual Studio Code](https://code.visualstudio.com/)

```Shell
~ $ brew cask search visual-studio-code
==> Exact match
visual-studio-code
~ $ brew cask cat visual-studio-code
cask :v1 => 'visual-studio-code' do
  version '0.10.1'
  sha256 'b71089670b3c2a259bf26ad6a6ad7b0abc9bb805353e8087f5c86361a5f8defc'

  # vo.msecnd.net is the official download host per the vendor homepage
  url "https://az764295.vo.msecnd.net/public/#{version}-release/VSCode-darwin.zip"
  name 'Visual Studio Code'
  homepage 'https://code.visualstudio.com/'
  license :mit
  tags :vendor => 'Microsoft'

  app 'Visual Studio Code.app'

  zap :delete => [
                  '~/Library/Application Support/Code',
                  '~/Library/Caches/Code',
                 ]
end
~ $ brew cask info visual-studio-code
visual-studio-code: 0.10.1
Visual Studio Code
https://code.visualstudio.com/
Not installed
https://github.com/caskroom/homebrew-cask/blob/master/Casks/visual-studio-code.rb
==> Contents
  Visual Studio Code.app (app)

~ $ brew cask audit visual-studio-code
audit for visual-studio-code: passed

~ $ brew cask install visual-studio-code
==> Downloading https://az764295.vo.msecnd.net/public/0.10.1-release/VSCode-darwin.zip
######################################################################## 100.0%
==> Symlinking App 'Visual Studio Code.app' to '/Users/fan/Applications/Visual Studio Code.app'
🍺  visual-studio-code staged at '/opt/homebrew-cask/Caskroom/visual-studio-code/0.10.1' (1675 files, 177M)
```

brew cask 安装目录：`/opt/homebrew-cask/Caskroom`。

### [Wireshark](https://www.wireshark.org/)

`search-info-cat-audit-install` 过程日志参考 [brew-cask install wireshark.log](http://pan.baidu.com/s/1bnKFxkr)。

## 参考

[Mac 利器：brew、brew cask、zsh](http://my.oschina.net/evilgod528/blog/306548)  
[Mac安装软件新方法：Homebrew-cask](http://www.yangzhiping.com/tech/homebrew-cask.html)  
[简洁优雅的macOS软件安装体验 - homebrew-cask](http://ksmx.me/homebrew-cask-cli-workflow-to-install-mac-applications/)  
[使用brew cask来安装Mac应用](http://blog.devtang.com/blog/2014/02/26/the-introduction-of-homebrew-and-brewcask/)  
[Mac下通过 brew 安装不同版本的 PHP](http://blog.csdn.net/flymorn/article/details/43112813)  

[Launchrocket 帮助管理 Homebrew 安装的服务](http://www.osxtoy.com/?p=2431)  
[homebrew cask 安装 launchrocket](http://my.oschina.net/gujianhan/blog/204122)
