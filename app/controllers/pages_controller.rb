# frozen_string_literal: true

# Контроллер, отвечающий за управление страницами сайта.
# Взаимодействие с контроллером происходит через корневой URL (/).
#
class PagesController < ApplicationController
  def index
    @pages_hierarchy = Page.order(:parent_id)
  end

  # GET /add
  # Метод new отображает форму для создания новой страницы.
  # Если передан параметр в URL (например, '/some_page/add'),
  # то страница будет создана в качестве дочерней к указанной странице.
  # Отображение происходит через шаблон views/pages/new.html.erb.
  def new
    by_path_page do |page|
      @page = Page.new(parent: page)
      params[:name] ||= pages_path
    end
  end

  def create
    @page = Page.new(page_params)

    if @page.save
      pages = (params[:name] || '/').split('/')
      path_to_page = (pages[0..-2] << (@page.name)).join('/')
      redirect_to page_path(path_to_page), notice: 'Страница успешно добавлена.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    by_path_page { @page = _1 }
  end

  def edit
    by_path_page { @page = _1 }
  end

  def update
    @page = Page.find_by(id: page_params[:id])

    if @page&.update(page_params)
      pages = params[:name].split('/')
      path_to_page = (pages[0..-3] << (@page.name)).join('/')

      redirect_to page_path(path_to_page), notice: 'Страница успешно изменена.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @page = Page.find_by(id: params[:id])

    if @page.delete
      redirect_to root_path, notice: 'Успешно удалено'
    else
      head :internal_server_error
    end
  end

  private

  # Метод not_found используется для обработки ситуации, когда
  # страница не найдена (ошибка 404). Отображает страницу 404.html
  # из папки public.
  def not_found
    render file: Rails.public_path.join('404.html'), status: :not_found, layout: false
  end

  def page_params
    params.require(:page).permit(:id, :name, :title, :body, :parent_id)
  end

  # Метод by_path_page ищет страницу по указанному в параметрах URL пути.
  # В случае успешного поиска, передает найденную страницу в блок.
  # Если страница не найдена, вызывает метод not_found для обработки ошибки 404.
  def by_path_page
    page_search = GetPageByPath.new(params[:name]).call

    if page_search.success?
      yield page_search.value!
    else
      not_found
    end
  end
end
