module Ckeditor
  class Picture < Asset
    has_attached_file :data,
                      path: '/:class/:attachment/:id_partition/:style/:filename',
                      storage: :s3,
                      s3_protocol: 'https',
                      s3_headers: { 'Cache-Control' => 'max-age=31557600' },
                      s3_host_name: ENV['S3_HOST_NAME'],
                      s3_credentials: {
                        bucket: ENV['S3_BUCKET_NAME'],
                        access_key_id: ENV['AWS_ACCESS_KEY_ID'],
                        secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
                      },
                      styles: { content: '800>', thumb: '118x100#' }

    validates_attachment_presence :data
    validates_attachment_size :data, less_than: 2.megabytes
    validates_attachment_content_type :data, content_type: /\Aimage/

    def url_content
      url(:content)
    end
  end
end
