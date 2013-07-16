# Pbw

Play By Web Engine for Rails.

## Rails setup

This engine requires the use of Rails 3.2 or greater, coffeescript, devise and mongoid.

ActiveRecord is not used.

## Installation

In your Gemfile, add this line:

    gem 'pbw'

Then run the following commands:

    bundle install
    rails g pbw:install

## Generators

### Areas

Areas are locales within your game such as Rooms, Worlds or Regions. 

They may contain Tokens and Items. They may also have Contraints and Triggers.

The base Pbw::Area model contains the attribute "name" by default. Additional attributes can be defined for your specific models.

    rails g pbw:areas [Class] [additional attributes]

Example:

    rails g pbw:area Room description:string

### Items

### Tokens

### Commands

### Rules

#### Capability

#### Constraint

#### Process

#### Trigger

