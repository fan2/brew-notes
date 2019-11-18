# [Homebrew 比较快的源（mirror）](https://www.zhihu.com/question/31360766)  

[Coding 家的 Homebrew 源](https://www.zhihu.com/question/31360766/answer/74155248)  

## [LUG@USTC](https://lug.ustc.edu.cn/wiki/start)

[开源软件镜像服务](https://lug.ustc.edu.cn/wiki/lug/services/mirrors) - [mirrors 首页](http://mirrors.ustc.edu.cn/)  

http://mirrors.ustc.edu.cn/brew.git/  
http://mirrors.ustc.edu.cn/homebrew-core.git/  
http://mirrors.ustc.edu.cn/homebrew-cask.git/  
http://mirrors.ustc.edu.cn/homebrew-bottles/  

[开源镜像使用帮助列表](https://lug.ustc.edu.cn/wiki/mirrors/help)

[Homebrew Git仓库镜像使用帮助](https://lug.ustc.edu.cn/wiki/mirrors/help/brew.git)  
[Homebrew Bottles 镜像使用帮助](https://lug.ustc.edu.cn/wiki/mirrors/help/homebrew-bottles)  

### [替换及重置Homebrew默认源](https://lug.ustc.edu.cn/wiki/mirrors/help/brew.git)

[替换 brew 源为中科大镜像](https://zhuanlan.zhihu.com/p/29951754)

#### 替换 brew.git

```
cd "$(brew --repo)"
git remote set-url origin https://mirrors.ustc.edu.cn/brew.git
```

详情如下：

```Shell
faner@FAN-MB0:/usr/local/Homebrew|stable
⇒  git remote -v # git remote get-url origin
origin	https://github.com/Homebrew/brew.git (fetch)
origin	https://github.com/Homebrew/brew.git (push)

faner@FAN-MB0:/usr/local/Homebrew|stable
⇒  git remote set-url origin https://mirrors.ustc.edu.cn/brew.git
faner@FAN-MB0:/usr/local/Homebrew|stable

⇒  git remote -v
origin	https://mirrors.ustc.edu.cn/brew.git (fetch)
origin	https://mirrors.ustc.edu.cn/brew.git (push)
```

#### 替换 homebrew-core.git

```
cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-core.git
```

详情如下：

```Shell
faner@FAN-MB0:/usr/local/Homebrew|stable
⇒  cd Library/Taps/homebrew/homebrew-core

faner@FAN-MB0:/usr/local/Homebrew/Library/Taps/homebrew/homebrew-core|master
⇒  git remote -v
origin	https://github.com/Homebrew/homebrew-core (fetch)
origin	https://github.com/Homebrew/homebrew-core (push)

faner@FAN-MB0:/usr/local/Homebrew/Library/Taps/homebrew/homebrew-core|master 
⇒  git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-core.git

faner@FAN-MB0:/usr/local/Homebrew/Library/Taps/homebrew/homebrew-core|master 
⇒  git remote -v
origin	https://mirrors.ustc.edu.cn/homebrew-core.git (fetch)
origin	https://mirrors.ustc.edu.cn/homebrew-core.git (push)
```

### [替换Homebrew Bottles源](https://lug.ustc.edu.cn/wiki/mirrors/help/homebrew-bottles)

如果是 bash shell 将 export HOMEBREW_BOTTLE_DOMAIN 加到 `~/.bash_profile` 或 `~/.bashrc`：

```Shell
echo 'export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles' >> ~/.bash_profile
source ~/.bash_profile
```

如果是 zsh shell 将 export HOMEBREW_BOTTLE_DOMAIN 加到 `~/.zshrc`：

```Shell
echo 'export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles' >> ~/.zshrc
source ~/.zshrc
```

## [清华大学开源软件镜像站](https://mirror.tuna.tsinghua.edu.cn/)

### [Homebrew 镜像使用帮助](https://mirror.tuna.tsinghua.edu.cn/help/homebrew/)

该镜像是 Homebrew 的 formula 索引的镜像（即 `brew update` 时所更新内容）。

替换现有上游：

```Shell
git -C "$(brew --repo)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git
git -C "$(brew --repo)" remote get-url origin

git -C "$(brew --repo homebrew/core)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git
git -C "$(brew --repo homebrew/core)" remote get-url origin

git -C "$(brew --repo homebrew/cask)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask.git
git -C "$(brew --repo homebrew/cask)" remote get-url origin

brew update
```

### [Homebrew-bottles 镜像使用帮助](https://mirrors.tuna.tsinghua.edu.cn/help/homebrew-bottles/)

该镜像是 Homebrew 二进制预编译包的镜像。

临时替换

```Shell
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles
```

长期替换

```Shell
echo 'export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles' >> ~/.bash_profile
source ~/.bash_profile
```

## [aliyun](https://mirrors.aliyun.com/homebrew/)

https://mirrors.aliyun.com/homebrew/brew.git/  
https://mirrors.aliyun.com/homebrew/homebrew-core.git/  
https://mirrors.aliyun.com/homebrew/homebrew-bottles/  

> 配置方法参考 tuna.tsinghua。

## [tencent](http://mirrors.tencent.com/)

http://mirrors.tencent.com/homebrew/brew.git/  
http://mirrors.tencent.com/homebrew/homebrew-core.git/  
http://mirrors.tencent.com/homebrew-bottles/  

> 配置方法参考 tuna.tsinghua。

## reset

```
git -C "$(brew --repo)" remote set-url origin https://github.com/Homebrew/brew.git

git -C "$(brew --repo homebrew/core)" remote set-url origin https://github.com/Homebrew/homebrew-core.git

git -C "$(brew --repo homebrew/cask)" remote set-url origin https://github.com/Homebrew/homebrew-cask.git

brew update
```

# references

[Mac下使用国内镜像安装Homebrew](http://blog.leanote.com/post/zilong.yang@gmail.com/Mac%E4%B8%8B%E4%BD%BF%E7%94%A8%E5%9B%BD%E5%86%85%E9%95%9C%E5%83%8F%E5%AE%89%E8%A3%85Homebrew)  
[brew update 慢 解决办法 镜像更新源](https://www.logcg.com/archives/1301.html)  
[Homebrew 换源](http://blog.csdn.net/jeikerxiao/article/details/72705629)  
[Mac更换homebrew软件镜像源](http://xiaoshang.online/2017/09/02/Mac%E6%9B%B4%E6%8D%A2homebrew%E8%BD%AF%E4%BB%B6%E6%BA%90/)  

[换源让Homebrew速度飞起](https://maomihz.com/2016/06/tutorial-6/)  
[Brew、Pip、Yum更换国内源](https://thief.one/2017/08/24/1/)  
