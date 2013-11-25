A company dashboard based on shopifys [dashing framework](http://shopify.github.io/dashing/). It shows the icinga status (*normal*, *warning*, *critical*) for multiple environments on one nice and shiny dashboard. It also shows company relevant twitter messages just for the fun of it! There are some extra jenkins dashboards and widgets available to play with.

#How to use

* `bundle install`
* adjust job configurations (e.g. in `jobs/icinga.rb` etc.)
* adjust dashboard configurations (e.g. in `dashboards/jenkins-sphere.erb` etc.)
* add credentials in `credentials.yml`
```yaml
graphite:
  username:
  password:

icinga:
  username:
  password:

twitter:
  consumer:
    key:
    secret:
  oauth:
    token:
    token_secret:
```
* `dashing start`


#Available dashboards

- [http://localhost:3030/icinga](http://localhost:3030/icinga)
- [http://localhost:3030/grid](http://localhost:3030/grid)
- [http://localhost:3030/jenkins-grid](http://localhost:3030/jenkins-grid)
- [http://localhost:3030/jenkins-sphere](http://localhost:3030/jenkins-sphere)


Screenshot
==========

![image](https://raw.github.com/svenmueller/dashboard/master/assets/images/dashboard.png)
