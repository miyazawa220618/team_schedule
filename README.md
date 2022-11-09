# アプリケーション名
### **Team Schedule**
***
<br>

# アプリケーション概要
「アサイン可能なメンバーの把握」を実現するプロジェクト管理アプリ  
ユーザー登録すると、プロジェクトの説明登録・作業スケジュールの登録・作業者による作業予定日の登録が可能となります。  
ユーザー詳細画面から、個人の1週間のリソースを確認することができます。

### **URL**
[http://13.114.88.167/](http://13.114.88.167/)

| テスト用アカウント  |              |
| ---------------- | ------------ |
| Basic認証ID       | tech         |
| Basic認証パスワード | check        |
| メールアドレス      | aaa@test.com |
| パスワード         | test1212     |

***
<br>

# 利用方法

### **プロジェクト登録**
1. トップ画面（ログイン画面）からログインする
2. マイページ画面からプロジェクト一覧に移動する
3. プロジェクト作成ボタンから、プロジェクト内容（プロジェクト名・内容・開始日・終了日・メンバー募集フラグ）を入力し投稿
4. プロジェクト一覧に投稿したプロジェクトが表示される
  ※登録したプロジェクトの日付によって、プロジェクト一覧に表示されるボックスの位置が異なります。
  - 開始日が今日の日付より未来の場合：今後の予定
  - 開始日が今日以降かつFIX予定日が今日より未来の場合：進行中
  - FIX予定日が今日より過去の場合：FIX（FIX予定日より40日を過ぎている場合非表示）

### **プロジェクト > コメント機能**
1. プロジェクト詳細画面のコメント入力フォームからコメントを投稿する    
  ※投稿したコメントは、投稿者本人のみ編集・削除が可能

### **スケジュール登録**
1. プロジェクトを登録し、スケジュール一覧画面に移動する（プロジェクト詳細画面の「このプロジェクトの詳細スケジュール」）
2. スケジュール作成ボタンから、スケジュール内容（作業名・プロジェクト選択・役職選択・開始日・終了日）を入力し投稿する

### **ユーザースケジュール登録**
1. スケジュール詳細画面の担当入力フォームから作業内容（作業日・作業日における作業時間・作業メモ）を入力し投稿します。
***
<br>

# アプリケーションを作成した背景
前職でwebディレクターを担当しており、社内で複数案件が立て込んだ際に「誰がどれだけ作業が入っていて、誰なら作業の相談ができるか知りたい」と思うことがしばしばありましたが、その際に個別に相談したり、全体に呼びかけるなど連絡を待つ必要があることが時間のロスに繋がっていると感じていました。  私の担当していた案件が運用案件だったこともあり、短いスパンの依頼も多く、その日もしくは明日の状況が知りたいと思っていたため、各ユーザーの今日明日のリソース状況を％形式で表示しています。
***
<br>

# 洗い出した要件
[要件定義シート](https://docs.google.com/spreadsheets/d/14Rqa1rF6dQdE0cw9Kupy9lhJ2g-8dwzf3t4tsl7MiAs/edit?usp=sharing)
***
<br>

# 実装した機能についての画像やGIFおよびその説明
1. **ログイン画面をルートパスに設定**
![Image from Gyazo](https://i.gyazo.com/1869feb2f5b468e3860cf37c5a62bbb3.jpg)
    - web制作会社が使用することを想定したサイトのため、デスク画像を背景に使用し、「have a good day at work.（お仕事がんばってね）」の一言を添えています。   
    <br>

2. **プロジェクト一覧画面のリストの区分けとレスポンシブ**   
▼PC表示はこちら
[![Image from Gyazo](https://i.gyazo.com/4fb0951c232123eaf65a47a8c979aa31.jpg)](https://gyazo.com/4fb0951c232123eaf65a47a8c979aa31)
▼SP表示はこちら
[![Image from Gyazo](https://i.gyazo.com/63fe48017246d74a03c2bd27c42fc293.png)](https://gyazo.com/63fe48017246d74a03c2bd27c42fc293)
    - javascriptでプロジェクト作成時に設定した「開始日」と「FIX予定日」から、今後の予定・進行中・FIXの3区分に分けて表示しています。   
    ［補足］  
    ・ 今後の予定は、相談段階の案件となります。    
    ・ 進行中は、開始日が今日以前且つ、FIX予定日が今日までの案件になります。       
    ・ FIX後の表示は過去40日以内となっており、基本的に先月FIXした案件の見積りを作成する時の確認用に残す目的で設置しています。
    - PC時は、3区分を横並びで表示。タブレット〜SPは、横幅がないためデフォルト表示を進行中案件のみの表示で、ボタンで他区分の案件が閲覧できる仕様になっています。   
    <br>

3. **スケジュールのカレンダー表示**
[![Image from Gyazo](https://i.gyazo.com/92a4b6b93d5cfce3ce9c1dadd88b04ce.jpg)](https://gyazo.com/92a4b6b93d5cfce3ce9c1dadd88b04ce)
    - 営業日の月〜金のスケジュールを今日を基準に過去5週間、今後の10週間の計15週間を表示
    - デフォルトは今週からの4週間を表示しているため、前後の週はボタンクリックで閲覧が可能。
    - 休業日の土日の表示を省くことで、1日毎の幅に余裕を持たせている。
    - カレンダーはディレクター（赤）・デザイナー（黄）・エンジニア（青）の役職で色分けしている。
    - javascriptで今日の日付枠は黄色、祝日は薄い赤色を変換している。
    - ransackのGemで実装した検索機能で、役職名・ユーザー名・キーワード検索による絞り込みが可能。キーワードは、プロジェクト名もしくはスケジュールタイトルにキーワードが含まれる場合にヒットする。   
    <br>

4. **スケジュール詳細画面内の作業日詳細設定**
[![Image from Gyazo](https://i.gyazo.com/3955ebcc6df771a1d65d5a4f560c4581.png)](https://gyazo.com/3955ebcc6df771a1d65d5a4f560c4581)
    - スケジュールで登録された開始日や終了日は、先方に提出するテストアップなどの期日をベースに引かれることを想定しています。実際に作業する日は、実作業日として別で設定を行います。
    - 実作業日の一覧表示・作成・編集・削除全てをスケジュール詳細画面内で完結させています。   
    <br>

5. **マイページのリソース表示**
[![Image from Gyazo](https://i.gyazo.com/26178698b2ca40e625758effe30729cd.png)](https://gyazo.com/26178698b2ca40e625758effe30729cd)
    - スケジュール詳細ページで登録した実作業日の内容がリソースとして表示されます。土日を除く今日からの5日間のリソースを確認することができます。
    - グラフと％表示により、直感的にリソースが大体どれくらい埋まっているのか把握できるようになっています。
***
<br>

# 実装予定の機能
時間内に終わらなさそうな機能で、追加実装で作成したい機能は以下になります。
- 有給休暇管理：マイページに表示する
- プロジェクトカテゴリ：案件企業名などのカテゴリを作り、そのカテゴリでプロジェクト一覧画面で絞り込みができるようにする
***
<br>

# データベース設計
[ER図](team_schedule.dio)  
[テーブル構成](team_schedule_db.md)
***
<br>

# 画面遷移図
[画面遷移図](https://docs.google.com/spreadsheets/d/14Rqa1rF6dQdE0cw9Kupy9lhJ2g-8dwzf3t4tsl7MiAs/edit?usp=sharing)
***
<br>

# 開発環境
- フロントエンド（HTML/CSS/JS）
- バックエンド（Ruby）
- インフラ（AWS EC2/S3）
- テスト（Rspec）
- テキストエディタ（Visual Studio Code）
- タスク管理（GitHub）
***
<br>

# ローカルでの動作方法
以下のコマンドを順に実行
```
% git clone https://github.com/miyazawa220618/team_schedule.git
% cd team_schedule
% bundle install
% yarn install
```
***
<br>

# 工夫したポイント
企業のスケジュール管理アプリは様々ありますが、今回はスケジュール表がカレンダー表示で社内全体のスケジュールが入る想定で実装しました。    
社内全体のプロジェクトのスケジュールを１ページ内に収めることで、プロジェクト毎にページを探したり、見比べるために複数画面を開く必要がありません。    
今回作成したスケジュール一覧では、全体表示がベースのため見づらく感じてしまうかと思いますが、そこから絞り込みをしていただくことで、特定の人物や役職(ディレクター・デザイナー・エンジニア)のみの表示にすることができるようにしています。

　また、ユーザー一覧では今日のリソース、マイページでは今日からの5日間のリソースが一目で分かるようグラフで表示したことで、本アプリを開発した目的である「アサイン可能なメンバーの把握」の解決に役立つと考えました。   

その他、閲覧状況としては主にPCになることを想定していますが、タブレット・スマホで閲覧したい場合も考え、レスポンシブ対応しております。