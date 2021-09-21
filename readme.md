# Study the Django Tutorial

## 概要

[Djangoのチュートリアル](https://docs.djangoproject.com/ja/3.2/intro/)を実施した履歴を残すためのリポジトリ。環境構築にはDockerを用いる。

## 必要なもの

- Docker実行環境

## 再現方法

基本的にコマンドで作業を行うが同等のことを行えるのであればGUIアプリケーション使用しても構わない。

### VSCodeのRemote Development Extensionを利用

ホストOSで次のコマンドを実行する。

```PowerShell
# リポジトリのクローン
git clone https://github.com/ishuzaks/django-tutoial.git

# クローンしたリポジトリに移動
cd django-tutoial

# VSCodeでリポジトリを開く
code .
```

画面左下アイコン(><みたいなアイコン)よりRemote Developmentを起動、表示されるメニューより「Reopen in Container」を選択。  
__※コンテナのビルドが走るのでしばらく待つ__

![ss-vscode-01](https://user-images.githubusercontent.com/16950769/134121157-ea4de59a-e144-4c0a-8a9d-b5295a68ade0.png)

開発用コンテナにVSCodeがアタッチされターミナルが開く。  
(もしターミナルが開いていない場合 `Ctrl+Shift+@` で新規ターミナルを開く。)

開いたターミナル(以下コンテナ内ターミナル)で次のコマンドを実行する。

```bash
poetry install
```

「tutorial」フォルダがDjangoのプロジェクトフォルダなのでその中のファイル群を編集しチュートリアルを進めていく。
