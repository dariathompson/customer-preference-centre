# Customer Preference Centre
Backend Role Technical Exercise

## Approach
* I chose to complete this tech test in Ruby as I am most comfortable in it and I love RSpec for testing
* I decided to make a console program as it is easy to use and covers all the requirements
* First I created user stories based on requirements
* Structured my code based on them

| Class          | PreferenceCentre | Customer  | Report    |
| :------------- | :----------- | :----------- | :----------- |
| Attributes | customers, report | name, preferred_dates | customers |
| Methods | add_customer, print_report | | print |

* After covering basics started thinking of edge cases: what if users do not pass their names; what if they choose date out of range; what if user types anything but integer in the range; what if user types anything but day of the week
* Made assumptions: users have to put their names so their choices are saved

## User Stories
```
As a customer,
So I receive marketing information in suitable for me time,
I want to be able to select a specific date of the month from the range of 1-28
```
```
As a customer,
So I receive marketing information in suitable for me time,
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
