Riak Cookbook for Scalarium
=========

Based on the excellent work of [Scott Likens](http://github.com/damm). He wrote this cookbook to automate Riak on the EY
AppCloud, and I blatantly copied his work an adapted it to work on [Scalarium](http://scalarium.com). Thanks, Scott!

[Riak][1] is a Dynamo-inspired key/value store that scales predictably and easily. Riak also simplifies development by giving developers the ability to quickly prototype, test, and deploy their applications.

A truly fault-tolerant system, Riak has no single point of failure. No machines are special or central in Riak, so developers and operations professionals can decide exactly how fault-tolerant they want and need their applications to be.

Overview
--------

This cookbook once complete will attempt to provide one method of "Hosting" a Riak Ring on AppCloud.  It will not run inside your regular environment as this cookbook will attempt to achieve a scaleable stable Riak configuration with the least disruption of automation possible.

Design
--------

* 2-3+ instances (m1.large or larger)
* Riak 0.14 with Bitcask
* haproxy on each app instance listening on port 8098 directing to the Riak instances.

Notes
--------

This Cookbook automates the creation (join) action of a Riak 'Ring' on Scalarium.  As your needs may vary it is suggested to fork this recipe and make any customization you do on the fork.  You can omit the main cookbook it is only there for my testing purposes.

Specifics of Usage
--------

Create a custom role in Scalarium, its short name is expected to be "riak" (without the quotes).

Add "riak" as a custom recipe to the role. Add instances, start them, boom!

* Lastly, Words of Wisdom from Basho themselves.

> you should look at the ring ready command and make it returns 0 before adding the next node
> if you try and do more than 4 or 5 nodes the gossip is a little heavy for ec2 right now
> and sometimes it takes a minute or two to converge the ring
> changing the gossip interval in the conf alleviates this somewhat

How to get Support
--------

* irc://irc.freenode.net/#riak
* This Github repository.
* [Twitter me](http://twitter.com/roidrage)

* Additionally because of that there is *NO SUPPORT* for this recipe by Scalarium at this time.  If you have any problems with this reciple please open an issue, add a comment.  If you open a ticket regarding this cookbook you will be directed to this Github repository to open an issue.

[1]: http://wiki.basho.com
