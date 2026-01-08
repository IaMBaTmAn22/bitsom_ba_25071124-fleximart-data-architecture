use fleximart;

db.products.insertMany([
    {
      product_id: "ELEC001",
      name: "Samsung Galaxy S21",
      category: "Electronics",
      price: 45999,
      stock: 150,
      reviews: [
        { user: "U001", rating: 5, comment: "Great phone!", date: "2024-01-15" }
      ]
    },
    {
      product_id: "FASH001",
      name: "Nike Running Shoes",
      category: "Fashion",
      price: 3499,
      stock: 80,
      reviews: [
        { user: "U002", rating: 4, comment: "Very comfortable", date: "2024-02-01" }
      ]
    },
    {
      product_id: "GROC001",
      name: "Organic Almonds",
      category: "Groceries",
      price: 899,
      stock: 200,
      reviews: [
        { user: "U003", rating: 5, comment: "Fresh quality", date: "2024-02-10" }
      ]
    }
  ]);



// Find all Electronics products with price < 50000
// Return only name, price, stock
db.products.find(
    { category: "Electronics", price: { $lt: 50000 } },
    { name: 1, price: 1, stock: 1, _id: 0 }
  );


// Find all products having rating >= 4
db.products.find({ "reviews.rating": { $gte: 4 } });




// Add a new review to ELEC001
db.products.updateOne(
    { product_id: "ELEC001" },
    {
      $push: {
        reviews: {
          user: "U999",
          rating: 4,
          comment: "Good value",
          date: "2024-03-01"
        }
      }
    }
  );

  
  
//Calculate average price by category
db.products.aggregate([
    {
      $group: {
        _id: "$category",
        avg_price: { $avg: "$price" },
        product_count: { $sum: 1 }
      }
    },
    { $sort: { avg_price: -1 } }
  ]);
  