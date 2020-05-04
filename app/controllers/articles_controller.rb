# encoding: utf-8
class ArticlesController < ApplicationController

  has_scope :by_article_type, as: :article_type
  has_scope :by_state, as: :state
  has_scope :by_user, as: :user_id
  has_scope :greater_than_min_age, as: :min_age
  has_scope :less_than_max_age, as: :max_age
  has_scope :greater_than_min_quantity, as: :min_quantity
  has_scope :less_than_max_quantity, as: :max_quantity

end
