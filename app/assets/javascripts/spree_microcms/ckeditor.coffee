#= require ckeditor/init
#= require_self

$ ->
  CKEDITOR.disableAutoInline = true;

  $('[contenteditable="true"]').each ->
    CKEDITOR.inline(
      this
      on:
        blur: (e) ->
          return unless e.editor.checkDirty()

          new_content = e.editor.getData()
          $element = $(e.editor.element.$)
          url = $element.data('update-url')
          field_config = $element.data('field-config')
          field_name_prefix = field_config.field_name_prefix

          data = {
            '_method': 'put'
          }

          for field  in field_config.fields
            form_field_name = "#{field_name_prefix}[#{field.name}]"
            value = field.value
            value = new_content if field.name == 'content'
            data["#{form_field_name}"] = value

          $.ajax
            url: url
            data: data
            method: 'POST'
            success: (data, status, xhr) ->
              $element.removeClass("has-error")
              $element.addClass("update-success")
              setTimeout ->
                $element.removeClass("update-success")
                2000
            error: (xhr, status, error) ->
              $element.removeClass("update-success")
              $element.addClass("has-error")
    )
