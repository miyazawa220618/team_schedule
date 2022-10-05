# データベース設計

## userテーブル

| Column             | Type    | Options                       |
| ------------------ | ------- | ----------------------------- |
| nickname           | string  | nill: false, uniqueness: true |
| email              | string  | nill: false, uniqueness: true |
| encrypted_password | string  | nill: false                   |
| profile_text       | text    | limit: 600                    |
| work_id            | integer | nill: false                   |

### Association

- has_many :project_users
- has_many :projects, through: :project_users
- has_many :comments
- has_many :shares
- has_one_attached :profile_image

## projectテーブル

| Column        | Type    | Options                           |
| ------------- | ------- | --------------------------------- |
| name          | string  | nill: false                       |
| about         | text    |                                   |
| project_start | date    | nill: false                       |
| project_end   | date    | nill: false                       |
| member_flag   | integer | nill: false, default: 0, limit: 1 |

### Association

- has_many :project_users
- has_many :users, through: :project_users
- has_many :comments
- has_many :schedules
- has_many_attached :files

## project_userテーブル（中間テーブル）

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user    | references | nill: false, foreign_key: true |
| project | references | nill: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :project

## commentテーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| text    | text       | nill: false                    |
| user    | references | nill: false, foreign_key: true |
| project | references | nill: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :project

## scheduleテーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| title      | string     | nill: false                    |
| start_date | date       | nill: false                    |
| end_date   | date       | nill: false                    |
| work_id    | integer    | nill: false                    |
| project    | references | nill: false, foreign_key: true |

### Association

- belongs_to :project
- has_many :shares

## shareテーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| share_date | date       | nill: false                    |
| hour_id    | integer    | nill: false                    |
| memo       | text       |                                |
| schedule   | references | nill: false, foreign_key: true |
| user       | references | nill: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :schedule
- has_many_attached :memo_file

## ActiveStorage
- profile_image
- file
- memo_file