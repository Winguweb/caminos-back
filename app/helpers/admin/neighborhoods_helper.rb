module Admin
  module NeighborhoodsHelper
    def header_links(neighborhood)
      [
        {
          title: t('admin.links.neighborhoods.show.information'),
          href: admin_neighborhood_path(neighborhood)
        },{
          title: t('admin.links.neighborhoods.show.works'),
          href: admin_neighborhood_works_path(neighborhood)
        },{
          title: t('admin.links.neighborhoods.show.meetings'),
          href: admin_neighborhood_meetings_path(neighborhood)
        },{
          title: t('admin.links.neighborhoods.show.agreement'),
          href: admin_neighborhood_agreement_path(neighborhood)
        },{
          title: t('admin.links.neighborhoods.show.activity'),
          href: '#'
        }
      ]
    end

  end
end
