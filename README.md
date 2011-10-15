Riak Cookbook for Scalarium
=========

Based on the excellent work of [Scott Likens](http://github.com/damm). He wrote [this
cookbook](http://github.com/damm/ey-riak) to automate Riak on the EY AppCloud, and I blatantly copied his work an
adapted it to work on [Scalarium](http://scalarium.com). Thanks, Scott!

[Riak][1] is a Dynamo-inspired key/value store that scales predictably and easily. Riak also simplifies development by giving developers the ability to quickly prototype, test, and deploy their applications.

A truly fault-tolerant system, Riak has no single point of failure. No machines are special or central in Riak, so developers and operations professionals can decide exactly how fault-tolerant they want and need their applications to be.

Overview
--------

This cookbook once complete will attempt to provide one method of "Hosting" a Riak Ring on AppCloud.  It will not run inside your regular environment as this cookbook will attempt to achieve a scaleable stable Riak configuration with the least disruption of automation possible.

Design
--------

* 2-3+ instances (m1.large or larger)
* Riak 0.14.2 with Bitcask
* haproxy on each app instance listening on port 8198 (HTTP) and 8187 (PBC) directing to the Riak instances.

Notes
--------

This Cookbook automates the creation (join) action of a Riak 'Ring' on Scalarium.  As your needs may vary it is suggested to fork this recipe and make any customization you do on the fork.  You can omit the main cookbook it is only there for my testing purposes.

Specifics of Usage
--------

It is recommended to run Riak on a Ubuntu 9.10 cluster, not on 10.04 LTS, which Scalarium does support, but which is
known for a good pile of bugs particularly affecting long-running and network-intensive processes like Riak.

Create a custom role in Scalarium, its short name is expected to be "riak" (without the quotes).

* Add "riak" as a custom setup recipe to the role.
* Add "riak::haproxy" as custom configure recipe.
* If you want to use Riak Search, you can enable it using custom JSON, setting
  the `node[:riak][:search_enabled]` attribute to true.
* Give them EBS storage mounted on /vol/riak. You don't have to do that, and can just use the ephemeral storage instead though, but be sure to change the data directories accordingly. To use ephemeral storage, make sure to set the attribute `node[:volumes][:riak]` to e.g. `/mnt/riak` as part of your cloud's custom JSON. That'll make sure the data will actually end up on the large partition of the ephemeral storage, otherwise `/vol/riak` will be created on the root partition, which is only a couple of gigabytes in size.
* Don't forget to assign Elastic IPs, starting stopping instances without them will mess up your ring.
* Add instances, start them, boom!
  *Note*: Only start one instance at a time, wait for it to successfully start and setup to finish before starting the next one. Otherwise you will cause confusion in your cluster about which node to use for joining the cluster.

*NOTE*: Stopping instances does NOT remove them from the cluster. Use `riak-admin leave` or `riak-admin remove` to decommission them explicitly.

* Lastly, Words of Wisdom from Basho themselves.

> you should look at the ring ready command and make it returns 0 before adding the next node
> if you try and do more than 4 or 5 nodes the gossip is a little heavy for ec2 right now
> and sometimes it takes a minute or two to converge the ring
> changing the gossip interval in the conf alleviates this somewhat

Storage Backends
--------

The cookbooks default to using [Bitcask](https://github.com/basho/bitcask), but include support for
[Innostore](https://github.com/basho/innostore) as well. To use the latter, specify a custom JSON for your cloud like
so:

    {
      "riak": {
        "storage_backend": "riak_kv_innostore_backend"
      }
    }

This will make sure that Innostore is both installed and configured properly for use with Riak. See the attributes file
for details on the available options.

If you want to use LevelDB, which you should, especially when finding yourself
considering Innostore, just use `"riak_kv_eleveldb_backend"`. Check the
[attributes](https://github.com/mattmatt/scalarium-riak/blob/master/riak/attributes/riak.rb)
file for all the available knobs and dials for the respective backends.

How to get Support
--------

* irc://irc.freenode.net/#riak
* This Github repository.
* [Twitter me](http://twitter.com/roidrage)
* Email: <mathias@basho.com>

* Additionally because of that there is *NO SUPPORT* for this recipe by Scalarium at this time.  If you have any problems with this recipe please open an issue, add a comment.  If you open a ticket regarding this cookbook you will be directed to this Github repository to open an issue.

[1]: http://wiki.basho.com
