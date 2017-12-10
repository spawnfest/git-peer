# GitPeer
Using Elixir, make a peer-to-peer github-like repository with a command line interface.

# Default functionality
Who's around you (within the same local network or IP address server)
Active connections
Reviews pending

# Sub-commands

* review
  review comes up with notification on other person’s
  * specify file or current branch
  * specify by users
	can use flags to do this
  * default is available for everybody to review

* connect
  Connect with people around you
* conflict
  changes in local branch, want to see if people are working on the same files or finer grain change
* branches
  check out different branches

Once somebody has accepted you within that group, your are connected to everybody.

# Connection
1. You install the program and ‘git-peer’ → searching for peers
2. Found peer -> list of all available peers show up on screen
4. When you try to connect to a peer, it connects to a public ssh key
5. On the other side, they get an email and a key to authorize connection
6. Connected -> connection has been established.
7. Syncing of states -> If peer has set up an open request for review, you receive that. Vice versa.

## Issue Review
Have a working branch, want someone to review the branch → ‘github name’/‘branch name’/’specific file name’/’specify freeze’
Branch name sends most up-to-date code
File name sends the specific file to review
Specify freeze sends hash of that
That gets sent to a person or everybody to review
When you do the next git-peer command, you see that someone has a new review → new reviews available
Check out a DIF that it’s on another computer → ‘start git-review’

# Implemented command stubs

When running git-peer with no arguments:
git-peer: A distributed Git collaboration tool

## Valid commands include

* view and manage branches
  branch

* perform conflict resolution
  conflict

* connect to a git-peer network:
  connect <IP-address> <Port>

    If connection has been established, you receive a confirmation message.

    If connection fails to be established, you receive an error message.

    State synchronization starts right after connection is established.

* access help screen:
  help

* review a ref, or request a review on a ref:
  start <user> <ref-number>
* Shows the difference of the <ref>
  request <ref>

    Requests a review of <ref> where <ref> is a branch name or hash.
    If not specified, review can be done by any connected users

* open <user> <ref>
  opens a review of <ref> for user <user>

* list
  list <user> <ref>

    lists all pending requests for connected users
    lists a set of issues for review within the [users] specified
    allows user to select a specific <ref>

* see most recently updated reviews
  git-review

# Valid flags include

* list users
	--users

* list pending reviews for specific users
	--list-users

* access help screen:
	--help or -h

    Shows help screen.
    If a typo is entered into the command line, git returns This is not a git-peer command. See ‘git-peer help’.
