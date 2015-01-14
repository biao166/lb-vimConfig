## vim-config

### Setup

```
git clone git@github.com:biao166/vim-config.git
cd vim-config
cp _vimrc ~/.vimrc
cp _gvimrc ~/.gvimrc
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

### 操作

* :PluginList       - lists configured plugins
* :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
* :PluginSearch foo - searches for foo; append `!` to refresh local cache
* :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal


### 来源

在Github vim-scripts 用户下的repos,只需要写出repos名称  
在Github其他用户下的repos, 需要写出”用户名/repos名”  
不在Github上的插件，需要写出git全路径  

### 参考

* [Vundle](https://github.com/gmarik/Vundle.vim)
* [vim-scripts](http://vim-scripts.org/vim/scripts.html)
