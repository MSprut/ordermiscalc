module CalculationCategoriesHelper
  def show_calculation_categories_list(categories)

    categories.map do |category, sub_categories|
      (content_tag :div, nil, class: 'accordion-heading' do
        (link_to "#id-#{category.name.gsub(/[\s,]+/, '-').downcase}", class: 'accordion-toggle', data: { toggle: "collapse" } do
          concat content_tag :i, nil, class: 'fa fa-folder'
          concat content_tag :span, "#{category.name}"
          concat tag.span "подкат: #{category.children.count}", class: 'badge badge-success'
          concat tag.span "кальк: #{category.calculations.not_deleted.count}", class: 'badge badge-warning inventories-count'
        end) +
        (tag.div class: 'category-action pull-right' do
          (link_to edit_calculation_category_path(category), target: :_blank do
            (tag.i 'edit', class: "material-icons").html_safe
          end) +
          (link_to category, data: { confirm: 'Вы уверены?' }, method: :delete do
            (tag.i 'delete_forever', class: "material-icons text-danger mx-2").html_safe
          end)
        end)
      end) +

      (content_tag :div, nil, class: 'accordion-body collapse', id: "id-#{category.name.gsub(/[\s,]+/, '-').downcase}" do
        (content_tag :div, nil, class: 'accordion-inner' do
          if category.calculations.not_deleted.present?
            concat (content_tag :table, nil, class: 'table table-striped table-sm table-light table-hover' do
              (content_tag :thead, nil, class: 'category-header' do
                concat (content_tag :tr, class: 'd-flex' do
                  @cust_cat_count = CustomerCategory.not_deleted.count
                  @compet_count = Competitor.not_deleted.count
                  concat content_tag :th, 'Наименование', class: "col-#{11-@cust_cat_count-@compet_count}"
                  CustomerCategory.not_deleted.each do |cc|
                    concat content_tag :th, cc.name, class: 'col-1'
                    end
                  Competitor.not_deleted.each do |cc|
                    concat content_tag :th, cc.name, class: 'col-1'
                  end
                  concat content_tag :th, 'Действия', class: 'col-1'
                end)
              end) +

              (content_tag :tbody do
                category.calculations.not_deleted.order(name: :asc).each do |calc|
                  concat (content_tag :tr, class: 'd-flex' do
                    unit = calc.unit.nil? ? '' : calc.unit.name
                    concat content_tag :td, "#{calc.name+'('+unit+')'}", class: "col-#{11-@cust_cat_count-@compet_count}"
                    #concat content_tag :td, '%.4f' % calc.price, class: 'col-2'
                    if calc.calc_prices.present?
                      calc.calc_prices.each do |cp|
                        concat content_tag :td, '%.2f' % cp.price, class: 'col-1 label-xs'
                      end
                    else
                      @cust_cat_count.times do
                        concat content_tag :td, '-', class: 'col-1 label-xs'
                      end
                    end
                    if calc.calc_competitors.present?
                      calc.calc_competitors.each do |cc|
                        concat content_tag :td, '%.2f' % cc.price, class: 'col-1 label-xs'
                      end
                    else
                      @compet_count.times do
                        concat content_tag :td, '-', class: 'col-1 label-xs'
                      end
                    end
                    concat (content_tag :td, class: 'col-1' do
                      (link_to edit_calculation_path(calc), target: :_blank do
                        content_tag(:i, 'edit', class: "material-icons").html_safe
                      end) +
                      (link_to calc, data: { confirm: 'Вы уверены?' }, method: :delete do
                        content_tag(:i, 'delete_outline', class: "material-icons text-danger ml-2").html_safe
                      end)
                    end)
                  end)
                end
              end)
            end) 
          end
          concat show_calculation_categories_list(sub_categories).html_safe
        end)
      end)
    end.join.html_safe
  end

end
