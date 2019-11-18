
## brew switch

macOS 下可调用 `brew switch` 命令切换已安装的 node 版本。

如果之前未执行过 `brew prune`，`/usr/local/Cellar/node/` 目录下可能还残存过往安装的历史版本，此时可通过 `brew switch node <version>` 切换 node 到指定历史版本。

执行 `brew switch -h` 查看 switch 命令简介：

```
➜  ~  brew switch -h
brew switch formula version:
    Symlink all of the specific version of formula's install to Homebrew prefix.
```

执行 `tree -L 1 /usr/local/Cellar/node` 可查看 `/usr/local/Cellar/node` 下尚未删除的 node 历史版本。

```
~ tree -L 1 /usr/local/Cellar/node
/usr/local/Cellar/node
├── 10.10.0
├── 10.11.0
├── 10.12.0
└── 11.0.0

4 directories, 0 files
```

执行 `brew switch node 10.12.0` 切换到 node 10 最后一个版本。

```
~ brew switch node 10.12.0
Cleaning /usr/local/Cellar/node/10.11.0
Cleaning /usr/local/Cellar/node/10.12.0
Cleaning /usr/local/Cellar/node/11.0.0
Cleaning /usr/local/Cellar/node/10.10.0
7 links created for /usr/local/Cellar/node/10.12.0
```

重新执行 `node -v`，可以看到 node 已切回 v10.12.0 版本：

```
~ node -v
v10.12.0
```

## brew pin/unpin

为防止未来的几个不稳定版本在 upgrade 时自动升级，可以执行 `brew pin node` 阻止 node 更新，在短期内将 node 固定在 v10.12.0 版本。  
等到 node 更新到已解决问题的稳定版本 v11.1.0 或 v.11.2.0 时，再执行 `brew unpin node` 解除禁止更新限制。  

## brew install

[brew如何安装指定版本的subversion?](https://www.oschina.net/question/218583_2269101)  
[用Homebrew安装指定版本软件](https://www.jianshu.com/p/84d79beb469c)  

`homebrew/versions` 这个 tap 源已经不可用了：

```
┌─[faner@MBP-FAN] - [~] - [2018-11-22 10:25:44]
└─[0] brew tap homebrew/versions
Error: homebrew/versions was deprecated. This tap is now empty as all its formulae were migrated.
```

> This tap was **deprecated** because homebrew/core has started to support multiple versions.  

---

如果之前执行过 `brew prune`，可能清除了安装在 `/usr/local/Cellar/node/` 下的历史版本，此时无法再通过 `brew switch` 来切换 node 历史版本了。

实际上 brew install 本身支持 `brew install <formula>@<version>`，从 tap 中安装某个软件指定主版本的最后一个 LTS 版本。

`homebrew/cask-versions` 这个源还在用。  

### search

执行 `brew search node`，可以看到有 `node@6`、`node@8`、`node@10` 等历史版本可供选择安装。

```
~ » brew search node                                                                                    ~
==> Formulae
leafnode          llnode            node-build        node@6            node_exporter     nodeenv
libbitcoin-node   node ✔            node@10           node@8            nodebrew          nodenv
```

其中 @ 符号后的 10 即主版本号，执行 `brew info node@10` 可知 `node@10` 对应 node10 的最后一个 LTS 版本 —— node 10.13.0：

### info

```
~ » brew desc node@10                                                                                   ~
node@10: Platform built on V8 to build network applications

~ » brew info node@10                                                                                   ~
node@10: stable 10.13.0 (bottled) [keg-only]
Platform built on V8 to build network applications
https://nodejs.org/
Not installed
From: https://mirrors.ustc.edu.cn/homebrew-core.git/Formula/node@10.rb
==> Dependencies
Build: pkg-config ✔, python@2 ✔
Recommended: icu4c ✔
Optional: openssl ✔
==> Options
--with-openssl
	Build against Homebrew's OpenSSL instead of the bundled OpenSSL
--without-icu4c
	Build with small-icu (English only) instead of system-icu (all locales)
--without-npm
	npm will not be installed
==> Caveats
node@10 is keg-only, which means it was not symlinked into /usr/local,
because this is an alternate version of another formula.

~ » brew deps node@10                                                                                   ~
icu4c
```

### brew install node@10

执行 `brew install node@10` 安装 node 10.13.0：

```
~ » brew install node@10                                                                                ~
Updating Homebrew...
==> Downloading https://mirrors.ustc.edu.cn/homebrew-bottles/bottles/node@10-10.13.0.mojave.bottle.tar.gz
######################################################################## 100.0%
==> Pouring node@10-10.13.0.mojave.bottle.tar.gz
==> Caveats
node@10 is keg-only, which means it was not symlinked into /usr/local,
because this is an alternate version of another formula.

If you need to have node@10 first in your PATH run:
  echo 'export PATH="/usr/local/opt/node@10/bin:$PATH"' >> ~/.zshrc

For compilers to find node@10 you may need to set:
  export LDFLAGS="-L/usr/local/opt/node@10/lib"
  export CPPFLAGS="-I/usr/local/opt/node@10/include"

==> Summary
🍺  /usr/local/Cellar/node@10/10.13.0: 3,630 files, 45.6MB
```

> 可考虑携带 `-v` 选项执行 `brew install node@10 -v` 查看更详细的安装过程输出 verbose 信息。

从安装输出的 Caveats 信息可知，安装的 node@10 是 keg-only，没有自动 symlink 到 `/usr/local` 目录下。

执行 `node -v` 提示还是 brew upgrade 的 node 11 版本：

```
~ » node -v                                                                                             ~
v11.2.0
```

`/usr/local/Cellar/node` 目录下也没有 node@10：

```
~ » tree -L 1 /usr/local/Cellar/node                                                                    ~
/usr/local/Cellar/node
└── 11.2.0

1 directory, 0 files
```

执行 `readlink` 或 `ls -al` 可知，`/usr/local/opt/node@10` 实际上是 `/usr/local/Cellar/node@10` 的替身软链：

```
~ » readlink /usr/local/opt/node@10                                                                     ~
../Cellar/node@10/10.13.0

~ » ls -al /usr/local/opt/node@10                                                                       ~
lrwxr-xr-x  1 faner  admin    25B Nov 22 22:03 /usr/local/opt/node@10@ -> ../Cellar/node@10/10.13.0

```

按照安装输出的 Caveats 信息，需要将 node@10（`/usr/local/opt/node@10/bin`） 添加到 PATH 靠前位置，这样 node@10 优先 node@11 被找到，从而实现替换。

以下仅在当前 shell 中修改 PATH 测试：

```
~ echo $PATH
/Users/faner/.oh-my-zsh/custom/plugins/git-open:/Library/Frameworks/Python.framework/Versions/3.5/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/Applications/Wireshark.app/Contents/MacOS:/opt/X11/bin:/Users/faner/.rvm/bin
~ node -v
v11.2.0
~ PATH="/usr/local/opt/node@10/bin:$PATH"
~ echo $PATH
/usr/local/opt/node@10/bin:/Users/faner/.oh-my-zsh/custom/plugins/git-open:/Library/Frameworks/Python.framework/Versions/3.5/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/Applications/Wireshark.app/Contents/MacOS:/opt/X11/bin:/Users/faner/.rvm/bin
~ node -v
v10.13.0
```

如需所有 shell 都生效，请按 Caveats 说明执行 `echo 'export PATH="/usr/local/opt/node@10/bin:$PATH"' >> ~/.zshrc` 将其写入 `.zshrc`（或 `.bash_profile`），这样每次启动 shell 都会 export PATH。

### brew install node 10.12.0 ？

`brew install node@10` 默认安装 node10 的最后一个版本 10.13.0，如何安装更古老的 node 10.12.0 版本呢？

打开 https://mirrors.ustc.edu.cn/homebrew-bottles/bottles/ 搜索其下的 node@10：

![node@10](./images/node@10.png)

下载 **`node@10-10.12.0.mojave.bottle.tar.gz`** 到本地，解压出的 `node@10/10.12.0` 移动到 `/usr/local/Cellar/` 目录下（即 `/usr/local/Cellar/node@10/10.12.0`），再效仿 `brew install node@10`（node@10/10.13.0）的做法：

1. 将 `/usr/local/Cellar/node@10/10.12.0` 软链（symlink）到 `/usr/local/opt/node@10`（替换 `10.13.0`）；  

    > sudo ln -Ffs /usr/local/Cellar/node@10/10.12.0 /usr/local/opt/node@10/

2. 将 `/usr/local/opt/node@10/10.12.0/bin` 添加到 PATH 头部。  

    > echo 'export PATH="/usr/local/opt/node@10/10.12.0/bin:$PATH"' >> ~/.zshrc（或 ~/.bash_profile）

> **思考**：可否将解压出的 `node@10/10.12.0`（keg-only）移动到 `/usr/local/Cellar/node/10.12.0`，作为备选版本，然后调用 `brew switch node 10.12.0` 呢？

**以上可行性有待实践验证**，如果可行可用同样的方法，下载 **`node-9.11.1.high_sierra.bottle.tar.gz`** 到本地安装 node 9.11.1？

### brew install node@9 ?

执行 `brew search node@9`，提示仓库中没有 node9：

```
~ » brew search node@9                                                                                  ~
No formula or cask found for "node@9".
```

那如何安装 node9，或 node10 更老的版本（例如 node 10.12.0）呢？

参考 **Homebrew 安装指定版本的软件**：[thrift](https://www.jianshu.com/p/aadb54eac0a8) / [gradle](http://jefferlau.me/2017/11/30/Homebrew-%E5%AE%89%E8%A3%85%E6%8C%87%E5%AE%9A%E7%89%88%E6%9C%AC%E7%9A%84%E8%BD%AF%E4%BB%B6/) / [ffmpeg](https://segmentfault.com/a/1190000015346120)  

> 从 `brew info` 的 From 中爬出指定版本提交的 commit ID 及其 rb，然后 brew install 从本地指定版本的 rb 安装。
