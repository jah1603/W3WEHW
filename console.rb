require_relative( 'models/customers' )
require_relative( 'models/films' )
require_relative( 'models/tickets' )

require( 'pry-byebug' )

Ticket.delete_all()
Film.delete_all()
Customer.delete_all()

customer1 = Customer.new({ 'name' => 'Donald Trump', 'funds' => 500 })
customer1.save()

customer2 = Customer.new({ 'name' => 'George W Bush', 'funds' => 150 })
customer2.save()

film1 = Film.new({ 'title' => 'Texas Chainsaw Massacre', 'price' => 3 })
film1.save()

film2 = Film.new({ 'title' => 'Dial M for Murder', 'price' => 6 })
film2.save()

film3 = Film.new({ 'title' => 'The Jungle Book', 'price' => 4 })
film3.save()

ticket1 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film1.id })
ticket1.save()

ticket2 = Ticket.new({ 'customer_id' => customer2.id, 'film_id' => film1.id })
ticket2.save()

ticket3 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film2.id })
ticket3.save()

ticket4 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film3.id })
ticket4.save()

binding.pry
nil
