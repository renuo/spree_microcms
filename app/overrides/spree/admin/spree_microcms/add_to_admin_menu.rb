Deface::Override.new(virtual_path: 'spree/layouts/admin',
                     name: 'add_spree_microcms_to_admin_menu',
                     insert_bottom: '[data-hook="admin_tabs"]',
                     partial: 'spree_microcms/admin/main_menu_item')
