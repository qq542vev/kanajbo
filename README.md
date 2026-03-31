<!-- Document: README.md

ロジバンIME辞書のマニュアル。

Metadata:

  id - 97e5db3d-c6c9-4ef0-82fe-03cf61b6446e
  author - <qq542vev at https://purl.org/meta/me/>
  version - 0.1.0
  created - 2026-03-31
  modified - 2026-03-31
  copyright - Copyright (C) 2026-2026 qq542vev. All rights reserved.
  license - <CC-BY-SA-4.0 at https://creativecommons.org/licenses/by-sa/4.0/>

See Also:

  * <Project homepage at https://github.com/qq542vev/kanajbo>
  * <Bag report at t https://github.com/qq542vev/kanajbo/issues>
-->

# ロジバンIME辞書

このプロジェクトは、日本語入力からロジバンの単語を簡単に変換できるIME用の辞書を提供します。例えば次のような変換が可能です。

```
たべる → citka
あるく → cadzu
わらう → cmila
```
以下のIMEに対応しています。

 * Anthy
 * Gboard
 * Mozc
 * Microsoft IME

## 使い方

### 1. 最新版のダウンロード

最新版の辞書ファイルは、[GitLab Releases](https://gitlab.com/qq542vev/kanajbo/-/releases)にて公開されています。お使いのIMEに対応した辞書ファイルをダウンロードしてください。

### 2. IMEへのインポート

ダウンロードした辞書ファイルを、お使いのIMEにインポートしてください。辞書の取り込み方法はIMEによって異なります。

## 辞書の種類

このプロジェクトでは、以下の3種類の辞書を提供します。

 * \*-at-\*.txt:
   * スイッチキーとして`@`を使用します。
   * 例: `@たべる` → `citka`
 * \*-bs-\*.txt:
   * スイッチキーとして`\`を使用します。
   * 例: `\たべる` → `citka`
 * \*-ziho-\*.txt:
   * スイッチキーを使用しません。
   * 例: `たべる` → `citka`

## ライセンス

生成された辞書ファイルは**CC0 1.0 Universal（パブリックドメイン）**の下で提供されています。詳細は[LICENSE.txt](LICENSE.txt)を参照してください。

## 謝辞

このプロジェクトは[日英変換・英語略語展開のための IME 追加辞書](https://github.com/peaceiris/google-ime-dictionary)から着想を得て作成されました。また辞書作成に当たっては[jbovlaste日本語版](https://jbovlaste.lojban.org/)を利用しました。作成者皆様に感謝申し上げます。
