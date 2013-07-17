# Pbw

Play By Web Engine for Rails. This project is in early development. See [Wiki](https://github.com/monkeyx/pbw/wiki) for more information.

## Rails setup

This engine requires the use of Rails 3.2 or greater, coffeescript, devise and mongoid.

ActiveRecord is not used.

It creates apps that use Backbone for the front-end.

## Installation

In your Gemfile, add this line:

    gem 'pbw'

Then run the following commands:

    bundle install
    rails g pbw:install

The install generator will create:

* Backbone assets and directory layout in your app/assets/javascript directory
* Configuration file for mongoid in config directory
* Mount route for the pbw engine at "/pbw"
* Devise view templates in app/views/devise
* Application layout for the Pbw engine in app/views/pbw/layouts

## Generators

### Areas

Areas are locales within your game such as Rooms, Worlds or Regions. 

They may contain Tokens and Items. They may also have Contraints and Triggers.

The base Pbw::Area model contains the attribute "name" by default. Additional attributes can be defined for your specific models.

    rails g pbw:areas [Class] [additional attributes]

Example:

    rails g pbw:area Room description:string

The areas generator will create:

* A model inheriting from Pbw::Area 
* A controller with an index method for your area plus index.html.erb template calling Backbone
* Backbone scaffold for your area class

### Items

Items are classes of objects within your game such as Goods, Weapons or Vehicles. 

Individual items can be contained within containers associated with areas, tokens or users. They may also have conversion to other objects or transfers between containers defined. 

The base Pbw::Item model contains the attribute "name" by default. Additional attributes can be defined for your specific models.

    rails g pbw:item [Class] [additional attributes]

Example:

    rails g pbw:item TradeGood value:float description:string

The areas generator will create:

* A model inheriting from Pbw::Item 
* A controller with an index method for your area plus index.html.erb template calling Backbone
* Backbone scaffold for your item class

### Tokens

Tokens are classes of objects within your game such as Characters, Starships or Cities. 

Tokens may have capabilities, commands and constraints that define what they may do. Tokens may belong to a user and a user may have multiple tokens. They may also be associated with an area.

The base Pbw::Token model contains the attribute "name" by default. Additional attributes can be defined for your specific models.

    rails g pbw:token [Class] [additional attributes]

Example:

    rails g pbw:token Adventurer health:integer experience:integer

The tokens generator will create:

* A model inheriting from Pbw::Token 
* A controller with an index method for your token plus index.html.erb template calling Backbone
* Backbone scaffold for your token class

### Rules

#### Capability

#### Command

#### Constraint

#### Process

#### Trigger

## Authentication and Authorisation

Pbw uses Devise for authentication mounted within the Pbw engine itself.

It uses CanCan for authorisation with dynamic roles and permissions associated with models.

