# frozen_string_literal: true

# Create an admin to be used for testing and development
unless Rails.env.production?
  # Create admin
  FactoryBot.create(:admin, email: 'admin@job-board.com')
end
