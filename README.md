A company dashboard based on shopifys dashing framework. It shows the icinga status (*normal*, *warning*, *critical*) for multiple environments on one nice and shiny dashboard. It also shows company relevant twitter messages just for the fun of it!

#

#How to use

* install dashing framework [dashing](http://shopify.github.io/dashing/)
* download/clone project
* adjust job settings/credentials
 * define icinga environments (url, username, password) to be shown on dashboard (`jobs/icinga.rb`)
 * define twitter keys/secrets (`jobs/twitter.rb`)
* start dashboard
 
```bash
$ dashing start
```
* open dasboard in browser

```
http://localhost:3030
```

Screenshot
==========

![image](https://raw.github.com/svenmueller/dashboard/master/assets/images/dashboard.png)
