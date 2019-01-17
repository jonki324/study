# マークダウン記法

## 見出し(h1 - h6)

```
# h1
## h2
### h3
#### h4
##### h5
###### h6
```

# h1
## h2
### h3
#### h4
##### h5
###### h6

## 番号なしリスト(ul)

```
- ul1
- ul2
  - ul2-1
  - ul2-2
    - ul2-2-1
```

- ul1
- ul2
  - ul2-1
  - ul2-2
    - ul2-2-1

## 番号付きリスト(ol)

```
1. ol1
1. ol2
   1. ol2-1
   1. ol2-2
      1. ol2-2-1
```

1. ol1
1. ol2
   1. ol2-1
   1. ol2-2
      1. ol2-2-1

## コード

- バッククォーテーション３つ
- クォーテーションの後に言語指定可能(javaなど)

```java
class JavaApp {
    public static void main(String[] args) {
        System.out.println("Hello World");
    }
}
```

## 引用

```
> 引用1
>> 引用2
```

> 引用1
>> 引用2

## 水平線

```
---
```

---

## 強調

```
Hello ***World*** !!
```

Hello ***World*** !!

## 取り消し線

```
~~Hello~~ World !!
```

~~Hello~~ World !!

## 改行

```
改行なしは行末に
２つスペースなし

改行ありは行末に  
２つスペースあり
```

改行なしは行末に
２つスペースなし

改行ありは行末に  
２つスペースあり

## リンク

```
[Google](https://www.google.co.jp)
```

[Google1](https://www.google.co.jp)

## 定義済みリンク

```
[google]:https://www.google.co.jp
[Google2][google]
```

[google]:https://www.google.co.jp
[Google2][google]

## 画像リンク

```
![画像](img/mdlogo.png)
```

![画像](img/mdlogo.png)


## テーブル

```
|th1|th2|th3|
|:--|--:|:-:|
|td11|td22|td33|
|L|R|C|
```

|th1|th2|th3|
|:--|--:|:-:|
|td11|td22|td33|
|L|R|C|