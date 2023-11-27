# Backend coding challenge
This is the coding challenge for people who applied to a backend developer position at SeQura. It's been designed to be a simplified version of the same problems we deal with.

## The challenge
SeQura provides e-commerce shops (merchants) a flexible payment method so their customers (shoppers) can purchase and receive goods without paying upfront. SeQura earns a small fee per purchase and pays out (disburses) the merchant once the order is marked as completed.

The operations manager is now asking you to make a system to calculate how much money should be disbursed to each merchant based on the following rules:

* Disbursements are done daily.
* All orders must be disbursed precisely once.
* Each disbursement, the group of orders paid on the same date for a merchant, must have a unique alphanumerical reference.
* Orders, amounts, and fees included in disbursements must be easily identifiable for reporting purposes.

* The disbursed amount has the following fee per order:
  * 1% fee for amounts smaller than 50 €
  * 0.95% for amounts between 50€ - 300€
  * 0.85% for amounts over 300€

```
Merchants sample
id                                   | REFERENCE                 | EMAIL                             | LIVE_ON    | DISBURSEMENT_FREQUENCY | MINIMUM_MONTHLY_FEE
2ae89f6d-e210-4993-b4d1-0bd2d279da62 | treutel_schumm_fadel      | info@treutel-schumm-and-fadel.com | 2022-01-01 | WEEKLY                 | 29.0
6596b87d-7f13-460f-ba1a-00872c770092 | windler_and_sons          | info@windler-and-sons.com         | 2021-05-25 | DAILY                  | 29.0
70de4478-bfa8-4c4c-97f1-4a0a149f8264 | mraz_and_sons             | info@mraz-and-sons.com            | 2020-03-20 | WEEKLY                 |  0.0
52f0e308-4a9d-4b32-ace4-c491f457d9a5 | cummerata_llc             | info@cummerata-llc.com            | 2019-02-04 | DAILY                  | 35.0
```

```
Orders samples
id           | MERCHANT REFERENCE      | AMOUNT | CREATED AT
056d024481a9 | treutel_schumm_fadel    |  61.74 | 2023-01-01
33c80364591c | cummerata_llc           | 293.08 | 2023-01-01
5eaeabf54862 | mraz_and_sons           | 373.33 | 2023-01-01
70530cdc7b59 | treutel_schumm_fadel    |  60.48 | 2023-01-01
871e0d072782 | mraz_and_sons           | 213.97 | 2023-01-01
```

Final calculate disbursed
``` 
Year| Number of disbursements| Amount disbursed to merchants| Amount of order fees| Number of monthly fees charged | Amount of monthly fees charged
2022| 138287                 | 1.261.521.39 €               | 27.162.221,29  €    | 11                             | 193,54 €
2023| 837485                 | 139.063.083,17 €             | 140.324.604,56 €    | 26                             | 468,35 €
```

We expect you to:

* Create the necessary data structures and a way to persist them for the provided data. You don’t have to follow CSV’s schema if you think another one suits you better.
* Calculate and store the disbursements following the described requirements for all the orders included in the CSV, and prepare the system to do the same for new orders.
* Fill the following table and include it in the README.


## Table of Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Tests](#Tests)
- [Notes](#Notes)

## Requirements
Before running the project, make sure you have the following:

- Ruby installed (version 3.1.2).
- Rails installed (version 7.1.1).
- Postgresql installed (version 1.3.4).

## Installation

1. Clone this repository to your local machine:

   ```bash
     git clone https://github.com/denysnando/process-disbursement
   ```
2. Setup
   ```bash
     cd process-disbursement/
     bundle
     bundle exec rake db:create
     bundle exec rake db:migrate
     bundle exec rake db:seed
     bundle exec sidekiq
     bundle exec rake disbursement:process_disbursement # you can run the rake as soon as you start the project
   ```

## Usage
  ```bash
  bundle exec rails s
  ```

## Tests
   ```bash
     rspec
   ```

## Sidekiq-cron
check config/schedule.yml
