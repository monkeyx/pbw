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

Capabilities are associated with tokens and may define a number of callback functions.

The base Pbw::Capability model contains the attribute "name" by default. Additional attributes can be defined for your specific models.

    rails g pbw:rules:capability [Class] [additional attributes]

Example:

    rails g pbw:rules:capability Movement surface:boolean air:boolean instant:boolean cloaked:boolean

The capability generator will create:

* A model inheriting from Pbw::Capability 
* A controller with an index method for your capability plus index.html.erb template calling Backbone
* Backbone scaffold for your capability class

#### Command

Commands are classes of orders given to tokens by users that schedule a process to be executed. They may have parameters which define the specific order to be given.

    rails g pbw:rules:command [Class] [parameters]

Example:

    rails g pbw:rules:command MoveCommand area:string

The command generator will create:

* A model inheriting from Pbw::Command 
* Backbone model, views and templates for submitting commands

#### Constraint

Constraints are associated with areas and tokens and may define a number of callback functions. 

The base Pbw::Constraint model contains the attribute "name" by default. Additional attributes can be defined for your specific models.

    rails g pbw:rules:constraint [Class] [additional attributes]

Example:

    rails g pbw:rules:constraint ItemCapacity cargo:integer life:integer

The constraint generator will create:

* A model inheriting from Pbw::Constraint 
* A controller with an index method for your constraint plus index.html.erb template calling Backbone
* Backbone scaffold for your constraint class

#### Process

Processes are executed actions caused by commands or triggers. 

Processes may be tick based running in 0 or more ticks of the game engine or update based in which case they are scheduled to be run on the next engine update. 

The base Pbw::Process model contains the attribute "name" by default. Additional attributes can be defined for your specific models.

    rails g pbw:rules:process [Class] [additional attributes]

Example:

    rails g pbw:rules:process Travel

The constraint generator will create:

* A model inheriting from Pbw::Process 
* A controller with an index method for your process plus index.html.erb template calling Backbone
* Backbone scaffold for your process class

#### Trigger

Triggers are associated with areas and tokens and they are checked after processes are run. In turn, they may cause other processes to be run if they are run.

The base Pbw::Trigger model contains the attribute "name" by default. Additional attributes can be defined for your specific models.

    rails g pbw:rules:trigger [Class] [additional attributes]

Example:

    rails g pbw:rules:trigger BattleTrigger

The constraint generator will create:

* A model inheriting from Pbw::Trigger 
* A controller with an index method for your trigger plus index.html.erb template calling Backbone
* Backbone scaffold for your trigger class

## Authentication and Authorisation

Pbw uses Devise for authentication mounted within the Pbw engine itself.

It uses CanCan for authorisation with dynamic roles and permissions associated with models.

