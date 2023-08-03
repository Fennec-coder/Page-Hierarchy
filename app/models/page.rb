# frozen_string_literal: true

# Класс Page представляет страницу на сайте, которая состоит из текстовых страниц,
# организованных в иерархию. Каждая страница имеет уникальное имя и может быть
# подстраницей другой страницы.
#
class Page < ApplicationRecord
  belongs_to :parent, class_name: 'Page', optional: true
  has_many :children, class_name: 'Page', foreign_key: 'parent_id', dependent: :destroy

  validates :name, presence: true, format:
    { with: /\A[\wа-яА-Я]+\z/, message: 'должно содержать только буквы, цифры или символ _' }

  validate :name_is_unique_among_children

  def to_param
    name
  end

  private

  def name_is_unique_among_children
    return unless Page.where(name: name, parent_id: parent_id).where.not(id: id).exists?

    errors.add(:name, 'не уникально среди подстраниц')
  end
end
