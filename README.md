# README
## ER図
![table2](https://user-images.githubusercontent.com/67823080/107048197-03591c80-680c-11eb-9cb1-71183b7f8028.png)
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
| postal_code        | string  | null: false              |
| address            | string  | null: false              |
| phone_number       | string  | null: false              |
| profile_image_id   | string  |                          |
| is_active          | boolean | true                     |

- has_many :rooms, dependent: :destroy
- has_many :messages, dependent: :destroy
- has_many :favorites, dependent: :destroy
- has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id, dependent: :destroy
- has_many :followings, through: :active_relationships, source: :follower, dependent: :destroy
## companiesテーブル
| Column             | Type    | Options                  |
| ------------------ | ------- | ------------------------ |
| email              | string  | null: false, unique:true |
| encrypted_password | string  | null: false              |
| company_name       | string  | null: false              |
| company_name_kana  | string  | null: false              |
| postal_code        | string  | null: false              |
| address            | string  | null: false              |
| phone_number       | string  | null: false              |
| profile_image_id   | string  |                          |
| approved           | boolean | true                     |
| is_active          | boolean | true                     |

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
