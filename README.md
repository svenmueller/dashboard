A company dashboard based on shopifys dashing framework. It shows the icinga status (*normal*, *warning*, *critical*) for multiple environments on one nice and shiny dashboard. It also shows company relevant twitter messages just for the fun of it! There are some extra jenkins dashboards and widgets available to play with.

#How to use

* install dashing framework [dashing](http://shopify.github.io/dashing/)
* download/clone project
* adjust job configurations (e.g. in `jobs/icinga.rb` etc.)
* adjust dashboard configurations (e.g. in `dashboards/jenkins-sphere.erb` etc.)
* add credentials in `credentials.yml` (do *not* commit this file)
* use `git update-index --assume-unchanged credentials.yml` to avoid commiting the `credentials.yml` accidently
* start dashboard
 
```bash
$ dashing start
```

#Available dashboards

- [http://localhost:3030/icinga](http://localhost:3030/icinga)
- [http://localhost:3030/grid](http://localhost:3030/grid)
- [http://localhost:3030/jenkins-grid](http://localhost:3030/jenkins-grid)
- [http://localhost:3030/jenkins-sphere](http://localhost:3030/jenkins-sphere)


Screenshot
==========

![image](https://raw.github.com/svenmueller/dashboard/master/assets/images/dashboard.png)

