# AskStack

This is an experimental program that lets you compose a Stack Overflow
question in a text file and then automate the submission of it.

The reason I started this experiment is simple.  I hate filling in web
forms.  They feel retarded as well as unhealthy after you have gotten
used to using Vim and maneuvering in the Unix shell environment.  

This project is alpha and is only a proof of concept at this stage.

## Install

    gem install ask_stack

## Instructions

First you have to fire up an instance of SeleniumRC on your computer.

You can start SeleniumRC with

    ask_stack -s

This should be done in a different terminal window from the one you will
be running `ask_stack` in.  You only have to start up the Selenium
standalone server once.  You can leave this running in the background
indefinitely. 

The next step is to compose your question in a text file.

The text file (let's call this one question.txt) should follow this
format:

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
The body of the question can contain any of the special markup and
formatting that Stack Overflow accepts.

Note there is no autocompletion of tags or auto-suggestion of similar
questions (yet).  So try to choose tags that you've seen before on S.O.

Finally, before submitting your question, you need to put your OpenID
credentials in a ask_stack.yml file in the directory where you're going
to run the program from. For this proof of concept version, only Google
is accepted as an OpenID provider.

The `ask_stack.yml` should look like this:

    username: joelspolsky@gmail.com
    password: stackoverflowrocks

Now you can try submitting your question like this.

    ask_stack < question.txt

## Contributing

Please feel free to fork and add to this program. I would love for it to
be a community effort. Fight for the command line. 


