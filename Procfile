web: FAST=1 bundle exec rails s -p 5001
worker1: FAST=1 IS_SCHEDULER=1 bundle exec sidekiq
redis: redis-server ./redis.development.conf
