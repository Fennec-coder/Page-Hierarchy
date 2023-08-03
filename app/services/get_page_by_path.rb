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
  #   Если страница найдена, возвращает монаду Success с экземпляром страницы.
  #   Если страница не найдена, возвращает монаду Failure с сообщением об ошибке.
  def call
    # Отсутствие пути, так же будет считаться успешным поиском,
    # результатом которого будет являтся nil.
    return Success(nil) if @path.blank?

    possible_pages = Page.where(name: @path).order(:parent_id)

    return Failure('Ни одной из страниц не обнаружено') if possible_pages.blank?

    page = nil

    @path.each do |name|
      page = possible_pages.find { _1.parent_id == page&.id && _1.name == name }
      break if page.nil?
    end

    if page
      Success(page)
    else
      Failure('Страница не найдена')
    end
  end
end

