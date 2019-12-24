# simplemoon

<img src="https://github.com/yuki0n0/zsh-theme-simplemoon/raw/master/image.png" width="500px">

## Installation via zplug

```sh
zplug "yuki0n0/zsh-theme-simplemoon"
# Must not set `as:theme` tag.
```

## Description

### Path
現在のディレクトリのみ名称が表示され、それ以外のディレクトリ名は省略されます。<br>
また、Git 管理下にいる場合、Git のトップレベルディレクトリも表示します。

#### Example
```
~//git-top///path
```

### Git
Git 管理下に移動した場合、現在のブランチ名が表示されます。<br>
作業ディレクトリやステージにファイルが存在する場合、 `:` や `.` で表示します。<br>

## Requirements
- [zplug の用件](https://github.com/zplug/zplug#requirements)
- ruby 2.6 以上

## Others
- https://github.com/kagamilove0707/moonline.zsh を参考にしました
- オリジナルのプラグインを作成してみるテストリポジトリです
- Mac、デフォルトのターミナルテーマ(白背景)を想定しています。
