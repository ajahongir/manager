module ApplicationHelper

  def sortable column, title = nil
    title ||= column.titleize

    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    #TODO = test brockes if use content_tag instead.
     col = <<-tag
      <th class="sort">
        <div class="sort">
          #{ ("<div class='sort-" + direction + "'></div>") if column == sort_column }
        </div>
        <a href='#{ url_for(pagination_params.merge(sort: column, direction: direction, page: nil)) }'>#{ title }</a>
      </th> 
    tag
    col.html_safe
  end

  def active_page(controller_name)
    'active' if params[:controller] == controller_name
  end

  def pagination_params
    params.reject{ |key, value| %w(id action).include? key }
  end
end