Deface::Override.new(virtual_path: 'spree/admin/shared/_menu',
                     name: 'add_spree_microcms_to_admin_menu',
                     insert_bottom: "[data-hook='admin_tabs']",
                     partial: 'test/test')
