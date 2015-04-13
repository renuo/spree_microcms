module SpreeMicrocms
  module PagesHelper
    def content_rich_text_fields(record)
      {
        field_name_prefix: "#{record.class.model_name.singular}",
        fields: [
          {
            name: 'content', value: ''
          }
        ]
      }
    end
  end
end
