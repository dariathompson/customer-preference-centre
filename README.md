# Customer Preference Centre
[Installation](#installation) | [Running the program](#running-the-program-from-irb) | [Approach](#approach) | [User Stories](#user-stories)

Backend Role Technical Exercise

## Installation
### Setup
From command line run
```
git clone https://github.com/dariathompson/customer-preference-centre
cd customer-preference-centre
```
Ensure you have installed budler
```
gem install bundler
```
### Install dependencies
```
bundle install
```
### Run tests
```
rspec
```

## Running the program from irb
To open irb from command line run
```
irb
```
```
% irb                                                        
2.7.0 :001 > require './lib/preference_centre.rb'
2.7.0 :002 > centre = PreferenceCentre.new
2.7.0 :003 > centre.add_customer
Please type your name
Daria   
When would you like to receive marketing information??
```
Follow the instructions on the screen to answer the questions.\
To print the report call on method ```print_report```
```
2.7.0 :004 > centre.print_report

Thu 01-October-2020 Kate 
Fri 02-October-2020 Kate Christina
Sat 03-October-2020 Kate
Sun 04-October-2020 Kate Daria
Mon 05-October-2020 Kate
```

## Approach
* I chose to complete this tech test in Ruby as I am most comfortable in it and I love RSpec for testing.
* I decided to make a console program as it is easy to use and covers all the requirements.
* First I created user stories based on requirements.
* Structured my code based on user stories.

| Class          | PreferenceCentre | Customer  | Report    |
| :------------- | :----------- | :----------- | :----------- |
| Attributes | customers, report | name, preferred_dates | customers |
| Methods | add_customer, print_report | | print_dates |

* PreferenceCentre class creates new instances of Customer when user adds a new customer. PreferenceCentre stores all the customers.
* Customer class stores a name and preferred dates to receive marketing information
* Report is initialised in PreferenceCentre class when user prints a report.
* User can add more customers after printing the report and it will get updated if printed again.
* After covering basics, I started thinking of the edge cases: what if users do not pass their names; what if users pass empty spaces as their names; what if they choose a date out of range; what if the user types anything but an integer in the range; what if the user types anything but a day of the week. In those cases user should see a helpful message.
* I used Test Driven Development through the process.

## User Stories
```
As a customer,
So I can choose when to receive marketing information,
I want to be able to select a specific date of the month from the range of 1-28
```
```
As a customer,
So I can choose when to receive marketing information,
I want to be able to select each specified day of the week
```
```
As a customer,
So I receive marketing information every day,
I want the option to select ‘every day’ 
```
```
As a customer,
So I ensure I never receive marketing information,
I want the option to select ‘never’ 
```
```
As a preference centre,
So we can send information to people,
We want to have a system that stores choices of multiple customers
```
```
As a preference centre,
So we know when to send the information,
We want to produce the report of the upcoming 90 days
```
