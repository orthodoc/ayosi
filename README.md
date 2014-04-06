> **"If you cannot measure it, you cannot improve it."**
> Lord Kelvin

> **"The idea is to to be approximately right than be exactly wrong."**
> Ed Tufte

Ayosi 
======================

[![Build Status](https://travis-ci.org/orthodoc/ayosi.png?branch=master)](https://travis-ci.org/orthodoc/ayosi)
[![Code Climate](https://codeclimate.com/github/orthodoc/ayosi.png)](https://codeclimate.com/github/orthodoc/ayosi)
[![Coverage Status](https://coveralls.io/repos/orthodoc/ayosi/badge.png)](https://coveralls.io/r/orthodoc/ayosi)
[![Dependency Status](https://gemnasium.com/orthodoc/ayosi.png)](https://gemnasium.com/orthodoc/ayosi)
[![License](http://img.shields.io/license/GPlv3.png?color=green)](http://opensource.org/licenses/GPL-3.0)

This project aims to build a web application that will aid ortho surgeons to update
data on implants used in joint replacement surgeries. This is done in several
countries through a registry. However, in many other countries such a registry is
missing. And the ones that exist are closed and the data from them is not readily
available for public consumption. The goal of this project is to also involve
patients actively in the data submission process, especially related to outcome
studies. The project **does not** intend to replace a well functioning registry.

For Developers
======================

Fork the project and contribute!!

Follow these guides:

1. [Ruby Style Guide](https://github.com/bbatsov/ruby-style-guide)
2. [Rails Style Guide](https://github.com/bbatsov/rails-style-guide)
3. [Rails Best Practices](http://rails-bestpractices.com/posts/archive)
4. [Better Specs](http://betterspecs.org)
5. [Source Making](http://sourcemaking.com/)
6. [Code Guide](http://mdo.github.io/code-guide/)

The project relies on a postgresql database for persisting data. You'll have to set
up one your machine. Fill the database.yml file with your credentials to get started.

Working Features (Apr 7, 2014)
==============================

1. User registration, login, logout
2. Creating designations(default hospital or place of work)
3. Team formation
4. Member actions like activating, deactivating done
5. Inviting members by email
6. Patient biodata and surgery forms

To be done (Apr 7, 2014)
========================

1. Implant details from stickers
2. Uploading images
3. Outcome scores
4. Patient search
5. Dashboard
6. Patient communication

License
=====================

The code in this repository is covered by the GPL v3 license. The content is
available in LICENSE.txt.

(c) Biswajit Dutta Baruah 2014.

This application was generated with the [Rails apps composer gem]
(https://github.com/RailsApps/rails_apps_composer) provided by the [RailsApps Project]
(http://railsapps.github.io)
