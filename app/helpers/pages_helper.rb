# frozen_string_literal: true

# Помошник для представлений Page, отображает сложные конструкции
#
module PagesHelper
  # Рекурсивно отображает иерархическую структуру страниц на основе предоставленных данных.
  #
  # @param pages_data [Array<Hash>] Массив хешей, представляющих страницы с их атрибутами.
  # @param parent_id [Integer, nil] Идентификатор родительской страницы.
  #                                 Если указан nil, будут отображены корневые страницы.
  #
  # @return [String] HTML-код для отображения структуры страниц в виде вложенных списков.
  #
  # @example Пример использования:
  #   pages_data = [
  #     { 'id' => 1, 'parent_id' => nil, 'name' => 'страница' },
  #     { 'id' => 2, 'parent_id' => 1, 'name' => 'подстраница' },
  #     { 'id' => 3, 'parent_id' => 2, 'name' => 'подстраница' },
  #     { 'id' => 4, 'parent_id' => 3, 'name' => 'подподстраница' }
  #   ]
  #   render_page_hierarchy(pages_data) # Отобразит иерархическую структуру на основе данных в виде HTML-кода.
  #
  def render_page_hierarchy(pages_data, parent_id = nil, url = '')
    content_tag(:ul) do
      pages_data.select { |page| page['parent_id'] == parent_id }.each do |page|
        current_url = "#{url}#{page['name']}"
        concat(content_tag(:li, link_to(page['name'], URI.decode_www_form_component(page_path(current_url)))))
        concat(render_page_hierarchy(pages_data, page['id'], "#{current_url}/")) if children?(pages_data, page['id'])
      end
    end
  end

  # Описание:
  # Этот метод принимает текст в виде строки и форматирует его, заменяя специальные
  # теги на соответствующие HTML-теги для визуального форматирования текста.
  #
  # @param text [String] Исходный текст, который нужно отформатировать.
  #
  def format_page_text(text)
    text = text.gsub(/\*\[(.*?)\]\*/, '<b>\1</b>') # выделение жирным
    text = text.gsub(/\\\\\[(.*?)\]\\\\/, '<i>\1</i>') # выделение курсивом
    text = text.gsub(/\(\((.*?) (.*?)\)\)/, '<a href="/pages/\1">\2</a>') # ссылка на страницу
    text.html_safe
  end

  private

  def children?(pages_data, parent_id)
    pages_data.any? { |page| page['parent_id'] == parent_id }
  end
end
