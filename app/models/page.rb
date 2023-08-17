# frozen_string_literal: true

# Класс Page представляет страницу на сайте, которая состоит из текстовых страниц,
# организованных в иерархию. Каждая страница имеет уникальное имя и может быть
# подстраницей другой страницы.
#
class Page < ApplicationRecord
  belongs_to :parent, class_name: 'Page', optional: true
  has_many :children, class_name: 'Page', foreign_key: 'parent_id', dependent: :destroy

  validates :name,
            presence: true,
            format: { with: /\A[\wа-яА-Я]+\z/, message: 'должно содержать только буквы, цифры или символ _' },
            exclusion: { in: %w[add edit], message: 'не может быть "add" или "edit"' }

  validate :name_is_unique_among_children

  def to_param
    name
  end

  def self.find_pages_in_path(path)
    sql = <<~SQL
      WITH RECURSIVE PageHierarchy AS (
        SELECT *, 1 AS level
        FROM pages
        WHERE name = ? AND parent_id IS NULL

        UNION ALL

        SELECT t.*, ph.level + 1
        FROM pages t
        INNER JOIN PageHierarchy ph ON t.parent_id = ph.id
      )
      SELECT *
      FROM PageHierarchy
      WHERE name IN (?);
    SQL

    find_by_sql([sql, path.first, path])
  end

  private

  def name_is_unique_among_children
    return unless Page.where(name: name, parent_id: parent_id).where.not(id: id).exists?

    errors.add(:name, 'не уникально среди подстраниц')
  end
end
