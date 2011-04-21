# AskStack

This is an experimental program that lets you compose a Stack Overflow
question in a text file and then automate the submission of it.

The reason I started this project is that I really dislike filling in
web forms.  They feel retarded after you have gotten used to using Vim
and living in the Unix shell environment.

This project is alpha and is really only a proof of concept at this
stage.

## Instructions

First you have to fire up an instance of SeleniumRC on your computer.

You can start SeleniumRC with

    java -jar vendor/selenium-server-standalone-2.0b3.jar 

This should be done in a different terminal window from the one you will
be running ask_stack.rb in.

The next step is to compose your question in a text file.

The text file should follow this format:

    How to use omniauth to make authenticated calls to services?

    I've received a token / secret from a service using OmniAuth and can
    store it for users, but I'm stuck as to how to actually use these to
    call a service.

    The closest thing I've seen to this question is here but the way
    he's solved that there doesn't feel right. I feel like OmniAuth
    likely does this all for you if you know what you're doing.

    Netflix has a pretty involved auth process, so I was hoping to skirt
    all of this by using OmniAuth to abstract me from all of this.

    Given that I have a token and secret for a user, how to use these in
    calling a service like Netflix?

    Many thanks :)

    ruby-on-rails ruby omniauth netflix 

The first line is the title of the question, then there is a blank line,
and then the body of the question follows. The last line of the text
file should contain your tags for the question, separated by spaces.

There is no autocompletion of tags or auto-suggestion of similar
questions yet.

Finally, before submitting your question, you need to put your OpenID
credentials in a ask_stack.yml file in the directory where you're going
to run the program from. For the alpha version, only Google is
accepted as an OpenID provider.

The `ask_stack.yml` should look like this:

    username: danchoi@gmail.com
    password: secret

OK now you can try submitting your question like this.

    ask_stack < question.txt



