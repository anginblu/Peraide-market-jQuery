# Peraide for professional profiles offering services

## Overview
Online directory where viewers can find job seekers' profiles by job category & where viewers(potential & existing employees) can add/view reviews of job seekers' profiles.

### Users
1. Have name, email, password
2. Should be able to log in and log out with Google
3. has_many :profiles
4. has_many :profiles_categories, through: :profile
5. has_many :categories, through: :profiles_categories
6. has_many :skills, through: profiles
7. has_many :comments

### Profiles
1. Have hourly rate, and availability (date from)
2. belongs_to :user
3. has_many :profiles_categories
4. has_many :categories, through: :profiles_categories
5. has_many :skills
6. has_many :comments
7. Allows a scope method: Profile.cheapest.currently_available = User.cheapest + currently_available

### Profiles_categories
1.	belongs_to :profile
2.	belongs_to :category

### Categories (admin access only)
1. Have a name, which is unique
2. has_many :profiles_categories
3. has_many :profiles, through: :profiles_categories

### Skills
1. Have a name (must be present)
2. belongs_to :profile
3. belongs_to :user, through: profile
4. Enables nested_attributes

### Comments
1. Have a content, created_at
2. belongs_to :profile
3. belongs_to :user
4. utilizes jQuery and an Active Model Serialization JSON Backend
5. JSON formatted index and show pages

##Installation
1. Fork and clone repo
2. Migrate db
3. Bundle install

##License
Refer to: Peraide-market-jQuery/LICENSE.md

## Resources
Refer to: Peraide-market-jQuery/RESOURCES.md

##contribution
Refer to: Peraide-market-jQuery/CONTRIBUTING.md
