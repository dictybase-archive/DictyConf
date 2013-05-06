## Web application for Dictyostelium International Conference
Ruby on Rails web application for the Annual Dictyostelium International Conference - _v2_

[![Build Status](https://secure.travis-ci.org/dictyBase/DictyConf.png?branch=develop)](https://travis-ci.org/dictyBase/DictyConf) [![Coverage Status](https://coveralls.io/repos/dictyBase/DictyConf/badge.png?branch=develop)](https://coveralls.io/r/dictyBase/DictyConf) [![Dependency Status](https://gemnasium.com/dictyBase/DictyConf.png)](https://gemnasium.com/dictyBase/DictyConf)

#### Getting started

#### Configuration

Information in the application is populated from `config/custom/conference.yml`, which looks like

```yaml
conference:    
    year: 
    location: 
    begin: 
    end: 

hosts:
    host1:
        name: 
        email: 
        affiliation: 
    host2:
        name: 
        email: 
        affiliation: 

# Available - Agenda, Registration, Abstracts, Travel, Sponsors
# Default - Home, Login
menubar: ["Travel"]

agenda-file: 

registration:
    begin: '1st Jan 2013 11:59:00 PM'
    end: '15th Aug 2013 11:59:00 PM'

abstracts:
    begin:
```

##### [reCAPTCHA](https://www.google.com/recaptcha)

##### bcdatabase

#### Tests

To use `rspec`, add following to the `Gemfile`

```ruby
gem "rspec-rails", ">= 2.0.1", :group => [:development, :test]
gem 'assert_difference', :group => [:test]
```

##### Coveralls for code coverage

Add this to your `Gemfile`, 

```ruby
gem 'coveralls', require: false
```

#### Deploy

##### Capistrano
