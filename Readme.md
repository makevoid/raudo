# Raudo

### notes:

Install eventmachine on mac m1:

```
PKG_CONFIG_PATH="$(brew --prefix openssl)/lib/pkgconfig" gem install eventmachine
```

### current status

screenshots:

![](https://raw.githubusercontent.com/makevoid/raudo/master/screenshots/raudo_ui.png)

contains:

- oauth with ruby
- only the app part works, but it let you deploy
- of the tasks / buttons, only deploy, restart, setup and rake work
- nice mobile friendlty UI done in materialize

### Setup

```
bundle
bower install
npm install
```

You need to go to Google developer console (https://console.developers.google.com) and:

- Create a new application
- Add a OAuth 2.0 client IDs App credential
- specify an authorized callback/redirect url: http://YOUR_HOST/auth/google_oauth2/callback
- Enable the Google+ API ( https://console.developers.google.com/apis/api/plus/overview )

Then add your CLIENT ID and SECRET in the `~/.google_auth` file on your web user

Refer to the official google documentation for extra infos on any of these steps.

Enjoy!



---

TODO:

- refuse to start the app if rack session is not set
- list page: include the git commit hash
- add mruby integration for nginx: https://github.com/matsumoto-r/ngx_mruby
- logs
- slack integration (notification)


on a different fork, add automated assets repo building

- git repo build assets automatically
