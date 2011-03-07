# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

lodging = Category.create!(:name => "Alojamiento")
architecture = Category.create!(:name => "Arquitectura y construcciones")
art = Category.create!(:name => "Arte y cultura")
shopping = Category.create!(:name => "Compras")
education = Category.create!(:name => "Educación")
entertainment = Category.create!(:name => "Entretenimiento")
food = Category.create!(:name => "Gastronomía")
nature = Category.create!(:name => "Naturaleza")
services = Category.create!(:name => "Servicios")
transport = Category.create!(:name => "Transporte")
nightlife = Category.create!(:name => "Vida nocturna")

["Hostel", "Hotel", "Motel", "Resort"].each do |name|
  lodging.sub_categories.create!(:name => name)
end

["Castillo", "Centro de convenciones", "Faro", "Fuente", "Monumento histórico", "Plaza", "Puente", "Torre"].each do |name|
  architecture.sub_categories.create!(:name => name)
end

["Biblioteca", "Escultura", "Galería de arte", "Monumento", "Museo", "Planetario"].each do |name|
  art.sub_categories.create!(:name => name)
end

["Antigüedades", "Belleza y cosméticos", "Bombonería", "Centro comercial", "Comida y bebida", "Deportes", "Estación de servicio", "Farmacia", "Feria", "Ferretería", "Florería", "Hobbies", "Joyería", "Lavandería", "Librería", "Mascotas", "Mueblería", "Música e instrumentos", "Regalería", "Ropa", "Peluquería", "SPA y masajes", "Tatuajes", "Tecnología"].each do |name|
  shopping.sub_categories.create!(:name => name)
end

["Auditorio", "Aula", "Biblioteca", "Cafetería", "Colegio secundario", "Edificio académico", "Edificio administrativo", "Laboratorio", "Universidad"].each do |name|
  education.sub_categories.create!(:name => name)
end

["Acuario", "Carrera", "Casino", "Cine", "Estadio", "Música en vivo", "Parque temático", "Piscina", "Teatro", "Videojuegos", "Zoologico"].each do |name|
  entertainment.sub_categories.create!(:name => name)
end

["Cafetería", "Cena", "Cervecería", "Desayuno", "Exótica", "Hamburguesas", "Heladería", "Panadería", "Pizzería", "Postres", "Sushi", "Vegetariana", "Vinería"].each do |name|
  food.sub_categories.create!(:name => name)
end

["Arroyo", "Campo", "Cueva", "Escultura", "Faro", "Granja", "Jardín", "Lago", "Mirador", "Monumento histórico", "Parque", "Parque nacional", "Playa", "Reserva natural", "Río", "Ski - Snowboard", "Viñedo"].each do |name|
  nature.sub_categories.create!(:name => name)
end

["Banco", "Estación de bomberos", "Estación de policía", "Estación de servicio", "Hospital", "Rent-a-car"].each do |name|
  services.sub_categories.create!(:name => name)
end

["Aeropuerto", "Estación de tren", "Terminal de ómnibus", "Ferry", "Subterráneo", "Taxi"].each do |name|
  transport.sub_categories.create!(:name => name)
end

["Bar", "Cervecería", "Discoteca", "Karaoke", "Pub", "Strip Club"].each do |name|
  nightlife.sub_categories.create!(:name => name)
end

User.create!(:first_name => "Patricio", :last_name => "Mac Adden", :email => "patriciomacadden@gmail.com", :username => "patriciomacadden", :password => "patriciomacadden", :location => "La Plata")
User.create!(:first_name => "Bárbara", :last_name => "Nounou", :email => "barbaranounou@gmail.com", :username => "barbaranounou", :password => "barbaranounou", :location => "La Plata")
User.create!(:first_name => "Nicolás", :last_name => "Espina", :email => "nicolasespina@gmail.com", :username => "nicolasespina", :password => "nicolasespina", :location => "Ringuelet")
User.create!(:first_name => "Álvaro", :last_name => "Lara", :email => "alvarola@gmail.com", :username => "alvarola", :password => "alvarola", :location => "La Plata")
User.create!(:first_name => "Marcelo", :last_name => "Mac Adden", :email => "macadden@gmail.com", :username => "marcelomacadden", :password => "marcelomacadden", :location => "La Plata")
User.create!(:first_name => "María Inés", :last_name => "Lascano", :email => "m.ineslascano@gmail.com", :username => "m.ineslascano", :password => "m.ineslascano", :location => "La Plata")
User.create!(:first_name => "Juan Esteban", :last_name => "Mac Adden", :email => "juanestebanmacadden@gmail.com", :username => "juanestebanmacadden", :password => "juanestebanmacadden", :location => "La Plata")
User.create!(:first_name => "Julia", :last_name => "Mac Adden", :email => "juliamacadden@gmail.com", :username => "juliamacadden", :password => "juliamacadden", :location => "La Plata")
User.create!(:first_name => "Gonzalo", :last_name => "Ramírez Abella", :email => "gonzaloramirezabella@gmail.com", :username => "gonzaloramirezabella", :password => "gonzaloramirezabella", :location => "Gonnet")
User.create!(:first_name => "Matías", :last_name => "Torres", :email => "torresmat@gmail.com", :username => "torresmat", :password => "torresmat", :location => "Gonnet")
User.create!(:first_name => "Matías", :last_name => "Brown", :email => "matiasbrown@gmail.com", :username => "matiasbrown", :password => "matiasbrown", :location => "Lincoln")