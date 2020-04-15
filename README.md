# README

This project is made with ruby, backbone, postgres and redis

Things you may want to cover:

* run bundle install
* make sure pg and redis server are running
* create caminos.yml and databse.yml with the corrects env variables
* rake db:create db:migrate db:seed
* rails s

### PostGIS
Reinstallation of PostGIS extension:
```sql
ALTER EXTENSION postgis UPDATE;
```

### I18n
To generate i18n strings used in javascript files run
```
rake i18n:js:export
```
