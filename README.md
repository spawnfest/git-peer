# GitPeer

# About

Using Elixir, make a peer-to-peer git for the command line interface.

It doesn't quite work currently since the connecting the cli to the
server was a bit trickier than expected :)

We have daemons connecting up with the help of partisan which gave
use a lot less problem than the standard erlang cluster interface.
But since it starts at a random port we wanted just to use the
erlang built in functionality for the cli -> server connection.

What is working is getting information from git that would be used
for reviewing and other functionality for the cli.
