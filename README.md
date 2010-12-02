# Melody Compatibility Layer for Movable Type v4.x #

An addon for MT 4.x that aims to provide compatibility with most Melody
plugins by providing backports for certain popular API features in Melody.

## FEATURES ##

Currently, this plugin augments the Movable Type plugin API with the following Melody-originated features:

   * The `plugin_class` `config.yaml` attribute through which you can
     designate a class from one of your plugin's modules to be the plugin's
     canonical MT::Plugin subclass. This allows you to override inherited
     methods (e.g. `save_config`/`load_config`) of MT::Plugin to provide
     custom behavior.

   * The `MT::App::query()` feature which is the new way of retrieving the
     query object in Melody since the old ways of interacting with it (e.g.
     `$app->param()` and `$app->{query}`) conflict with CGI::Application to
     which Melody intends to migrate. Providing this method saves a lot of
     extra typing that was necessary to determine whether to use the old
     methods (for MT) or the new (for Melody)

## PLUGIN REQUIREMENTS ##

   * Movable Type v4.x

## LICENSE ##

This plugin is licensed under the same terms as Perl itself.

## INSTALLATION ##

To install this plugin follow the instructions found on [this
page](http://tinyurl.com/easy-plugin-install) ***EXCEPT*** that the
`Melody-compat.pack` directory must be installed into the **`addons`**
directory and **not the `plugins`** directory.

If you do not have an addons directory, you can simply create one in the root
of your MT directory (`$MT_HOME/addons`).

## CONFIGURATION ##

There is no configuration for this plugin.

## LIMITATIONS ##

No known bugs or limitations

## FUTURE PLANS ##

None currently but when new important API features arise in Melody, we will consider adding them if it will make Melody developers' lives easier.

## HELP, BUGS AND FEATURE REQUESTS ##

If you are having problems installing or using the plugin, please check out our general knowledge base and help ticket system at [help.endevver.com](http://help.endevver.com).

## COPYRIGHT ##

Copyright 2010, Endevver, LLC. All rights reserved.

## ABOUT ENDEVVER ##

We design and develop web sites, products and services with a focus on 
simplicity, sound design, ease of use and community. We specialize in 
Movable Type and offer numerous services and packages to help customers 
make the most of this powerful publishing platform.

http://www.endevver.com/

