module InventoryCategoriesHelper
  def show_inventories_categories_list(categories)

    categories.map do |category, sub_categories|
      (tag.div class: 'accordion-heading' do
        link = category.name.parameterize
        (link_to "##{category.name.gsub(/[\s,]+/, '-').downcase}", class: 'accordion-toggle', data: { toggle: "collapse" } do
          concat tag.i class: 'fa fa-folder'
          concat tag.span "#{category.name}"
          concat tag.span "подкат: #{category.children.count}", class: 'badge badge-success'
          concat tag.span "тмц: #{category.inventories.count}", class: 'badge badge-warning inventories-count'
        end) +
        (tag.div class: 'category-action pull-right' do
          (link_to edit_inventory_category_path(category) do
            (tag.i 'edit', class: "material-icons").html_safe
          end) +
          (link_to category, data: { confirm: 'Вы уверены?' }, method: :delete do
            (tag.i 'delete_forever', class: "material-icons text-danger mx-2").html_safe
          end)
        end)
      end) +

      (tag.div class: 'accordion-body collapse', id: "#{category.name.gsub(/[\s,]+/, '-').downcase}" do
        (tag.div nil, class: 'accordion-inner' do
          if category.inventories.present?
            concat (tag.table class: 'table table-striped table-sm table-light table-hover' do
              concat (tag.thead class: 'category-header' do
                concat (tag.tr class: 'd-flex' do
                  concat tag.th 'Наименование', class: 'col-7'
                  concat tag.th 'Ед. изм.', class: 'col-1'
                  concat tag.th 'Ст-ть, руб', class: 'col-2'
                  concat tag.th 'Действия', class: 'col-1'
                end)
              end) +

              (tag.tbody do
                category.inventories.order(name: :asc).each do |inv|
                  concat (tag.tr class: 'd-flex' do
                    concat tag.td inv.name, class: 'col-7'
                    concat tag.td inv.unit.name, class: 'col-1'
                    concat tag.td inv.inventory_parameters.last.try(:price), class: 'col-2'
                    concat (tag.td class: 'col-1' do
                      (link_to edit_inventory_path(inv) do
                        (tag.i 'edit', class: "material-icons").html_safe
                      end) +
                      (link_to inv, data: { confirm: 'Вы уверены?' }, method: :delete do
                        (tag.i 'delete_outline', class: "material-icons text-danger ml-2").html_safe
                      end)
                    end)
                  end)
                end
              end)
            end) 
          end
          concat show_inventories_categories_list(sub_categories).html_safe
        end)
      end)
    end.join.html_safe
  end

end
