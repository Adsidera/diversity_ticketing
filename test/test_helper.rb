# Use simplecov gem to track what code gets executed when tests
# are run and what doesn't: Run your tests, open up coverage/index.html
# in your browser and check out what you've missed so far.
require 'simplecov'
SimpleCov.start

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/autorun'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def admin_login
    session[:authenticated] = true
  end

  def make_event(event_params = {})
    defaults = {
      name: 'Event',
      start_date: 1.week.from_now,
      end_date: 2.weeks.from_now,
      description: 'Sed ut perspiciatis unde omnis.',
      organizer_name: 'Klaus Mustermann',
      organizer_email: 'klaus@example.com',
      organizer_email_confirmation: 'klaus@example.com',
      website: 'google.com',
      code_of_conduct: 'coc.website',
      city: 'Berlin',
      country: 'Germany',
      deadline: 5.days.from_now,
      number_of_tickets: 10,
      approved: false
    }
    event_params = defaults.merge(event_params)
    Event.create!(event_params)
  end

  def make_application(event, application_params = {})
    defaults = {
      name: 'Joe',
      email: 'joe@test.com',
      email_confirmation: 'joe@test.com',
      event: event
    }
    application_params = defaults.merge(application_params)
    Application.create!(application_params)
  end
  # Add more helper methods to be used by all tests here...
end

module Minitest::Assertions
  def assert_attribute_valid(event, attribute)
    event.valid?
    assert_equal [], event.errors[attribute]
  end

  def assert_attribute_invalid(event, attribute)
    event.valid?
    refute_equal [], event.errors[attribute]
  end
end
