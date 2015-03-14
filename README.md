# Chitter
_____________________

This was my personal weekend challenge for Week 4 of Makers Academy, and was one of my favourites. The task was to create a an app that replicated the functionality of Twitter.

###Tools used

* Ruby
* Sinatra
* Data Mapper
* PostgreSQL
* Rack Flash

* Rspec
* Capybara
* Launchy

##Domain Model / CRC

A user, upon logging in, can send 'peeps' and view the 'peeps' of other users that he/she 'follows'. A user can search for and choose to 'follow' other users in order to see their 'peeps', can reply to these peeps, and can 'favourite' the peeps that he/she particularly likes.

Classes:
* User
* Peep
* Reply

___________________________

##How to use

``` $ bundle install```

``` $ rackup ```

_______________________________

##Issues faced

I had a bit of an issue with 'magic numbers' initially, but realised I could pull the logic into the models.


##Future intentions

I would like to continue implementing other 'twitter' features. I would like to improve the front-end significantly, ideally using Javascript and Handlebar.js - allowing me to rewrite the application such that it serves
only one html from the server, and then to create a JSON API and have the front end speak to this.


