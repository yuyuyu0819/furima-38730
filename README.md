# DB 設計

## users table

| Column             | Type                | Options                   |
|--------------------|---------------------|---------------------------|
| email              | string              | null: false, unique: true |
| encrypted_password | string              | null: false               |
| nickname           | string              | null: false               |
| first_name         | string              | null: false               |
| last_name          | string              | null: false               |
| first_name_kana    | string              | null: false               |
| last_name_kana     | string              | null: false               |
| birth_day          | date                | null: false               |



### Association

* has_many :items
* has_many :favorites
* has_many :comments
* has_many :purchases
* has_one  :card


## items table

| Column                              | Type       | Options                        |
|-------------------------------------|------------|--------------------------------|
| title                               | string     | null: false                    |
| description                         | text       | null: false                    |
| status_id                           | integer    | null: false                    |
| delivery_charge_id                  | integer    | null: false                    |
| prefecture_id                       | integer    | null: false                    |
| delivery_date_id                    | integer    | null: false                    |
| category_id                         | integer    | null: false                    |
| price                               | integer    | null: false                    |

### Association


- belongs_to :user
- has_many :comments
- has_many :favorites
- has_one  :purchase
- belongs_to_active_hash :category
- belongs_to_active_hash :status
- belongs_to_active_hash :delivery_charge
- belongs_to_active_hash :prefecture
- belongs_to_active_hash :delivery_date

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
| item            | references | null: false, foreign_key: true |
| user            | references | null: false, foreign_key: true |

### Association
- has_one    :address
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
| zip_code           | string              | null: false                    |
| prefecture_id      | integer             | null: false                    |
| city               | string              | null: false                    |
| block number       | string              | null: false                    |
| apartment_name     | string              |                                |
| purchase           | references          | null: false, foreign_key: true |
| phone_number       | string              | null: false                   |
### Association
belongs_to :purchase
belongs_to_active_hash :prefecture

## favorites table

| Column      | Type       | Options                        |
|-------------|------------|--------------------------------|
| item        | references | null: false, foreign_key: true |
| user        | references | null: false, foreign_key: true |

### Association

- belongs_to :item
- belongs_to :user
