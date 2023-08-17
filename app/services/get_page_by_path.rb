# frozen_string_literal: true

# Класс GetPageByPath отвечает за поиск конкретной страницы в базе данных на основе указанного пути.
#
class GetPageByPath
  include Dry::Monads[:result]

  # @param path [String] Путь к желаемой странице, разделенный символом слеша ('/').
  def initialize(path)
    @path = path&.split('/')
  end

  # @return [Dry::Monads::Result] Монада, представляющая результат операции.
  def call
    return Success(nil) if @path.blank?

    page = Page.find_pages_in_path(@path)[@path.length - 1]

    return Success(page) if page

    Failure('Страница не найдена')
  end
end

