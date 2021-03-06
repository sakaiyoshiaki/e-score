# README
## アプリ名
### E.Score

## 概要
特定の悩みや関心を持つ個人と、認知度を上げたい企業をつなげるサービスです。<br>
個人が悩みをプロに気軽に相談できるだけでなく、問題解決能力(信用度)を点数化することで法人の知名度を上げる仕組みを作りたいと考えています。

## 主な利用シーン
仕事や生活上での悩みはあるが、直接人に相談しにくい方やわざわざ外に出向くほどでもないと思っている方が、
気軽にその道のプロに話を聞きたい時に利用する。

## サービスの流れ
個人会員は、<br>
①企業が投稿した記事をカテゴリーごとに閲覧できる<br>
②記事に関する質問や悩みを企業に直接相談できる。<br>
③マイページに記事をお気に入り登録して、後で読み返すことができる。<br>
法人会員は、<br>
①個人会員の悩みを解決することにより、個人会員の評価ポイントを5段階で取得。<br>
　評価ポイントの累計が上位10位以内の企業が同サイト内で企業広告を掲載できる。<br>
②フォロワー会員に登録されている顧客リストを保存でき、将来の見込み顧客を把握できる。<br>
E.Scoreは、<br>
 法人会員の記事を掲載する

## 本番環境
http:/ <br>
ログイン情報(テスト用) <br>
・Eメール：test@test.com <br>
・パスワード 123app

## ページ一覧
・案内ページ(個人/法人)<br>
・新規登録ページ(住所・メール)(法人/個人)<br>
・記事投稿ページ(法人)<br>
・記事閲覧ページ(個人/法人)<br>
・フォロワー管理ページ(法人)<br>
・マイページ(個人)<br>

## 機能要件
・ユーザー登録、ログイン機能(devise)<br>
ー郵便番号から自動住所入力<br>
ーメール(法人登録申請)<br>

・投稿機能<br>
ー画像投稿(refile)<br>
ー記事の画像プレビュー<br>
ー記事投稿(Action Text)<br>
・お気に入り登録機能(Ajax)<br>
・ランキング表示機能(評価ポイントの累計が上位10位以内の企業)<br>
・フォロー機能(Ajax)<br>
・ページネーション機能(kaminari)<br>
・検索機能(ransack)(フォローユーザー情報/記事)<br>
・DM機能(法人会員ー個人会員)<br>
・通知機能(個人)<br>
・CSVエキスポート機能(フォローユーザー情報をCSV形式で印刷)<br>

## 使用技術(開発環境)
### バックエンド
Ruby2.6.4, Ruby on Rails6.0
### フロントエンド
HTML, CSS, SCSS, Javascript, jQuery, Ajax
### データベース
MySQL, SequelPro
### インフラ
AWS(EC2,S3), Docker(開発環境), CircleCI, Capistrano<br>
Nginx、Rails、MySQLコンテナを用意して、docker-composeで起動。<br>
CircleCIを用いてdocker-composeでコンテナを構築しCapistranoにより自動デプロイ。
### Webサーバー(本番環境)
nginx
### アプリケーションサーバ(本番環境)
unicorn
### ソース管理
Github, GitHubDesktop
### テスト
RSpec
### エディタ
VSCode

## ER図
![table](https://user-images.githubusercontent.com/67823080/107136223-b167e200-6944-11eb-9874-20410cb1e67c.png)
## DB設計
## usersテーブル
| Column             | Type    | Options                  |
| ------------------ | ------- | ------------------------ |
| nickname           | string  | null: false              |
| email              | string  | null: false, unique:true |
| encrypted_password | string  | null: false              |
| last_name          | string  | null: false              |
| first_name         | string  | null: false              |
| last_name_kana     | string  | null: false              |
| first_name_kana    | string  | null: false              |
| birthday           | date    | null: false              |
| postal_code        | string  |                          |
| address            | string  |                          |
| phone_number       | string  |                          |
| profile_image_id   | string  |                          |
| is_active          | boolean | true                     |

- has_many :rooms, dependent: :destroy
- has_many :messages, dependent: :destroy
- has_many :favorites, dependent: :destroy
- has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id, dependent: :destroy
- has_many :followings, through: :active_relationships, source: :follower, dependent: :destroy
## companiesテーブル
| Column              | Type    | Options                  |
| ------------------- | ------- | ------------------------ |
| email               | string  | null: false, unique:true |
| encrypted_password  | string  | null: false              |
| company_name        | string  | null: false              |
| company_name_kana   | string  | null: false              |
| postal_code         | string  | null: false              |
| address             | string  | null: false              |
| phone_number        | string  | null: false              |
| profile_image_id    | string  |                          |
| background_image_id | string  |                          |
| approved            | boolean | true                     |
| is_active           | boolean | true                     |

- has_many :rooms, dependent: :destroy
- has_many :messages, dependent: :destroy
- has_many :articles, dependent: :destroy
- has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
- has_many :followers, through: :passive_relationships, source: :following, dependent: :destroy
## roomsテーブル
| Column  | Type       | Options                       |
| ------- | ---------- | ----------------------------- |
| user    | references | null: false, foreign_key:true |
| company | references | null: false, foreign_key:true |

- belongs_to :user
- belongs_to :company
- has_many :messages, dependent: :destroy
## messagesテーブル
| Column  | Type       | Options                       |
| ------- | ---------- | ----------------------------- |
| message | string     | null: false                   |
| user    | references | null: false, foreign_key:true |
| room    | references | null: false, foreign_key:true |
| company | references | null: false, foreign_key:true |

- belongs_to :user, optional: true
- belongs_to :company, optional: true
- belongs_to :room
## articlesテーブル
| Column   | Type       | Options                       |
| -------- | ---------- | ----------------------------- |
| title    | string     | null: false                   |
| text     | text       | null: false                   |
| image_id | string     | null: false                   |
| genre_id | integer    | null: false                   |
| company  | references | null: false, foreign_key:true |

- belongs_to :company
- has_many :favorites, dependent: :destroy
## favoritesテーブル
| Column  | Type       | Options                       |
| ------- | ---------- | ----------------------------- |
| user    | references | null: false, foreign_key:true |
| article | references | null: false, foreign_key:true |

- belongs_to :user
- belongs_to :article
## relationshipsテーブル
| Column       | Type    | Options     |
| ------------ | ------- | ----------- |
| following_id | integer | null: false |
| follower_id  | integer | null: false |

- belongs_to :following, class_name: "User"
- belongs_to :follower, class_name: "Company"

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
