module InventoryCategoriesHelper
  def show_inventories_categories_list(categories)

    categories.map do |category, sub_categories|
      (tag.div class: 'accordion-heading' do
        link = category.name.parameterize
        (link_to "##{category.name.gsub(/\s+/, '-').downcase}", class: 'accordion-toggle', data: { toggle: "collapse" } do
          concat tag.i class: 'fa fa-folder'
          concat tag.span "#{category.name}"
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

      (tag.div class: 'accordion-body collapse', id: "#{category.name.gsub(/\s+/, '-').downcase}" do
        (tag.div nil, class: 'accordion-inner' do
          if category.inventories.present?
            concat (tag.table class: 'table table-striped table-sm table-light table-hover' do
              concat (tag.thead class: 'category-header' do
                concat (tag.tr do
                  concat tag.th 'Наименование'
                  concat tag.th 'Ед. измер-я'
                  concat tag.th 'Ст-ть, руб'
                  concat tag.th 'Действия'
                end)
              end) +

              (tag.tbody do
                category.inventories.each do |inv|
                  concat (tag.tr do
                    concat tag.td inv.name
                    concat tag.td inv.unit.name
                    concat tag.td inv.inventory_parameters.last.try(:price)
                    concat (tag.td do
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
