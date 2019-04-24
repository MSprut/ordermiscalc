# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  CURRENCY = ' руб'
  counter = {}

  counter['related_calculations'] = 1
  counter['participants'] = 1
  counter['materials'] = 1
  counter['amortizations'] = 1
  ajax_requests = []

  window.getBlockPrefix = (obj, is_table) ->
    is_table = is_table || false
    if is_table == true
      class_name = $(obj).attr('class').match(/\w*_block_table\b/)[0]
    else
      class_name = $(obj).parents('table').attr('class').match(/\w*_block_table\b/)[0]
    prefix = class_name.substring 0, class_name.indexOf "_block_table" #get block prefix
    return prefix
  #Ф-ция перезагрузки списка материалов через контроллер
  window.getUnitAndPrice = (obj, attribute) ->
    #class_name = $(obj).parents('table').attr 'class'   #get table class name
    class_name = $(obj).parents('table').attr('class').match(/\w*_block_table\b/)[0]
    prefix = class_name.substring 0, class_name.indexOf "_block_table" #get block prefix

    num = $(obj).closest("tr").find("td.body-row-id").text()
    if num == "" then num = 0 else num -= 1

    switch prefix
      when 'related_calculations' then selection = $("#calculation_" + prefix + "_attributes_" + num + "_related_calculation_id option:selected").val()
      when 'positions' then selection = $("#calculation_calc_" + prefix + "_attributes_" + num + "_position_salary_id option:selected").val()
      when 'inventories' then selection = $("#calculation_calc_" + prefix + "_attributes_" + num + "_inventory_parameter_id option:selected").val()
      when 'equipments' then selection = $("#calculation_calc_" + prefix + "_attributes_" + num + "_equipment_parameter_id option:selected").val()

    return $.ajax
      url: "/calculations/get_unit_and_price"
      type: "GET"
      dataType: "script"
      data:
        block: prefix,
        selection: selection,
        num: num

  window.getCustomersPrices = ->
    calc_id = $('.calculation-id').val()
    cost = $('.direct-cost').val()
    ids = []
    $('.customer-category-id').each (index) ->
      ids.push $(this).val()
      #return

    return $.ajax
      url: "/calculations/get_customers_prices"
      type: "GET"
      dataType: "script"
      data:
        id: calc_id,
        direct_cost: cost,
        customer_category_ids: ids

  window.loadCategoryPercents = ->
    category_id = $('#calculation_calculation_category_ids option:selected').val()
    ids = []
    $('.customer-category-id').each (index) ->
      ids.push $(this).val()

    return $.ajax
      url: "/calculations/load_category_percents"
      type: "GET"
      dataType: "script"
      data:
        category_id: category_id,
        customer_category_ids: ids

  window.calcSingleRowSum = (obj) ->
    if $("#clone_main_show").length == 0 #&& $(obj).attr('id') != 'prices_table'
      class_name = $(obj).parents('table').attr('class').match(/\w*_block_table\b/)[0]
      prefix = class_name.substring 0, class_name.indexOf "_block_table" #get block prefix
      num = $(obj).closest("tr").find("td.body-row-id").text()
      show = 0
    else
      prefix = $(obj).attr 'id'
      num = $(obj).find("label[for='service_row_id']").text()
      show = 1

    if num == "" then num = 0 else num -= 1
    square = 0.000000
    quantity = (parseFloat($("#calculation_calc_" + prefix + "_attributes_" + num + "_quantity").val()) || 0)#.toFixed 4
    switch prefix
      when 'related_calculations'
        return false
      when 'inventories'
        width = (parseFloat($("#calculation_calc_" + prefix + "_attributes_" + num + "_width").val()) || 0)#.toFixed 2
        length = (parseFloat($("#calculation_calc_" + prefix + "_attributes_" + num + "_length").val()) || 0)#.toFixed 2
        price = (parseFloat($("label[for='calculation_calc_" + prefix + "_attributes_" + num + "_price']").text()) || 0)#.toFixed 4
        
        if width != "0.00" and length != "0.00"
          width = width / 1000.0
          length = length / 1000.0
          square =  width * length
        else
          square = 0.0

        if quantity != "0.00"
          if square == 0
              rowsum = price * quantity
          else
            rowsum = square * price * quantity
        else
          rowsum = 0.0
      when 'positions'
        salary = (parseFloat($("label[for='calculation_calc_" + prefix + "_attributes_" + num + "_salary']").text()) || 0)#.toFixed 4
        working_time = (parseFloat($("#calculation_calc_" + prefix + "_attributes_" + num + "_working_time").val()) || 0)#.toFixed 2
        time_coeff = (parseFloat($("#calculation_calc_" + prefix + "_attributes_" + num + "_time_coeff").val()) || 0)#.toFixed 2
        rowsum = salary * working_time * time_coeff
      when 'equipments'
        rate = (parseFloat($("label[for='calculation_calc_" + prefix + "_attributes_" + num + "_rate']").text()) || 0)#.toFixed 4
        usage_time = (parseFloat($("#calculation_calc_" + prefix + "_attributes_" + num + "_usage_time").val()) || 0)#.toFixed 2
        rowsum = rate * usage_time

    $("label[for='calculation_calc_" + prefix + "_attributes_" + num + "_rowsum']").text rowsum.toFixed 4
    $("label[for='calculation_calc_" + prefix + "_attributes_" + num + "_square']").text square.toFixed 6

  #Расчет ИТОГО
  window.CalcTotal = ->
    if $("#clone_main_show").length == 0
      amount = 0
      $('[class$="_block_table"]').each ->
        prefix = getBlockPrefix(this, true)
        block = $(this)
        rows = block.find 'tr.body-row'
        block_total = 0
        
        rows.each ->
          element = $(this).find '.row-note'
          if !element.is ':disabled'
            sum = $(this).find '.row-sum'
            tmp = Number(sum.text())
            block_total = Number(block_total + tmp)

        if !isNaN(block_total)
          $("label[for$='_total']", block).text(block_total.toFixed 4)
          amount += block_total
          $("label[for='calculation_price']").text(amount.toFixed 4)
          $('#calculation_price').val(amount.toFixed 4)

          if block_total != 0
            $("label[for='" + prefix + "_header_total']").text(block_total.toFixed(4) + CURRENCY)
          else
            $("label[for='" + prefix + "_header_total']").text 'пусто'
    #getCustomersPrices()

  window.calcCustomerPrice = ->
    if $("#clone_main_show").length == 0
      amount = 0
      block = $('.customers_prices_table')
      rows = block.find 'tr.body-row'
      direct = Number($('.direct-cost').val())

      rows.each ->
        overheads_percent = Number($(this).find('.overheads-perc').val())
        manager_percent = Number($(this).find('.manager-perc').val())
        profit_percent = Number($(this).find('.profit-perc').val())
        tax_percent = Number($(this).find('.tax-perc').val())

        overheads = direct * (overheads_percent / 100.0)
        manager = (direct + overheads) * (manager_percent / 100.0)
        costs = direct + overheads + manager
        profit = costs * (profit_percent / 100.0)
        price_not_tax = costs + profit
        tax = price_not_tax  * (tax_percent / 100.0)
        price = price_not_tax + tax

        if !isNaN(price)
          $(this).find('.customer-price').val(price.toFixed 4)

  #----- ROW SUM RECALCULATION ON KEY PRESS
  $('input, textarea').keyup (event) ->
    if event.target.id != "calculation_name" and !event.target.classList.contains('row-note') and
        !event.target.classList.contains('competitor-price')
        #event.target.title != 'note[]' and event.target.id != "adv_position_name" and
        #event.target.id != "adv_position_salary" and event.target.id != "adv_equipment_lifetime" and
        #event.target.id != "adv_equipment_name" and event.target.id != "adv_equipment_price" and
        #event.target.id != "adv_equipment_power" and event.target.id != "adv_material_name" and
        #event.target.id != "adv_material_price" and
        #event.target.id != "adv_module_name"
        #calcSingleRowSum @
        #CalcTotal()
      if !event.target.classList.contains('percent')
        ajax_requests.push(calcSingleRowSum @)
        $.when.apply($, ajax_requests).done ->
          CalcTotal()
      #getCustomersPrices()
      calcCustomerPrice()

  #----- GET UNIT AND PRICE FOR MATERIALS OR SERVICES
  window.onchangeMaterial = (obj) ->
    ajax_requests.push getUnitAndPrice obj, 0
    $.when.apply($, ajax_requests).done ->
      calcSingleRowSum obj
      CalcTotal()
      #getCustomersPrices()
      calcCustomerPrice()

  $("select[id$='_related_calculation_id'], select[id$='_position_salary_id'], select[id$='_inventory_parameter_id'], select[id$='_equipment_parameter_id']").change (event) ->
    obj = $(this)
    #$('input[id$="_adv_material_id"]').val($(this).val())
    ajax_requests.push(getUnitAndPrice(this, 0))
    $.when.apply($, ajax_requests).done ->
      calcSingleRowSum(obj)
      CalcTotal()
    #$.when.apply($, ajax_requests).done ->
      #getCustomersPrices()
      calcCustomerPrice()

  $("select[id$='_calculation_category_ids']").change (event) ->
    ajax_requests.push(loadCategoryPercents())
    $.when.apply($, ajax_requests).done ->
      CalcTotal()
      calcCustomerPrice()

    #----- CLONE SELECT VALUE FROM ORIGINAL TO CLONE
  window.cloneSelectValue = (original, clone, prefix) ->
    if prefix == 'inventories'
      original_value = $('.row-inventory-select', original).val()
      $('.row-inventory-select', clone).val original_value
    else
      original_value = $('[class$=\'-select\']', original).val()
      $('[class$=\'-select\']', clone).val original_value


  #----- CLEAR OBJECT VALUES IN COPIED OR CLONED ROW
  window.clearRowObjectsValues = (row, prefix) ->
    $(row).find('.row-quantity').val '0.00'
    $(row).find('.row-price').text '0.00'
    $(row).find('.row-sum').text '0.00'
    $(row).find('.row-width').val '0'
    $(row).find('.row-length').val '0'
    $(row).find('.row-salary').text '0.00'
    $(row).find('.row-square').text '0.00'
    $(row).find('.row-lifetime').text '0'
    $(row).find('.row-rate').text '0.00'
    $(row).find('.row-usage-time').val '0.00'
    $(row).find('.row-working-time').val '0.00'
    $(row).find('.row-note').val ''
    $(row).find('.row-time-coeff').val '0.00'
    $(row).find('.row-unit').text ''

    $(row).find('select[class$=\'-select\']').val ''
    
  #----- RENUMBER OBJECT ATTRIBUTES IN COPIED OR CLONED ROW
  window.renumberRowObjectsAttributes = (row) ->
    row_number = $(row).find('.body-row-id').text() #get cloned row number

    elements = $(row).find 'input, select, label' #find in row all input, select and label elements
    elements.each ->  #get and modify 'id', 'name' and 'for' attributes value for each finded element
      id = $(@).attr 'id'
      name = $(@).attr 'name'
      _for = $(@).attr 'for'

      if id != undefined  #replace old number for new number in 'id' attr value
        id = id.replace /\d+/g, row_number - 1
        $(@).attr 'id', id

      if name != undefined  #replace old number for new number in 'name' attr value
        name = name.replace /\d+/g, row_number - 1
        $(@).attr 'name', name

      if _for != undefined  #replace old number for new number in 'for' attr value
        _for = _for.replace /\d+/g, row_number - 1
        $(@).attr 'for', _for

  #----- REMOVE ROW FROM BODY OF ORDER BLOCK
  $(document).on 'click', '#btnX', (event) ->
    event.preventDefault()
    event.stopImmediatePropagation()

    class_name = $(this).parents('table').attr('class').match(/\w*_block_table\b/)[0]
    prefix = class_name.substring 0, class_name.indexOf "_block_table" #get block prefix
    master = $(@).parents 'table.' + class_name #get table object

    $(@).attr 'disabled', true  #set 'delete' button to disabled state

    number_cell = $(@).closest('tr').find('.body-row-id').css 'color', '#ddd'
    row_number = number_cell.text() #get button index saved in name attribute

    $(@).closest('tr').find('select, input, a').attr 'disabled', true #set object attr 'disabled' to true
    $(@).closest('tr').find('label').css 'color', '#d0d0d0' #set label color to 'disabled' value
    $('input[class=\'row_delete_member\']', master).eq(row_number - 1).attr 'value', 1 #set attribute :_destroy to "1"
    CalcTotal()
    #getCustomersPrices()
    calcCustomerPrice()
  #---------------------------------------------------------------------------------------

  #----- ADD ROW TO BODY OF ORDER BLOCK
  $('#add_row, #clone_row').off().click (c) ->
    c.preventDefault()
    c.stopImmediatePropagation()

    #class_name = $(@).parents('table').attr 'class' #get table class name
    class_name = $(this).parents('table').attr('class').match(/\w*_block_table\b/)[0]
    prefix = class_name.substring 0, class_name.indexOf '_block_table' #class_name.substring(0, class_name.indexOf("_block_table")) #get block prefix
    master = $(@).parents 'table.' + class_name #get table object
    body = master.find '.' + prefix + '_block_body' #find table body
    original = body.find('tr:last') #find last row in body
    original.find('select[class$="-select"]').combobox "destroy" #destroy combobox widget before row clone
    clone = original.clone(true)  #clone row
    #orig_sel = original.find '.row_material_selection'
    #orig_sel.combobox()
    #if orig_sel.is ':disabled'
    #original.find('select, input, a').attr 'disabled', true

    counter[prefix] += 1  #increase row counter

    number_cell = clone.find '.body-row-id' #find row cell for insert row number
    number_cell.text counter[prefix]  #set row number to cell
    number_cell.css 'color', 'black'  #set black color for number
    clone.find('input, select, button, a').attr 'disabled', false #set to false 'disabled' attr for object in row
    clone.find('label').css 'color', 'black'  #set black color for labels
    
    renumberRowObjectsAttributes clone

    if $(@).attr('id') != 'clone_row'
      clearRowObjectsValues clone, prefix #clear objects values
    else
      cloneSelectValue original, clone, prefix #clone all values
    body.append clone #append clone
    body.find('select[class$="-select"]').combobox() #create combobox for cloned select
    CalcTotal()
    #getCustomersPrices()
    calcCustomerPrice()
    return
    #--------------------- END ADD/CLONE

  #----- ROW RENUMBER IN EDIT MODE
  $ ->
    if $("#clone_main_show").length == 0
      $('table[class$="_block_table"]').each ->
        class_name = $(this).attr('class').match(/\w*_block_table\b/)[0]
        prefix = class_name.substring 0, class_name.indexOf "_block_table" #get block prefix
        #class_name = $(this).attr 'class' #get table class name
        #prefix = class_name.substring 0, class_name.indexOf "_block_table" #get block prefix
        rows = $(this).find '.body-row'
        counter[prefix] = 0

        rows.each -> #repeat for all finded row
          obj = $(this)
          row_id = obj.find '.body-row-id'

          row_id.text counter[prefix] + 1 #renumber the row numbers in column
          obj.find('td#del-btn').append '<button id="btnX" name="" class="btn btn-danger btn-xs del-btn">x</button>'
          #append index to button for get it in the button click funcrion
          obj.find('button#btnX').attr 'name', counter[prefix]  #i
          counter[prefix] += 1  

          ajax_requests.push getUnitAndPrice obj, ''
          $.when.apply($, ajax_requests).done ->
            calcSingleRowSum obj
            CalcTotal()
        $.when.apply($, ajax_requests).done ->
          #getCustomersPrices()
          calcCustomerPrice()

  #Фильтрует недопустимые символы в полях ввода при вводе цифр
  $('input').keypress (event) ->
    if event.target.id != "calculation_name" and !event.target.classList.contains('row-note') and
        event.target.id != "calculation_category_name" and
        event.target.id != "inventory_category_name" and
        event.target.id != "inventory_name" and
        event.target.id != "position_name" and
        event.target.id != "equipment_name" and
        event.target.id != "unit_name" and
        event.target.id != "customer_category_name" and
        event.target.id != "competitor_name"

      if event.which != 8 and event.which != 0 and (event.which < 48 or event.which > 57)
        if event.target.classList.contains('row-note') and #and event.target.title != 'note[]'
          event.target.id != "adv_position_salary" and
          event.target.id != "adv_material_price" and
          event.target.id != "adv_equipment_price" and
          event.target.id != "adv_equipment_power"
            return false
        else
          if (event.which < 45 or event.which > 46)
            if event.charCode == 44 || event.charCode == 110 || event.charCode == 188
              event.preventDefault()
              $(@).val $(@).val() + '.' #replace , with .
            else
              return false
      return

  $('.collapse-all').on 'click', (e) ->
    e.prevenDeffault()
    e.stopImmediatePropagation()
    $('.collapse').collapse('hide');

  $('.expand-all').on 'click', (e) ->
    e.prevenDeffault()
    e.stopImmediatePropagation()
    $('.collapse').collapse('show');

# COMBOBOX
  $ ->
    $.widget 'custom.combobox',
      _create: ->
        @wrapper = $('<span>').addClass('custom-combobox').insertAfter @element
        @element.hide()
        @_createAutocomplete()
        @_createShowAllButton()
        return
      _createAutocomplete: ->
        selected = @element.children(':selected')
        value = if selected.val() then selected.text() else ''
        @input = $('<input>').appendTo(@wrapper).val(value).attr('title', '')
        .addClass('custom-combobox-input ui-widget ui-widget-content ui-state-default ui-corner-left')
        .autocomplete(
          delay: 0
          minLength: 0
          source: $.proxy(this, '_source')).tooltip(classes: 'ui-tooltip': 'ui-state-highlight').focus ->
            $(@).find('input').select()
            $(@).select()
            return
        @_on @input,
          autocompleteselect: (event, ui) ->
            ui.item.option.selected = true
            @_trigger 'select', event, item: ui.item.option
            onchangeMaterial @element #Update unit and price after item selection
            return
          autocompletechange: '_removeIfInvalid'
        return
      _createShowAllButton: ->
        input = @input
        wasOpen = false
        #$('<a>').attr('tabIndex', -1).attr('title', 'Show All Items').tooltip().appendTo(@wrapper).button(
        $('<a>').attr('tabIndex', -1).appendTo(@wrapper).button(  #Without popup tooltip
          icons: primary: 'ui-icon-triangle-1-s'
          text: false).removeClass('ui-corner-all').addClass('custom-combobox-toggle ui-corner-right').on('mousedown', ->
          wasOpen = input.autocomplete('widget').is ':visible'
          return
        ).on 'click', ->
          input.trigger 'focus'
          # Close if already visible
          if wasOpen
            return
          # Pass empty string as value to search for, displaying all results
          input.autocomplete 'search', ''
          return
        return
      _source: (request, response) ->
        matcher = new RegExp($.ui.autocomplete.escapeRegex(request.term), 'i')
        response @element.children('option').map(->
          text = $(this).text()
          if @value and (!request.term or matcher.test(text))
            return {
              label: text
              value: text
              option: @
            }
          return
        )
        return
      _removeIfInvalid: (event, ui) ->
        # Selected an item, nothing to do
        if ui.item
          return
        # Search for a match (case-insensitive)
        value = @input.val()
        valueLowerCase = value.toLowerCase()
        valid = false
        @element.children('option').each ->
          if $(@).text().toLowerCase() == valueLowerCase
            @selected = valid = true
            return false
          return
        # Found a match, nothing to do
        if valid
          return
        # Remove invalid value
        @input.val('').attr('title', value + ' не совпадает ни с одной позицией').tooltip 'open'
        @element.val ''
        @_delay (->
          @input.tooltip('close').attr 'title', ''
          return
        ), 2500
        #@input.autocomplete('instance').term = ''
        @input.autocomplete().data("uiAutocomplete").term = '' #New syntax for prevent instance error
        return
      _destroy: ->
        @wrapper.remove()
        @element.show()
        return

  $ ->
    $('.row-related-calculation-select').combobox()
    $('.row-position-select').combobox()
    $('.row-inventory-select').combobox()
    $('.row-equipment-select').combobox()
    $('.calculation-categories').combobox()
    $('#toggle').on 'click', ->
      $('.row-related-calculation-select').toggle()
      return

# END COMBOBOX
