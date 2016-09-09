(->
  $ = undefined
  Chosen = undefined

  extend = (child, parent) ->

    ctor = ->
      @constructor = child
      return

    for key of parent
      if hasProp.call(parent, key)
        child[key] = parent[key]
    ctor.prototype = parent.prototype
    child.prototype = new ctor
    child.__super__ = parent.prototype
    child

  hasProp = {}.hasOwnProperty
  $ = jQuery
  $.fn.extend chosen: (options) ->
    if !AbstractChosen.browser_is_supported()
      return this
    @each (input_field) ->
      $this = undefined
      chosen = undefined
      $this = $(this)
      chosen = $this.data('chosen')
      if options == 'destroy'
        if chosen instanceof Chosen
          chosen.destroy()
        return
      if !(chosen instanceof Chosen)
        $this.data 'chosen', new Chosen(this, options)
      return
  Chosen = ((superClass) ->
    `var Chosen`

    Chosen = ->
      Chosen.__super__.constructor.apply this, arguments

    extend Chosen, superClass

    Chosen::setup = ->
      @form_field_jq = $(@form_field)
      @current_selectedIndex = @form_field.selectedIndex
      @is_rtl = @form_field_jq.hasClass('chosen-rtl')

    Chosen::set_up_html = ->
      container_classes = undefined
      container_props = undefined
      container_classes = [ 'chosen-container' ]
      container_classes.push 'chosen-container-' + (if @is_multiple then 'multi' else 'single')
      if @inherit_select_classes and @form_field.className
        container_classes.push @form_field.className
      if @is_rtl
        container_classes.push 'chosen-rtl'
      container_props =
        'class': container_classes.join(' ')
        'style': 'width: ' + @container_width() + ';'
        'title': @form_field.title
      if @form_field.id.length
        container_props.id = @form_field.id.replace(/[^\w]/g, '_') + '_chosen'
      @container = $('<div />', container_props)
      if @is_multiple
        @container.html '<ul class="chosen-choices"><li class="search-field"><input type="text" value="' + @default_text + '" class="default" autocomplete="off" style="width:25px;" /></li></ul><div class="chosen-drop"><ul class="chosen-results"></ul></div>'
      else
        @container.html '<a class="chosen-single chosen-default"><span>' + @default_text + '</span><div><b></b></div></a><div class="chosen-drop"><div class="chosen-search"><input type="text" autocomplete="off" /></div><ul class="chosen-results"></ul></div>'
      @form_field_jq.hide().after @container
      @dropdown = @container.find('div.chosen-drop').first()
      @search_field = @container.find('input').first()
      @search_results = @container.find('ul.chosen-results').first()
      @search_field_scale()
      @search_no_results = @container.find('li.no-results').first()
      if @is_multiple
        @search_choices = @container.find('ul.chosen-choices').first()
        @search_container = @container.find('li.search-field').first()
      else
        @search_container = @container.find('div.chosen-search').first()
        @selected_item = @container.find('.chosen-single').first()
      @results_build()
      @set_tab_index()
      @set_label_behavior()

    Chosen::on_ready = ->
      @form_field_jq.trigger 'chosen:ready', chosen: this

    Chosen::register_observers = ->
      @container.bind 'touchstart.chosen', ((_this) ->
        (evt) ->
          _this.container_mousedown evt
          evt.preventDefault()
      )(this)
      @container.bind 'touchend.chosen', ((_this) ->
        (evt) ->
          _this.container_mouseup evt
          evt.preventDefault()
      )(this)
      @container.bind 'mousedown.chosen', ((_this) ->
        (evt) ->
          _this.container_mousedown evt
          return
      )(this)
      @container.bind 'mouseup.chosen', ((_this) ->
        (evt) ->
          _this.container_mouseup evt
          return
      )(this)
      @container.bind 'mouseenter.chosen', ((_this) ->
        (evt) ->
          _this.mouse_enter evt
          return
      )(this)
      @container.bind 'mouseleave.chosen', ((_this) ->
        (evt) ->
          _this.mouse_leave evt
          return
      )(this)
      @search_results.bind 'mouseup.chosen', ((_this) ->
        (evt) ->
          _this.search_results_mouseup evt
          return
      )(this)
      @search_results.bind 'mouseover.chosen', ((_this) ->
        (evt) ->
          _this.search_results_mouseover evt
          return
      )(this)
      @search_results.bind 'mouseout.chosen', ((_this) ->
        (evt) ->
          _this.search_results_mouseout evt
          return
      )(this)
      @search_results.bind 'mousewheel.chosen DOMMouseScroll.chosen', ((_this) ->
        (evt) ->
          _this.search_results_mousewheel evt
          return
      )(this)
      @search_results.bind 'touchstart.chosen', ((_this) ->
        (evt) ->
          _this.search_results_touchstart evt
          return
      )(this)
      @search_results.bind 'touchmove.chosen', ((_this) ->
        (evt) ->
          _this.search_results_touchmove evt
          return
      )(this)
      @search_results.bind 'touchend.chosen', ((_this) ->
        (evt) ->
          _this.search_results_touchend evt
          return
      )(this)
      @form_field_jq.bind 'chosen:updated.chosen', ((_this) ->
        (evt) ->
          _this.results_update_field evt
          return
      )(this)
      @form_field_jq.bind 'chosen:activate.chosen', ((_this) ->
        (evt) ->
          _this.activate_field evt
          return
      )(this)
      @form_field_jq.bind 'chosen:open.chosen', ((_this) ->
        (evt) ->
          _this.container_mousedown evt
          return
      )(this)
      @form_field_jq.bind 'chosen:close.chosen', ((_this) ->
        (evt) ->
          _this.input_blur evt
          return
      )(this)
      @search_field.bind 'blur.chosen', ((_this) ->
        (evt) ->
          _this.input_blur evt
          return
      )(this)
      @search_field.bind 'keyup.chosen', ((_this) ->
        (evt) ->
          _this.keyup_checker evt
          return
      )(this)
      @search_field.bind 'keydown.chosen', ((_this) ->
        (evt) ->
          _this.keydown_checker evt
          return
      )(this)
      @search_field.bind 'focus.chosen', ((_this) ->
        (evt) ->
          _this.input_focus evt
          return
      )(this)
      @search_field.bind 'cut.chosen', ((_this) ->
        (evt) ->
          _this.clipboard_event_checker evt
          return
      )(this)
      @search_field.bind 'paste.chosen', ((_this) ->
        (evt) ->
          _this.clipboard_event_checker evt
          return
      )(this)
      if @is_multiple
        @search_choices.bind 'click.chosen', ((_this) ->
          (evt) ->
            _this.choices_click evt
            return
        )(this)
      else
        @container.bind 'click.chosen', (evt) ->
          evt.preventDefault()
          return

    Chosen::destroy = ->
      $(@container[0].ownerDocument).unbind 'click.chosen', @click_test_action
      if @search_field[0].tabIndex
        @form_field_jq[0].tabIndex = @search_field[0].tabIndex
      @container.remove()
      @form_field_jq.removeData 'chosen'
      @form_field_jq.show()

    Chosen::search_field_disabled = ->
      @is_disabled = @form_field_jq[0].disabled
      if @is_disabled
        @container.addClass 'chosen-disabled'
        @search_field[0].disabled = true
        if !@is_multiple
          @selected_item.unbind 'focus.chosen', @activate_action
        return @close_field()
      else
        @container.removeClass 'chosen-disabled'
        @search_field[0].disabled = false
        if !@is_multiple
          return @selected_item.bind('focus.chosen', @activate_action)
      return

    Chosen::container_mousedown = (evt) ->
      if !@is_disabled
        if evt and evt.type == 'mousedown' and !@results_showing
          evt.preventDefault()
        if !(evt != null and $(evt.target).hasClass('search-choice-close'))
          if !@active_field
            if @is_multiple
              @search_field.val ''
            $(@container[0].ownerDocument).bind 'click.chosen', @click_test_action
            @results_show()
          else if !@is_multiple and evt and ($(evt.target)[0] == @selected_item[0] or $(evt.target).parents('a.chosen-single').length)
            evt.preventDefault()
            @results_toggle()
          return @activate_field()
      return

    Chosen::container_mouseup = (evt) ->
      if evt.target.nodeName == 'ABBR' and !@is_disabled
        return @results_reset(evt)
      return

    Chosen::search_results_mousewheel = (evt) ->
      delta = undefined
      if evt.originalEvent
        delta = evt.originalEvent.deltaY or -evt.originalEvent.wheelDelta or evt.originalEvent.detail
      if delta != null
        evt.preventDefault()
        if evt.type == 'DOMMouseScroll'
          delta = delta * 40
        return @search_results.scrollTop(delta + @search_results.scrollTop())
      return

    Chosen::blur_test = (evt) ->
      if !@active_field and @container.hasClass('chosen-container-active')
        return @close_field()
      return

    Chosen::close_field = ->
      $(@container[0].ownerDocument).unbind 'click.chosen', @click_test_action
      @active_field = false
      @results_hide()
      @container.removeClass 'chosen-container-active'
      @clear_backstroke()
      @show_search_field_default()
      @search_field_scale()

    Chosen::activate_field = ->
      @container.addClass 'chosen-container-active'
      @active_field = true
      @search_field.val @search_field.val()
      @search_field.focus()

    Chosen::test_active_click = (evt) ->
      active_container = undefined
      active_container = $(evt.target).closest('.chosen-container')
      if active_container.length and @container[0] == active_container[0]
        @active_field = true
      else
        @close_field()

    Chosen::results_build = ->
      @parsing = true
      @selected_option_count = null
      @results_data = SelectParser.select_to_array(@form_field)
      if @is_multiple
        @search_choices.find('li.search-choice').remove()
      else if !@is_multiple
        @single_set_selected_text()
        if @disable_search or @form_field.options.length <= @disable_search_threshold
          @search_field[0].readOnly = true
          @container.addClass 'chosen-container-single-nosearch'
        else
          @search_field[0].readOnly = false
          @container.removeClass 'chosen-container-single-nosearch'
      @update_results_content @results_option_build(first: true)
      @search_field_disabled()
      @show_search_field_default()
      @search_field_scale()
      @parsing = false

    Chosen::result_do_highlight = (el) ->
      high_bottom = undefined
      high_top = undefined
      maxHeight = undefined
      visible_bottom = undefined
      visible_top = undefined
      if el.length
        @result_clear_highlight()
        @result_highlight = el
        @result_highlight.addClass 'highlighted'
        maxHeight = parseInt(@search_results.css('maxHeight'), 10)
        visible_top = @search_results.scrollTop()
        visible_bottom = maxHeight + visible_top
        high_top = @result_highlight.position().top + @search_results.scrollTop()
        high_bottom = high_top + @result_highlight.outerHeight()
        if high_bottom >= visible_bottom
          return @search_results.scrollTop(if high_bottom - maxHeight > 0 then high_bottom - maxHeight else 0)
        else if high_top < visible_top
          return @search_results.scrollTop(high_top)
      return

    Chosen::result_clear_highlight = ->
      if @result_highlight
        @result_highlight.removeClass 'highlighted'
      @result_highlight = null

    Chosen::results_show = ->
      if @is_multiple and @max_selected_options <= @choices_count()
        @form_field_jq.trigger 'chosen:maxselected', chosen: this
        return false
      @container.addClass 'chosen-with-drop'
      @results_showing = true
      @search_field.focus()
      @search_field.val @search_field.val()
      @winnow_results()
      @form_field_jq.trigger 'chosen:showing_dropdown', chosen: this

    Chosen::update_results_content = (content) ->
      @search_results.html content

    Chosen::results_hide = ->
      if @results_showing
        @result_clear_highlight()
        @container.removeClass 'chosen-with-drop'
        @form_field_jq.trigger 'chosen:hiding_dropdown', chosen: this
      @results_showing = false

    Chosen::set_tab_index = (el) ->
      ti = undefined
      if @form_field.tabIndex
        ti = @form_field.tabIndex
        @form_field.tabIndex = -1
        return @search_field[0].tabIndex = ti
      return

    Chosen::set_label_behavior = ->
      @form_field_label = @form_field_jq.parents('label')
      if !@form_field_label.length and @form_field.id.length
        @form_field_label = $('label[for=\'' + @form_field.id + '\']')
      if @form_field_label.length > 0
        return @form_field_label.bind('click.chosen', ((_this) ->
          (evt) ->
            if _this.is_multiple
              _this.container_mousedown evt
            else
              _this.activate_field()
        )(this))
      return

    Chosen::show_search_field_default = ->
      if @is_multiple and @choices_count() < 1 and !@active_field
        @search_field.val @default_text
        @search_field.addClass 'default'
      else
        @search_field.val ''
        @search_field.removeClass 'default'

    Chosen::search_results_mouseup = (evt) ->
      target = undefined
      target = if $(evt.target).hasClass('active-result') then $(evt.target) else $(evt.target).parents('.active-result').first()
      if target.length
        @result_highlight = target
        @result_select evt
        return @search_field.focus()
      return

    Chosen::search_results_mouseover = (evt) ->
      target = undefined
      target = if $(evt.target).hasClass('active-result') then $(evt.target) else $(evt.target).parents('.active-result').first()
      if target
        return @result_do_highlight(target)
      return

    Chosen::search_results_mouseout = (evt) ->
      if $(evt.target).hasClass('active-result' or $(evt.target).parents('.active-result').first())
        return @result_clear_highlight()
      return

    Chosen::choice_build = (item) ->
      choice = undefined
      close_link = undefined
      choice = $('<li />', 'class': 'search-choice').html('<span>' + @choice_label(item) + '</span>')
      if item.disabled
        choice.addClass 'search-choice-disabled'
      else
        close_link = $('<a />',
          'class': 'search-choice-close'
          'data-option-array-index': item.array_index)
        close_link.bind 'click.chosen', ((_this) ->
          (evt) ->
            _this.choice_destroy_link_click evt
        )(this)
        choice.append close_link
      @search_container.before choice

    Chosen::choice_destroy_link_click = (evt) ->
      evt.preventDefault()
      evt.stopPropagation()
      if !@is_disabled
        return @choice_destroy($(evt.target))
      return

    Chosen::choice_destroy = (link) ->
      if @result_deselect(link[0].getAttribute('data-option-array-index'))
        @show_search_field_default()
        if @is_multiple and @choices_count() > 0 and @search_field.val().length < 1
          @results_hide()
        link.parents('li').first().remove()
        return @search_field_scale()
      return

    Chosen::results_reset = ->
      @reset_single_select_options()
      @form_field.options[0].selected = true
      @single_set_selected_text()
      @show_search_field_default()
      @results_reset_cleanup()
      @form_field_jq.trigger 'change'
      if @active_field
        return @results_hide()
      return

    Chosen::results_reset_cleanup = ->
      @current_selectedIndex = @form_field.selectedIndex
      @selected_item.find('abbr').remove()

    Chosen::result_select = (evt) ->
      high = undefined
      item = undefined
      if @result_highlight
        high = @result_highlight
        @result_clear_highlight()
        if @is_multiple and @max_selected_options <= @choices_count()
          @form_field_jq.trigger 'chosen:maxselected', chosen: this
          return false
        if @is_multiple
          high.removeClass 'active-result'
        else
          @reset_single_select_options()
        high.addClass 'result-selected'
        item = @results_data[high[0].getAttribute('data-option-array-index')]
        item.selected = true
        @form_field.options[item.options_index].selected = true
        @selected_option_count = null
        if @is_multiple
          @choice_build item
        else
          @single_set_selected_text @choice_label(item)
        if !((evt.metaKey or evt.ctrlKey) and @is_multiple)
          @results_hide()
        @show_search_field_default()
        if @is_multiple or @form_field.selectedIndex != @current_selectedIndex
          @form_field_jq.trigger 'change', 'selected': @form_field.options[item.options_index].value
        @current_selectedIndex = @form_field.selectedIndex
        evt.preventDefault()
        return @search_field_scale()
      return

    Chosen::single_set_selected_text = (text) ->
      if text == null
        text = @default_text
      if text == @default_text
        @selected_item.addClass 'chosen-default'
      else
        @single_deselect_control_build()
        @selected_item.removeClass 'chosen-default'
      @selected_item.find('span').html text

    Chosen::result_deselect = (pos) ->
      result_data = undefined
      result_data = @results_data[pos]
      if !@form_field.options[result_data.options_index].disabled
        result_data.selected = false
        @form_field.options[result_data.options_index].selected = false
        @selected_option_count = null
        @result_clear_highlight()
        if @results_showing
          @winnow_results()
        @form_field_jq.trigger 'change', deselected: @form_field.options[result_data.options_index].value
        @search_field_scale()
        true
      else
        false

    Chosen::single_deselect_control_build = ->
      if !@allow_single_deselect
        return
      if !@selected_item.find('abbr').length
        @selected_item.find('span').first().after '<abbr class="search-choice-close"></abbr>'
      @selected_item.addClass 'chosen-single-with-deselect'

    Chosen::get_search_text = ->
      $('<div/>').text($.trim(@search_field.val())).html()

    Chosen::winnow_results_set_highlight = ->
      do_high = undefined
      selected_results = undefined
      selected_results = if !@is_multiple then @search_results.find('.result-selected.active-result') else []
      do_high = if selected_results.length then selected_results.first() else @search_results.find('.active-result').first()
      if do_high != null
        return @result_do_highlight(do_high)
      return

    Chosen::no_results = (terms) ->
      no_results_html = undefined
      no_results_html = $('<li class="no-results">' + @results_none_found + ' "<span></span>"</li>')
      no_results_html.find('span').first().html terms
      @search_results.append no_results_html
      @form_field_jq.trigger 'chosen:no_results', chosen: this

    Chosen::no_results_clear = ->
      @search_results.find('.no-results').remove()

    Chosen::keydown_arrow = ->
      next_sib = undefined
      if @results_showing and @result_highlight
        next_sib = @result_highlight.nextAll('li.active-result').first()
        if next_sib
          return @result_do_highlight(next_sib)
      else
        return @results_show()
      return

    Chosen::keyup_arrow = ->
      prev_sibs = undefined
      if !@results_showing and !@is_multiple
        return @results_show()
      else if @result_highlight
        prev_sibs = @result_highlight.prevAll('li.active-result')
        if prev_sibs.length
          return @result_do_highlight(prev_sibs.first())
        else
          if @choices_count() > 0
            @results_hide()
          return @result_clear_highlight()
      return

    Chosen::keydown_backstroke = ->
      next_available_destroy = undefined
      if @pending_backstroke
        @choice_destroy @pending_backstroke.find('a').first()
        return @clear_backstroke()
      else
        next_available_destroy = @search_container.siblings('li.search-choice').last()
        if next_available_destroy.length and !next_available_destroy.hasClass('search-choice-disabled')
          @pending_backstroke = next_available_destroy
          if @single_backstroke_delete
            return @keydown_backstroke()
          else
            return @pending_backstroke.addClass('search-choice-focus')
      return

    Chosen::clear_backstroke = ->
      if @pending_backstroke
        @pending_backstroke.removeClass 'search-choice-focus'
      @pending_backstroke = null

    Chosen::keydown_checker = (evt) ->
      ref = undefined
      stroke = undefined
      stroke = if (ref = evt.which) != null then ref else evt.keyCode
      @search_field_scale()
      if stroke != 8 and @pending_backstroke
        @clear_backstroke()
      switch stroke
        when 8
          @backstroke_length = @search_field.val().length
        when 9
          if @results_showing and !@is_multiple
            @result_select evt
          @mouse_on_container = false
        when 13
          evt.preventDefault()
          if @results_showing
            if !@is_multiple or @result_highlight
              return @result_select(evt)
            $(@form_field).append '<option>' + $(evt.target).val() + '</option>'
            $(@form_field).trigger 'chosen:updated'
            @result_highlight = @search_results.find('li.active-result').last()
            return @result_select(evt)
        when 32
          if @disable_search
            evt.preventDefault()
        when 38
          evt.preventDefault()
          @keyup_arrow()
        when 40
          evt.preventDefault()
          @keydown_arrow()
      return

    Chosen::search_field_scale = ->
      div = undefined
      f_width = undefined
      h = undefined
      i = undefined
      len = undefined
      style = undefined
      style_block = undefined
      styles = undefined
      w = undefined
      if @is_multiple
        h = 0
        w = 0
        style_block = 'position:absolute; left: -1000px; top: -1000px; display:none;'
        styles = [
          'font-size'
          'font-style'
          'font-weight'
          'font-family'
          'line-height'
          'text-transform'
          'letter-spacing'
        ]
        i = 0
        len = styles.length
        while i < len
          style = styles[i]
          style_block += style + ':' + @search_field.css(style) + ';'
          i++
        div = $('<div />', 'style': style_block)
        div.text @search_field.val()
        $('body').append div
        w = div.width() + 25
        div.remove()
        f_width = @container.outerWidth()
        if w > f_width - 10
          w = f_width - 10
        return @search_field.css('width': w + 'px')
      return

    Chosen
  )(AbstractChosen)
  return
).call this
