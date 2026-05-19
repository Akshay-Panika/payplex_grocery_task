class DummyData {
  static List<Map<String, dynamic>> products = [
    {
      "name": "Fresh Apple",
      "price": "₹120",
      "qty": "1 KG",
      "emoji": "🍎",
      "badge": "SALE",
      "image": "https://images.unsplash.com/photo-1567306226416-28f0efdc88ce?w=400",
    },
    {
      "name": "Banana",
      "price": "₹80",
      "qty": "12 pcs",
      "emoji": "🍌",
      "badge": null,
      "image": "https://images.unsplash.com/photo-1603833665858-e61d17a86224?w=400",
    },
    {
      "name": "Tomato",
      "price": "₹40",
      "qty": "1 KG",
      "emoji": "🍅",
      "badge": "FRESH",
      "image": "https://images.unsplash.com/photo-1546094096-0df4bcaaa337?w=400",
    },
    {
      "name": "Milk",
      "price": "₹60",
      "qty": "1 Litre",
      "emoji": "🥛",
      "badge": null,
      "image": "https://images.unsplash.com/photo-1550583724-b2692b85b150?w=400",
    },
    {
      "name": "Broccoli",
      "price": "₹55",
      "qty": "500 gm",
      "emoji": "🥦",
      "badge": "50% OFF",
      "image": "https://images.unsplash.com/photo-1459411621453-7b03977f4bfc?w=400",
    },
    {
      "name": "Orange",
      "price": "₹90",
      "qty": "1 KG",
      "emoji": "🍊",
      "badge": null,
      "image": "https://images.unsplash.com/photo-1616684000067-36952fde56ec?w=400",
    },
  ];

  static List<Map<String, String>> offers = [
    {
      "title": "50% OFF",
      "subtitle": "On all Fresh Vegetables — Farm to doorstep.",
      "emoji": "🥦",
      "tag": "FLASH DEAL",
      "price": "From ₹49/kg",
      "original": "₹99/kg",
      "bg": "green",
      "image": "https://images.unsplash.com/photo-1542838132-92c53300491e?w=600",
    },
    {
      "title": "Buy 1 Get 1",
      "subtitle": "Double the freshness on all Fruits today.",
      "emoji": "🍊",
      "tag": "FRUITS WEEK",
      "price": "₹120/kg",
      "original": "₹240/kg",
      "bg": "amber",
      "image": "https://images.unsplash.com/photo-1619566636858-adf3ef46400b?w=600",
    },
    {
      "title": "Dairy Week",
      "subtitle": "20% off on Milk, Cheese and Eggs.",
      "emoji": "🥛",
      "tag": "DAIRY",
      "price": "From ₹52/L",
      "original": "₹65/L",
      "bg": "blue",
      "image": "https://images.unsplash.com/photo-1550583724-b2692b85b150?w=600",
    },
  ];

  static List<Map<String, String>> categories = [
    {"label": "All", "emoji": "🌿"},
    {"label": "Fruits", "emoji": "🍎"},
    {"label": "Veggies", "emoji": "🥦"},
    {"label": "Dairy", "emoji": "🥛"},
    {"label": "Grains", "emoji": "🌾"},
  ];

  static List<Map<String, String>> orderHistory = [
    {"id": "100", "items": "Apple, Banana, Milk", "price": "₹450", "status": "Delivered"},
    {"id": "101", "items": "Tomato, Broccoli", "price": "₹280", "status": "Delivered"},
    {"id": "102", "items": "Orange, Milk", "price": "₹310", "status": "Delivered"},
    {"id": "103", "items": "Apple, Banana", "price": "₹200", "status": "Cancelled"},
    {"id": "104", "items": "Grapes, Strawberry", "price": "₹520", "status": "Delivered"},
  ];
}