require_relative("../db/sql_runner")
require_relative("./films")

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds']
  end

  def save()
    sql = "INSERT INTO customers
    (
      name,
      funds
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run( sql, values ).first
    @id = customer['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM customers"
    values = []
    customers = SqlRunner.run(sql, values)
    result = customers.map { |customer| Customer.new( customer ) }
    return result
  end

  def update()
   sql = "UPDATE customers SET name = $1, funds = $2 WHERE id = $3"
   values = [@name, @funds, @id]
   SqlRunner.run( sql, values )
 end

  def self.delete_all()
    sql = "DELETE FROM customers"
    values = []
    SqlRunner.run(sql, values)
  end

  def delete()
   sql = "DELETE FROM customers WHERE id = $1"
   values = [@id]
   SqlRunner.run(sql, values)
 end

 def films()
   sql = "SELECT films.* FROM films
   INNER JOIN tickets ON tickets.film_id = films.id
   WHERE customer_id = $1"
   values = [@id]
   films = SqlRunner.run(sql, values)
   return Film.map_items(films)
 end

 def buy_ticket(film)
   sql = "SELECT films.* FROM films WHERE id = $1"
   values = [film.id]
   purchase = SqlRunner.run(sql, values)[0]
   self.funds -= purchase['price'].to_i()
   self.update
   ticket = Ticket.new({
     'customer_id' => self.id,
     'film_id' => film.id
   } )
   ticket.save()
 end

 def number_of_tickets()
   sql = "SELECT tickets.* FROM tickets WHERE customer_id = $1"
   values = [@id]
   SqlRunner.run(sql, values).ntuples
 end

 def self.map_items(customer_data)
    return customer_data.map { |customer| Customer.new(customer) }
 end

end
