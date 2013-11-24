A company dashboard based on shopifys dashing framework. It shows the icinga status (*normal*, *warning*, *critical*) for multiple environments on one nice and shiny dashboard. It also shows company relevant twitter messages just for the fun of it!

#

#How to use

* install dashing framework [dashing](http://shopify.github.io/dashing/)
* download/clone project
* adjust job configurations (e.g. in `jobs/icinga.rb` etc.)
* add credentials in `credentials.yml` (do *not* commit this file)
* use `git update-index --assume-unchanged credentials.yml` to avoid commiting the `credentials.yml` accidently
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
