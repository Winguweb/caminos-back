module Admin
  module NeighborhoodsHelper
    include UsersHelper

    def header_links(neighborhood)
      [
        {
          title: t('admin.links.neighborhoods.show.information'),
          href: admin_neighborhood_path(neighborhood),
          _show: true
        },{
          title: t('admin.links.neighborhoods.show.works'),
          href: admin_neighborhood_works_path(neighborhood),
          _show: neighborhood.urbanization
        },{
          title: t('admin.links.neighborhoods.show.meetings'),
          href: admin_neighborhood_meetings_path(neighborhood),
          _show: true
        },{
          title: t('admin.links.neighborhoods.show.agreement'),
          href: admin_neighborhood_agreement_path(neighborhood),
          _show: true
        },{
          title: t('admin.links.neighborhoods.show.activity'),
          href: '#',
          _show: neighborhood.urbanization
        }
      ].select do |_hash| _hash[:_show] end
    end
  end
end
