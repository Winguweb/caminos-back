module Admin
  module NeighborhoodsHelper

    def header_links
      [
        {
          title: t('admin.links.neighborhoods.show.information'),
          href: '#'
        },{
          title: t('admin.links.neighborhoods.show.works'),
          href: '#'
        },{
          title: t('admin.links.neighborhoods.show.meetings'),
          href: '#'
        },{
          title: t('admin.links.neighborhoods.show.agreement'),
          href: '#'
        },{
          title: t('admin.links.neighborhoods.show.activity'),
          href: '#'
        }
      ]
    end

  end
end
