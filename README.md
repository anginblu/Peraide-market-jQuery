# Peraide for professional profiles offering services

## Overview
Online directory where viewers can find job seekers' profiles by job category.  

## Instructions

### Users
1. Have name, email, password, hourly rate, and availability (date from)
2. Should be able to log in and log out with Google
3. Allows a scope method: User.cheapest.in_category(@category) = User.cheapest + User.in_category(category)
4. has_many :profiles
5. has_many :profiles_categories, through: :profile
6. has_many :categories, through: :profiles_categories
7. has_many :skills, through: profiles

### Profiles
1. belongs_to :user
2. has_many :profiles_categories
3. has_many :categories, through: :profiles_categories
4. has_many :skills

### Profiles_categories
1.	belongs_to :profile
2.	belongs_to :category

### Categories (admin access only)
1. Have a name, which is unique
2. has_many :profiles_categories
3. has_many :profiles, through: :profiles_categories

### Skills
1. Have a name (must be present) and description (not mandatory)
2. belongs_to :profile
3. belongs_to :user, through: profile
4. Enables nested_attributes



For more information, check out [`:class_name`][class_name] and [`:foreign_key`][foreign_key] in the RailsGuides entry on [Active Record Associations][RailsGuides], this [StackOverflow post][StackOverflow], and the `models/post.rb` section in this [SitePoint refresher][SitePoint].

## Resources
* [RailsGuides — Active Record Associations][RailsGuides]
  - [`:class_name`][class_name]
  - [`:foreign_key`][foreign_key]
* [StackOverflow — class_name foreign_key in Rails model][StackOverflow]
* [SitePoint — Brush up your knowledge of Rails associations][SitePoint]
* [Video: Lab Review](https://www.youtube.com/watch?v=x_qQCnYPyBk)

[RailsGuides]: http://guides.rubyonrails.org/association_basics.html
[class_name]: http://guides.rubyonrails.org/association_basics.html#options-for-belongs-to-class-name
[foreign_key]: http://guides.rubyonrails.org/association_basics.html#options-for-belongs-to-foreign-key
[StackOverflow]: https://stackoverflow.com/a/41135173
[SitePoint]: https://www.sitepoint.com/brush-up-your-knowledge-of-rails-associations/

<p class='util--hide'>View <a href='https://learn.co/lessons/flatiron-store-project'>Flatiron Store Project</a> on Learn.co and start learning to code for free.</p>
