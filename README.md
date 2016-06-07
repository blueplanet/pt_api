## PivotalTrackerPullRequesterとは
- `git`のブランチ名から数値部分をストリーIDとして抽出し、`hub`コマンドを呼び出してPullRequestを作成する

## 使い方
### インストール
1. 環境変数を定義する
  - `PT_TOKEN`：PivotalTrackerのアクセストークン
  - `PT_PROJECT_ID`：PivotalTraskerのプロジェクトID
2. `pivotaal_tracker_pull_request.rb`を実行パスに配置する

### 普段の使い方
1. ブランチを作成するとき、PivotalTrackerのストリーIDを含めるように命名する
2. `git commit; git push`の後、PullRequestを作ろうとするタイミングで、`pivotaal_tracker_pull_request.rb`を実行する

## TODO
- [ ] PullRequestのテンプレートをERBに切り出す
- [ ] ストリーIDのパラメータを受け取る
- [ ] gem化
