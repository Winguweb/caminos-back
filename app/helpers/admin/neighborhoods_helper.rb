module Admin
  module NeighborhoodsHelper
    include DocumentsHelper

    def header_links(neighborhood)
      [
        {
          title: t('admin.links.neighborhoods.show.information'),
          href: admin_neighborhood_path(neighborhood),
          _show: true
        },{
          title: 'Reportes',
          href: admin_neighborhood_claims_path(neighborhood),
          _show: true
        },{
          title: t('admin.links.neighborhoods.show.assets'),
          href: admin_neighborhood_assets_path(neighborhood),
          _show: true
        },
      ].select do |_hash| _hash[:_show] end
    end
  end
end
