web: sudo apt --assume-yes install libvips && RAILS_ENV=production rake db:migrate db:seed && chmod u+x bin/rails && RAILS_ENV=production bundle exec rake assets:precompile && RAILS_ENV=production bin/rails server -b 0.0.0.0 -p ${PORT:-3000}