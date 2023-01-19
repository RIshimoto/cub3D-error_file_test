
# cub3D-input_file_tester
[cub3D](https://github.com/RIshimoto/cub3D)の入力ファイルのバリデーションチェックをするテストツール。

## 使い方
### 1. 実行ファイルをテストツールのディレクトリ直下に置く。 
cub3Dをディレクトリ直下においてください。

### 2. テストを実行。 
- すべてのテストを実行。
```
$./test.sh
```
- 一部のテストを実行。
```
# Mapに関するテストを行う。
$./test.sh Map

# Textureに関するテストを行う。
$./test.sh Texture
```

## 実行
```
$ git clone https://github.com/RIshimoto/cub3D-input_file_test
$ （cub3Dの実行ファイルをcub3D-input_file_test内に置く）
$ cd cub3D-input_file_test
$ make all
$ ./test.sh
```

## デモ
https://user-images.githubusercontent.com/57135683/213444467-43d08cb4-39d0-479e-962d-fe6948f11ff9.mp4

## 注意 
- エラーケースが出力されず、ウィンドウが出た場合は手動で消してください。  
- エラーケースに対して、標準エラー出力がでる場合に[OK]としています。
- 有効なエラーが出ているかは目視で確認してください。（test.sh内のsee_the_error_message変数をtrueにすれば、各テストに対してどんなエラーメッセージ出したかを確認できます。）

- [memoryleak?]が出る場合は次の２パターンです。  
  1. ほんとにメモリリークしている。  
  2. プログラム上よくないことをしている。（例えば、初期化してない変数を使っているなど）  
必ずしもメモリリークしているわけではないのでご了承ください。   
