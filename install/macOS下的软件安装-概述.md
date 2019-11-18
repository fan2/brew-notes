
## [linux 软件的安装与管理](http://blog.chinaunix.net/uid-509190-id-3056219.html)

[linux](https://github.com/torvalds/linux) 是一套免费使用和自由传播的基于 POSIX 和 UNIX 的多用户、多任务、支持多线程和多 CPU 的开源的类 Unix 操作系统。

由于 linux 操作系统开放源代码，因而在其上安装的大部分也都是开源软件。开源软件的开发者往往仅需在开源代码托管平台上发布一份源码包，用户即可自由下载源码包到本地，基于源码包编译安装软件。这倒是非常符合 C 语言的设计哲学：一次编写，到处编译。

### [基于源码安装软件](http://www.cnblogs.com/huangfenghit/archive/2011/02/17/1957057.html)

基于源码安装软件一般由以下几个步骤组成：

- 下载解压源码  
- 阅读 README、INSTALL 等说明文档，这一步至关重要  
- 分析安装平台环境（ifconfigure）  
- 编译安装软件（make，make install）  

基于源代码安装软件的好处是：用户可以自由配置编译选项，按需编译实现功能定制，极大地满足**[个性化需求](http://www.zhihu.com/question/21949923)**。此外，用户还可以自己选择安装路径，方便管理。卸载软件也很方便，只需删除对应的安装目录即可。

但是，配置、编译命令需要了解操作系统本身，并且依赖开源项目所使用的编程语言对应的工具链。为了使用一个应用软件，用户需要熟悉 linux 系统的文件组织架构和一堆  Shell 交互命令，还得解决编译过程中可能涉及到的繁杂的依赖关系。一定的英文水平也是必需的，关键是要有折腾不息的精神和顽强的动手能力！

English、OS、Linux、命令行交互方式、...，这些令人望而却步的门槛足以将普通用户拒之门外。安装后，你可能都不知道[安装到哪里去了](http://www.linuxidc.com/Linux/2009-11/22842.htm)；甚至离开了 Windows 桌面，你都不知道从哪里启动软件。我依稀地记得刚接触 linux 那会儿，为了能在 linux 上播放个视频文件，废了老大劲才安装好一个 [MPlayer](http://blog.pfan.cn/xman/41044.html)。当时就森森地觉得 linux 真不是一般人能折腾得起，尽管现在已经折腾惯了，但依然觉得费脑伤神。

作为一个曾经的[计算机旁系学生](http://www.tinylab.org/why-computer-students-learn-linux-open-source-technologies/)（自动化，别名计算机控制）、现在的半职业化软件攻城狮（涉猎甚广，浅显浮泛）和伪自由软件追崇者（用过盗版，不懂破解，从无贡献），因为工作关系经常穿梭于 Windows 和 macOS 之间（游离其间，无所专精），不折腾下 Linux/Unix 都觉得没法混 github。

尽管对于 vim 键盘型用户（估计基本都是程序员吧），很喜欢那种游离于指尖的"自由感"，但对于普通鼠标型 Windows 用户，[若无力驾驭，自由便是负担。](http://www.zhihu.com/question/20117703)  

> 只有开发人员才需要学习一个操作系统本身，用户只需要学习操作系统里面的每个“应用程序”怎么使用。 
> —— Linus Torvalds

### DPKG / RPM

伴随着 linux 的发展普及，linux 开发商开始在固定的硬件平台与操作系统上将要安装或升级的软件**编译好**，然后将这个软件的所有相关文件**打包**成一个特殊格式的文件。在这个软件内，还包含了预先检测系统与依赖软件（或动态链接库）的脚本，并提供记载该软件提供的所有文件信息等，最终将这个软件发布。

客户端取得软件后，只要通过特定的命令来安装，那么该软件就会按照内部的脚本来检测相关的前驱软件是否存在。若安装的环境和条件符合要求，则开始安装。软件在安装完成后，还会将信息写入软件管理机制中，以便完成未来的升级、删除（反安装）等操作。

目前，在 Linux 界最常见的软件安装方式有两种：

1. DPKG

	- **DPKG**（Debian Packager）是由 [Debian Linux](https://www.debian.org/) 社区所开发出来的，著名的 `package` 概念由此被引入到 GNU/Linux 系统中。
	- 通过 DPKG 机制，Debian 提供的软件就能够简单安装起来，同时还能提供安装后的软件信息。派生于 Debian 的其他 [Linux](https://zh.wikipedia.org/wiki/Linux%E5%8F%91%E8%A1%8C%E7%89%88%E5%88%97%E8%A1%A8) [Distributions](http://distrowatch.com/) 大多使用 dpkg 机制来管理软件，包括 [B2D](http://distrowatch.com/table.php?distribution=b2d)、[Ubuntu](http://www.ubuntu.com/global)、[Linux Mint](http://linuxmint.com/) 等。
	- Debian 为解决软件包更新问题，引入了 **APT**（Advanced Package Tool）[在线升级机制](http://www.cnblogs.com/kulin/archive/2012/07/31/2616490.html)，并在 `/etc/apt/sources.list` 文件列出了可获得软件包的镜像站点地址。
		- APT 由几个名字以 `apt-` 打头的程序组成，apt-get、apt-cache 和 apt-cdrom 是处理软件包的命令行工具。
		- apt 作为 dpkg 的前端工具，自动管理关联文件和维护已有配置文件，拥有出色的解决软件依赖问题的能力。

2. RPM

	-  **RPM**（RedHat Package Manager）是由 Red Hat 公司所开发出来的软件包管理程序。除了可以用来安装（-i）外，还可以进行查询（-q）、验证（-V）、更新（-U）、删除（-e）等操作，这些功能选项让软件的管理更加方便。包括 [Fedora](https://getfedora.org/)、[CenterOS](https://www.centos.org/)、[SUSE](https://www.suse.com/)/[openSUSE](https://www.opensuse.org/) 等知名的 linux 发行版本都使用 RPM 作为软件安装的管理机制。
	- RPM 包的封装格式一般有两种，分别是 **RPM** 和 **SRPM**。RPM 格式的文件 `xxx.rpm` 内含已经经过编译的二进制包和配置文件等数据。SRPM（Source RPM）对应的 RPM 文件类似于 `xxx.src.rpm` 格式，它包含了源码文件和一些编译指定的参数文件。因而，在使用的时候，需要先以 RPM 管理的方式编译为 RPM 文件([rpmbuild](http://www.centoscn.com/CentOS/2014/1029/4015.html)，再将编译完成的 RPM 文件安装到 Linux 系统中。
	- RPM 无法自动解决软件的依赖关系，使用与 APT 对应的 **[YUM](http://www.cnblogs.com/mchina/archive/2013/01/04/2842275.html)** ([Yellowdog](http://www.fixstars.com/en/technologies/linux/) Updater Modified) 机制可以**解决属性依赖问题**。**[YUM](http://www.cnblogs.com/chuncn/archive/2010/10/17/1853915.html)** 作为基于 RPM 的 Shell 前端软件包管理器，主要用于自动升级、安装/移除 RPM 软件包。它能够自动查找并解决 RPM 包之间的依赖关系，而无需管理员逐个手工的去安装每一个 RPM 包。

Distribution 代表 | 包管理机制 | 使用命令        | 在线升级机制(命令)
-----------------|-----------|---------------|-------------------
Red Hat / Fedora | RPM       | rpm，rpmbuild | YUM(yum)
Debian / Ubuntu  | DPKG      | dpkg          | APT(apt-get)

在 [linux 众多发行版](http://mitblog.pixnet.net/blog/post/41037058-10-%E5%A5%97-linux-%E4%BD%9C%E6%A5%AD%E7%B3%BB%E7%B5%B1%E7%9A%84%E6%AF%94%E8%BC%83%E3%80%81ubuntu-vs-fedora-vs-cen)中，ubuntu 占领桌面，RHEL/[CentOS](http://www.g-loaded.eu/2009/10/05/fedora-server-vs-centos/) 占领服务器，比较小众的 **[Gentoo](https://www.gentoo.org/)** 采用独特的 **[Portage](https://zh.wikipedia.org/wiki/Portage)** 包管理系统。Gentoo 的软件树称为 Portage，对应的包管理器是 emerge，包元文件称为 ebuild。

Gentoo 是个强调能自由选择的分发版，它使用源码来做包管理的方式。由于能自己编译及调整源码依赖等选项，而获得至高的自定义性及优化的软件，在源码包也有相当多新旧版本的选择，因此吸引了许多狂热爱好者以及专业人士。

#### [RPM / SRPM](http://linux.vbird.org/linux_basic/0520rpm_and_srpm.php)

RPM 软件包命名规范：`name-version-release.arch.rpm`。  
其中，`version` 表示系统的发行版，如 fc18、el6 表明这个软件包是在 Fedora 18、RHEL 6.x / CentOS 6.x 下使用的；`arch` 表示硬件平台，常见的有 i386、x86_64 等。

**`rp-pppoe-3.1-5.i386.rpm`** 是一个典型的 RPM 安装包，它由几个部分构成：

- `rp-pppoe`：名称
- `3.1`：版本信息
- `5`：发布次数
- `.i386`：适合的硬件平台
- `.rpm`：扩展名

RPM 文件必须要在相同的 linux 环境才能安装，而 SRPM 是源代码格式。我们可以通过修改 SRAM 内的参数，按需编译生成适合我们 linux 环境的 RPM 文件，而不必与原作者打包的 Linux 环境相同。  
通常一个软件在发布的时候，都会同时释放出该软件的 RPM 与 SRPM。

文件格式 | 扩展名格式    | 直接安装与否 | 内含程序类型 | 可否修改参数并编译
--------|-------------|-----------|-------------|----------------
RPM     | `xxx.rpm`     | √         | 已编译       | ×
SRPM    | `xxx.src.rpm` | ×         | 未编译的源码  | √

RPM 建包的原理并不复杂，可以理解为按照标准的格式整理一些信息，包括：软件基础信息，以及安装、卸载前后执行的[脚本](http://hlee.iteye.com/blog/343499)，对源码包解压、打补丁、编译，安装路径和文件等。我们可以基于标准规范，来[使用 rpmbuild 制作自己的 RPM 包](http://hlee.iteye.com/blog/343499)。

## [Mac 软件包管理工具](https://github.com/pubyun/macdev/blob/master/basic.md)

linux 平台下的 apt-get 和 yum 命令行工具分别适用于 deb、rpm 包管理方式的发行版本，主要用于自动从互联网的软件仓库中搜索、安装、升级和卸载软件。在 macOS 平台下，除了直接从 AppleStore 下载认证上架的软件进行安装外，还可以在系统偏好设置的【安全性与隐私】中允许从**任何来源**下载的应用。  

### dmg & pkg

一些应用会提供 [dmg、pkg](http://www.xitongzhijia.net/xtjc/20150303/39862.html) 安装包，例如 `git-2.5.3-intel-universal-mavericks.dmg`、`Subversion-1.9.2_10.10.x.pkg`。

1. **dmg** 是苹果的压缩镜像文件（类似 Windows 下的 iso ），它是 Mac 应用软件通用的打包格式（相当于 ipa），里面一般包含 `应用程序.app` 的图标和一个应用程序文件夹（`/Applications`）快捷方式，直接将 `应用程序.app` 拖曳至应用程序文件夹即可完成安装。卸载也同样绿色，直接在 `Launchpad` 中或 cd 到 `/Applications` 目录下删除应用（文件夹）即可。

2. **[pkg](https://en.wikipedia.org/wiki/.pkg)** 属于系统级软件的安装程序，相当于 iOS 越狱后装的 deb，一般会修改系统配置，权限较高。pkg 安装一般要求 sudo 授权，[卸载 pkg 安装的应用](http://blog.csdn.net/play_fun_tech/article/details/27964861) 也比较麻烦。pkg 类似 Windows 下的安装程序 Setup.exe 和 *.[msi](https://msdn.microsoft.com/en-us/library/cc185688)。

	Windows 下可以使用 [Install Shield](http://www.flexerasoftware.com/producer/products/software-installation/installshield-software-installer/) 来 [制作安装程序](http://www.yesky.com/460/1843460.shtml)，可使用 Xcode 自带的 [PackageMaker](http://www.identityfinder.com/kb/Enterprise-Documentation/046141) 或打包命令行工具 [pkgbuild](http://developer.apple.com/library/mac/documentation/Darwin/Reference/Manpages/man1/pkgbuild.1.html)+[productbuild](https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man1/productbuild.1.html)+[pkgutil](https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man1/pkgutil.1.html) 或 [Iceberg](http://s.sudre.free.fr/Software/Iceberg.html)（an Integrated Packaging Environment (IPE) ）来[制作安装包](http://blog.csdn.net/handsomerocco/article/details/7761212)。

3. **mpkg**：pkg 是单个[应用程序的安装包](http://blog.csdn.net/dongdongdongjl/article/details/7896771)，而 mpkg（multi pkg）是多个 pkg 。我们来看一下从 AppleStore 下载的 OS X EI Capitan 安装器文件——`安装 OS X EI Capitan.app` 的 `/Contents/SharedSupport` 目录：

	```Shell
	faner@MBP-FAN:/Applications/Install OS X El Capitan.app/Contents/SharedSupport|
	⇒  tree 
	.
	├── InstallESD.dmg
	└── OSInstall.mpkg
	
	0 directories, 2 files
	```

	> 下载完 `安装 OS X EI Capitan.app` 之后，可以使用 **`createinstallmedia`** 命令[制作 U 盘安装盘](http://bbs.feng.com/read-htm-tid-9930245.html)，或[恢复到 U 盘制作启动盘](http://bbs.feng.com/read-htm-tid-5045869.html)。

4. **dmg with pkg**：像 `git-2.5.3-intel-universal-mavericks.dmg` 这种 dmg 打包的是 git command CLI 的安装 pkg，需要使用 DiskImageMounter 挂载 dmg，然后打开 pkg（使用 Installer），按照引导一步步 next 即可安装完成。当然也可使用 [命令行](http://www.it165.net/os/html/201207/2764.html) 完成挂载安装操作。

除了使用 dmg、pkg 来安装软件外，Mac 下同样有优秀的软件包管理工具，可以下载、安装和管理大量 AppleStore 没有提供、而又经常会用到的开源软件。我们有两种选择 —— MacPorts 和 Homebrew。

### [MacPorts](http://www.macports.org/)

[MacPorts](http://chenpeng.info/html/1753) (DarwinPorts) 是由 [FreeBSD](http://www.freebsd.org/) 的 port 移植而来的软件包管理系统，，用来简化 macOS和 Darwin 操作系统上软件的安装。在 Mac 中安装 MacPorts [让你在Mac 的 Shell 下更加游刃有余](http://www.linuxidc.com/Linux/2012-01/52111.htm)。  
[MacPorts](http://blog.csdn.net/maojudong/article/details/7918278) 有个原则，对于软件包之间的依赖，都在 MacPorts 内部（`/opt/local`）解决，无论系统本身是否包含了需要的库，都不会加以利用。这使得 MacPorts 庞大臃肿，导致系统出现大量软件包的冗余，占用不小的磁盘空间，同时稍大型一点的软件编译时间都会难以忍受。

### [Homebrew](http://brew.sh/)

[Homebrew](http://blog.csdn.net/delphiwcdj/article/details/19679891)（简称 brew）是 macOS 不可或缺的软件管理工具(The missing package manager for OS X)，[让 Mac 拥有类似 apt-get 的功能](http://snowolf.iteye.com/blog/774312)，用以简化软件的安装、升级和卸载过程。

> **Homebrew** is the easiest and most flexible way to install the UNIX tools.

Homebrew 是一款使用 Ruby 进行开发的托管于 [GitHub](https://github.com/Homebrew/homebrew) 上的自由及开放源代码的软件包管理系统，通过用户的贡献扩大对软件包的支持。

### MacPorts vs Homebrew

MacPorts 和 Homebrew 这两种包管理系统的工作方式都是下载源代码，然后在本地编译。但是这两种包管理系统还是存在很大差异的，主要差异有以下三点：

- MacPorts 的理念是尽量减少对系统现有库的依赖，编译时间较长；而 Homebrew 则是尽量依赖系统现有库，编译时间会显著减少。
- MacPorts 的 Package 是安装到 `/opt/local` ，不会与系统现有的软件发生冲突；而 Homebrew 的 Package 是安装到 `/usr/local`，可能与系统自带的软件发生冲突。
- Macports 使用 rsync 进行同步（[也可以使用svn](https://trac.macports.org/wiki/howto/SyncingWithSVN)），而 Homebrew 使用 git 进行同步。

总体来说，Homebrew 使用简单，编译时间短，比较适合新手使用。MacPorts 编译时间长，命令还要带上 sudo，易用性上没有 Homebrew 好，但是比较干净，适合有洁癖的人使用。

以上梳理了 Linux 和 Mac 下的包管理机制，下面重点介绍 macOS 上的包管理 CLI 命令行工具 brew 及其增强工具 brew-cask。
