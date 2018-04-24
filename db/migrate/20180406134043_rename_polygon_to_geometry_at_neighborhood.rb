class RenamePolygonToGeometryAtNeighborhood < ActiveRecord::Migration[5.1]
  def change
    change_table :neighborhoods do |t|
      t.rename :polygon, :geometry
      t.rename :geo_polygon, :geo_geometry
    end
  end
end
