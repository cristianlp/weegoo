# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

lodging       = Category.create!(:name => "Alojamiento")
architecture  = Category.create!(:name => "Arquitectura y construcciones")
art           = Category.create!(:name => "Arte y cultura")
shopping      = Category.create!(:name => "Compras")
sports        = Category.create!(:name => "Deportes")
education     = Category.create!(:name => "Educación")
entertainment = Category.create!(:name => "Entretenimiento")
food          = Category.create!(:name => "Gastronomía")
nature        = Category.create!(:name => "Naturaleza")
services      = Category.create!(:name => "Servicios")
transport     = Category.create!(:name => "Transporte")
nightlife     = Category.create!(:name => "Vida nocturna")

["Apart hotel", "Bungalows", "Cabañas", "Camping", "Hostel", "Hostería", "Hotel", "Motel", "Resort"].each do |name|
  lodging.sub_categories.create!(:name => name)
end

["Castillo", "Catedral", "Faro", "Fuente", "Iglesia", "Monumento histórico", "Plaza", "Puente", "Torre"].each do |name|
  architecture.sub_categories.create!(:name => name)
end

["Acuario", "Biblioteca", "Galería de arte", "Museo", "Parque temático", "Planetario", "Zoologico"].each do |name|
  art.sub_categories.create!(:name => name)
end

["Antigüedades", "Belleza y cosméticos", "Comida y bebida", "Deportes", "Farmacia", "Feria", "Ferretería", "Florería", "Hobbies", "Joyería", "Librería", "Mascotas", "Mueblería", "Música", "Regalos", "Ropa", "Peluquería", "Shopping", "SPA y masajes", "Tatuajes", "Tecnología", "Zapatos"].each do |name|
  shopping.sub_categories.create!(:name => name)
end

["Biblioteca", "Escuela", "Facultad", "Laboratorio", "Universidad"].each do |name|
  education.sub_categories.create!(:name => name)
end

["Bingo", "Carreras", "Casino", "Cine", "Concierto", "Música", "Piscina", "Recital", "Teatro", "Videojuegos"].each do |name|
  entertainment.sub_categories.create!(:name => name)
end

["Cafetería", "Cervecería", "Comidas rápidas", "Heladería", "Pizzería", "Postres", "Restaurant", "Restaurant de comida exótica", "Restaurant gourmet", "Vinería"].each do |name|
  food.sub_categories.create!(:name => name)
end

["Arroyo", "Cascada", "Cerro", "Campo", "Granja", "Jardín", "Lago", "Mirador", "Montaña", "Parque", "Parque nacional", "Playa", "Quebrada", "Reserva natural", "Río", "Ski - Snowboard", "Viñedo"].each do |name|
  nature.sub_categories.create!(:name => name)
end

["Banco", "Cajero automático", "Estación de bomberos", "Estación de policía", "Estación de servicio", "Hospital", "Rent-a-car"].each do |name|
  services.sub_categories.create!(:name => name)
end

["Aeropuerto", "Estación de trenes", "Ferry", "Puerto", "Subterráneo", "Taxi", "Terminal de ómnibus"].each do |name|
  transport.sub_categories.create!(:name => name)
end

["Bar", "Cervecería", "Discoteca", "Karaoke", "Pub", "Strip Club"].each do |name|
  nightlife.sub_categories.create!(:name => name)
end

User.create!(:first_name => "Patricio", :last_name => "Mac Adden", :email => "patriciomacadden@gmail.com", :username => "patricio", :password => "patricio", :location => "La Plata")
User.create!(:first_name => "Bárbara", :last_name => "Nounou", :email => "barbaranounou@gmail.com", :username => "barbara", :password => "barbara", :location => "La Plata")
User.create!(:first_name => "Nicolás", :last_name => "Espina", :email => "nicolasespina@gmail.com", :username => "nicolas", :password => "nicolas", :location => "Ringuelet")
User.create!(:first_name => "Álvaro", :last_name => "Lara", :email => "alvarola@gmail.com", :username => "guiman", :password => "guiman", :location => "La Plata")
User.create!(:first_name => "Marcelo", :last_name => "Mac Adden", :email => "macadden@gmail.com", :username => "marcelo", :password => "marcelo", :location => "La Plata")
User.create!(:first_name => "María Inés", :last_name => "Lascano", :email => "m.ineslascano@gmail.com", :username => "mariaines", :password => "mariaines", :location => "La Plata")
User.create!(:first_name => "Juan Esteban", :last_name => "Mac Adden", :email => "juanestebanmacadden@gmail.com", :username => "juanesteban", :password => "juanesteban", :location => "La Plata")
User.create!(:first_name => "Julia", :last_name => "Mac Adden", :email => "juliamacadden@gmail.com", :username => "juliam", :password => "juliam", :location => "La Plata")
User.create!(:first_name => "Gonzalo", :last_name => "Ramírez Abella", :email => "gonzaloramirezabella@gmail.com", :username => "pirata", :password => "pirata", :location => "Gonnet")
User.create!(:first_name => "Matías", :last_name => "Torres", :email => "torresmat@gmail.com", :username => "chucky", :password => "chucky", :location => "Gonnet")
User.create!(:first_name => "Matías", :last_name => "Brown", :email => "matiasbrown@gmail.com", :username => "marron", :password => "marron", :location => "Lincoln")