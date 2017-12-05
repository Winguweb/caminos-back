# Users
USERS = [
  { username: 'cavi', email: 'agustin@winguweb.org', password: 'nadanada', first_name: 'Agustin', active: true, approved: true, confirmed: true, roles: [:admin] },
  { username: 'facu', email: 'facundo@winguweb.org', password: 'nadanada', first_name: 'Facundo', active: true, approved: true, confirmed: true, roles: [:ambassador] },
  { username: 'carlos', email: 'carlos@winguweb.org', password: 'nadanada', first_name: 'Carlos', active: true, approved: true, confirmed: true, roles: [:admin, :ambassador] },
]
User.where(username: USERS.map{ |data| data[:username] }).destroy_all
USERS.each do |data|
  data.merge!(profile: Profile.new(first_name: data.delete(:first_name)))
  user = User.new(data)
  user.save!
end
