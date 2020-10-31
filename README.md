# README

**Ruby Version**: 2.7.0

To run this application

    rails db:migrate
    rails db:seed
    rails s

This will generate a new admin user for you if your env is not production, and you can use that admin user for accessing admin routes

You can register for a new user and try out the other routes via the register route

    /auth/sign_up

You can view the entire application routes either by visiting
    
    /rails/info/routes
in your browser, or by running this command

    rails routes
