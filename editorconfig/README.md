# EditorConfig

## VSCodeにプラグインをインストール
- EditorConfig for VS Code

## .editorconfig作成
```bash
$ vi .editorconfig
```

## 設定例
```
root = true

[*]
indent_style = space
indent_size = 4
end_of_line = lf
charset = utf-8
trim_trailing_whitespace = true
insert_final_newline = true
```

### root = true
.editorconfigより下の階層を対象とする

### [*]
対象のファイルを指定

### indent_style
インデント時のスタイルを指定(tab or space)

### indent_size
インデント時のサイズ

### end_of_line
改行コード(lf or cr or crlf)

### charset
文字コード

### trim_trailing_whitespace
文末にスペースがあった場合は取り除くかどうかの指定

### insert_final_newline
最終行に改行を入れるかどうかの指定
