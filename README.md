# DB 設計

## users table

| Column             | Type                | Options                   |
|--------------------|---------------------|---------------------------|
| email              | string              | null: false, unique: true |
| password           | string              | null: false               |
| encrypted_password | string              | null: false               |
| nickname           | string              | null: false               |
| first_name         | string              | null: false               |
| last_name          | string              | null: false               |
| first_name_kana    | string              | null: false               |
| last_name_kana     | string              | null: false               |
| birth_year         | integer             | null: false               |
| birth_month        | integer             | null: false               |
| birth_day          | integer             | null: false               |
| phone_number       | integer             | null: false               |


### Association

* has_many :items
* has_many :favorites
* has_many :comments
* has_one  :address
* has_one  :purchase
* has_one  :card


## items table

| Column                              | Type       | Options                        |
|-------------------------------------|------------|--------------------------------|
| title                                | string     | null: false                    |
| description                         | text       | null: false                    |
| status                                | string     | null: false                    |
| delivery_paid_by                    | string     | null: false                    |
| delivery_date                       | string     | null: false                    |
| category                            | string     | null: false                    |
| price                               | integer    | null: false                    |

### Association

- belongs_to :user
- has_many :comments
- has_many :favorites
- has_one  :purchase

## comments table

| Column      | Type       | Options                        |
|-------------|------------|--------------------------------|
| comment     | text       | null: false                    |
| item        | references | null: false, foreign_key: true |
| user        | references | null: false, foreign_key: true |

### Association

- belongs_to :item
- belongs_to :user

## purchases table

| Column          | Type       | Options                        |
|-----------------|------------|--------------------------------|
| delivery_fee    | integer    | null: false                    |
| item            | references | null: false, foreign_key: true |
| user            | references | null: false, foreign_key: true |

### Association

- belongs_to :item
- belongs_to :user

## cards table

| Column             | Type                | Options                   |
|--------------------|---------------------|---------------------------|
| user               | references          | null: false, foreign_key  |

### Association

- belongs_to :user

## addresses table

| Column             | Type                | Options                        |
|--------------------|---------------------|--------------------------------|
| zip code           | string              | null: false                    |
| prefecture         | string              | null: false                    |
| city               | string              | null: false                    |
| block number       | string              | null: false                    |
| apartment_name     | string              | null: false                    |
| user               | references          | null: false, foreign_key: true |

### Association
belongs_to :user

## favorites table

| Column      | Type       | Options                        |
|-------------|------------|--------------------------------|
| item        | references | null: false, foreign_key: true |
| user        | references | null: false, foreign_key: true |

### Association

- belongs_to :item
- belongs_to :user
