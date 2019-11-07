## Running rms

Running quo_sim rails require following steps

### Installing pre-requisite

To run rms on your development machine make sure you have configured your rvm and you have install ruby-2.6.3, if not run following command to install ruby-2.6.3
```ruby
rvm install 2.6.3
```

after installing, make sure you are using it in your current shell session. To use it in your current shell session. Please enter following command.
```ruby
rvm use 2.6.3
```
One more pre-requisite is postgresql. Please make sure you have installed it and have a user in it.

### Cloning the repository
To clone the repository enter following command.
```
git clone https://github.com/sunnys-s/rms.git
```

### Running the  API application.
After cloning the repository to run it you have to do following
1. ```bundle install```
2. Update the username and password in **database.yml** file to match the username and password in your machine.
3. ``` rails db:create ```
4. ``` rails db:migrate ```
5. ``` rails db:seed ``` This command will create the default user in your application. You can get the credentials in **seed.rb** file.
6. ``` rails s -b 0.0.0.0 ```
