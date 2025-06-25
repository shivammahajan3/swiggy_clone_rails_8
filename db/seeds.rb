# Clear existing data
OrderProduct.destroy_all
Order.destroy_all
Product.destroy_all
Restro.destroy_all
User.destroy_all


# Sample data
indian_dishes = [
  "Paneer Butter Masala", "Paneer Tikka", "Dal Makhani", "Chole Bhature", "Matar Paneer",
  "Bhindi Masala", "Dry Avial", "Kadai Paneer", "Malai Kofta", "Aloo Paratha",
  "Lacha Paratha", "Garlic Paratha", "Biryani", "Palak Paneer", "Tandoori Roti",
  "Butter Naan", "Gulab Jamun", "Rasgulla", "Masala Dosa", "Chole Kulche", "Makkai Roti"
]

pizza_dishes = [
  "Margherita Pizza", "Farmhouse Pizza", "Peppy Paneer Pizza", "Mexican Green Wave",
  "Deluxe Veggie", "Cheese Burst", "Veg Extravaganza", "Double Cheese Margherita",
  "Paneer Makhani Pizza", "Corn & Cheese"
]

# Helper methods
def random_phone
  "9#{rand(100000000..999999999)}"
end

def random_address
  "Street #{rand(1..100)}, City #{rand(1..10)}"
end

def random_email(name)
  name.downcase.gsub(" ", "") + "@example.com"
end

# === Admin Users ===

dhanraj = User.create!(
  name: "Dhanraj",
  email: "dhanarj@gmail.com",
  phone_number: random_phone,
  address: random_address,
  role: 1,
  password: "password"
)

guddu = User.create!(
  name: "Guddu Rangila",
  email: "guddu@gmail.com",
  phone_number: random_phone,
  address: random_address,
  role: 1,
  password: "password"
)

falguni = User.create!(
  name: "Falguni Pathak",
  email: "falguni@gmail.com",
  phone_number: random_phone,
  address: random_address,
  role: 1,
  password: "password"
)

# === Regular Users ===
customers = ["Cheems", "Gukesh", "Kamal Hasan"].map do |name|
  User.create!(
    name: name,
    email: random_email(name),
    phone_number: random_phone,
    address: random_address,
    role: 0,
    password: "password"
  )
end

# === Delivery Partners ===
["Salaar", "Rocky"].each do |name|
  User.create!(
    name: name,
    email: "#{name.downcase}@delivery.com",
    phone_number: random_phone,
    address: random_address,
    role: 2,
    password: "password"
  )
end

# === Helper for creating restros, products, and orders ===
def create_restros_and_orders(owner, restro_names, dishes, customers)
  restro_names.each do |restro_name|
    restro = Restro.create!(
      name: restro_name,
      address: random_address,
      phone_number: random_phone,
      user_id: owner.id
    )

    products = dishes.sample(10).map do |dish|
      Product.create!(
        name: dish,
        price: rand(100..300),
        description: "#{dish} with authentic Indian taste",
        restro_id: restro.id
      )
    end

    # Create 2–3 orders per restro
    rand(2..3).times do
      customer = customers.sample
      order = Order.create!(
        user_id: customer.id,
        restro_id: restro.id,
        status: 0,
        order_time: Time.now,
        total_price: 0
      )

      total = 0
      products.sample(rand(2..4)).each do |product|
        quantity = rand(1..3)
        total += product.price * quantity

        OrderProduct.create!(
          order_id: order.id,
          product_id: product.id,
          quantity: quantity
        )
      end

      order.update(total_price: total)
    end
  end
end

# === Create Restros for each Admin ===

# Dhanraj: 5 restros
create_restros_and_orders(
  dhanraj,
  ["Shreemaya", "Vrindavan", "Radison", "Sayaji", "Annapurna"],
  indian_dishes,
  customers
)

# Guddu: 5 restros
create_restros_and_orders(
  guddu,
  ["Maratha Dhabah", "Indori Choree", "Indian Masala", "The Guru", "Masaledar Magic"],
  indian_dishes,
  customers
)

# Falguni: 3 Pizza Restros
create_restros_and_orders(
  falguni,
  ["Lapinoz", "Domizoz", "Pizza Hut"],
  pizza_dishes,
  customers
)

puts "✅ Seed completed!"
