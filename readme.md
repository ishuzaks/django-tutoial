# Study the Django Tutorial

## 概要

[Djangoのチュートリアル](https://docs.djangoproject.com/ja/3.2/intro/)を実施した履歴を残すためのリポジトリ。環境構築にはDockerを用いる。

## 必要なもの

### 必須

- Docker実行環境

### 推奨

- poetryコマンド (VSCodeのRemote Development Extensionを利用しない場合)

## 再現方法

基本的にコマンドで作業を行うが同等のことを行えるのであればGUIアプリケーション使用しても構わない。

### 1. VSCodeのRemote Development Extensionを利用する場合

ホストOSで次のコマンドを実行する。

```PowerShell
# PowerShellの場合
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
(もしターミナルが開いていない場合 `Ctrl+@` でターミナルを開く。)

開いたターミナル(以下コンテナ内ターミナル)で次のコマンドを実行することで必要なPythonパッケージがインストールされる。  
※poetryコマンドについては[公式ドキュメント](https://python-poetry.org/docs/)を参照のこと。

```bash
poetry install
```

「tutorial」フォルダがDjangoのプロジェクトフォルダなのでその中のファイル群を編集しチュートリアルを進めていく。  
※tutorialフォルダはDjangoの入っているappコンテナにマウントされているので編集内容はリアルタイムで反映される。

### 2. 任意のエディタを利用する場合

ホストOSで次のコマンドを実行する。

```PowerShell
# PowerShellの場合
# リポジトリのクローン
git clone https://github.com/ishuzaks/django-tutoial.git

# クローンしたリポジトリに移動
cd django-tutoial

# コンテナ群のビルド&バックグラウンド実行
docker compose up -d --build
```

「tutorial」フォルダがDjangoのプロジェクトフォルダなのでその中のファイル群を任意のエディタで編集しチュートリアルを進めていく。  
※tutorialフォルダはDjangoの入っているappコンテナにマウントされているので編集内容はリアルタイムで反映される。

## 注意点

__以下の点に注意!!__

1. `poetry add`で追加したパッケージは実行環境(appコンテナ)に即時反映されない。  
    以下のコマンドを実行することで反映される。

    1. VSCodeのRemote Development Extensionを利用している場合

        VSCodeで開発用コンテナにアタッチしている状態で以下の作業を行う。

        ```bash
        # ゲストOS(Developコンテナ内)にて
        poetry export --output requirements.txt
        ```

        VSCode画面左下アイコンをクリック、メニューより「Rebuild Container」を実行。コンテナのリビルドが実行されるので完了するまで待つ。

    2. 任意のエディタを利用している場合

        ホストOSで以下の作業を行う。

        1. 任意の方法でrequirements.txtを編集する。

            ※`poetry export --output requirements.txt`コマンドで更新することを __強く__ 推奨する。

        2. コンテナをリビルドする。

            ```Powershell
            # 起動済みのコンテナ群の削除
            docker compose down
            
            # コンテナをリビルドしつつ起動
            docker compose up -d --build
            ```

## 既知の問題

- データベースに日本語(マルチバイト文字?)が格納できない
- 開発用コンテナからappコンテナやdbコンテナにコマンドを発行できない。

## TODO

- [ ] manage.pyの使い方を記述する
