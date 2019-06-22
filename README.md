### README

I have implemented the solution using Ruby on Rails

I have created a post API endpoint that received a file as its parameter and processes the file content

``` post 'invitations/calculate_score' ```

Each line tells the backend who recommended whom and who accepted the invitation and assigns points to recommenders

It's pretty straight forward, I just split the file by lines and the spaces, so nothing fancy

There is a test that sends the example file to the api and checks the output

In order to run clone the repository, then ``` bundle install ``` and then running ``` rake ``` should run the test for you

if you want to call the api manually, run ``` rails server ``` and then post to 'http://localhost:3000/invitations/calculate_score' with the test file using 'file' as the parameter name

Things to pay attention to

* We should care whose invitation is accepted, maybe users A and B invite user C, but C accepts the second invitation and not the first one
- Here in the code, we assume a user can only invite other users once they have accepted, so once a user accepts an invitation, we assume the inviter is already accepted and we don't check for that. In other words, we assumed the input file is sane and didn't check for irregularities in it
