module ApplicationHelper

  def nested_dropdown(items)
    result = []
    items.map do |item, sub_items|
        #result << [('- ' * item.depth) + item.name, item.id]
        result << [raw(("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" * item.depth) + item.name), item.id]
        result += nested_dropdown(sub_items) unless sub_items.blank?
    end
    result
  end

  def nested_groups(groups)
    s = content_tag(:ul) do
      groups.map do |group, sub_groups|
        content_tag(:li ,nil, class: "parent_li") do
          (content_tag(:span) do
            (group.has_children? ? content_tag(:i, nil, class: "fa fa-minus-square-o mr-1") : '') +
            group.name
          end +
           (link_to edit_inventory_category_path(group) do
              content_tag(:i, 'edit', class: "material-icons ml-2")
            end) +
           (link_to group, data: { confirm: 'Вы уверены? Категория ТМЦ будет удалена безвозвратно' }, method: :delete do
              content_tag(:i, 'delete_outline', class: "material-icons text-danger ml-2")
            end) +
           nested_groups(sub_groups)).html_safe
        end
      end.join.html_safe
    end
  end
end
