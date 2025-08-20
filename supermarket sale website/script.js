let cart = [];
let totalAmount = 0;

function addToCart(product, price) {
  cart.push({ product, price });
  totalAmount += price;
  updateCart();
}

function updateCart() {
  const cartDiv = document.getElementById("cart");
  cartDiv.innerHTML = "";
  cart.forEach((item, index) => {
    cartDiv.innerHTML += `<p>${item.product} - ₹${item.price}</p>`;
  });
  cartDiv.innerHTML += `<p><strong>Total: ₹${totalAmount}</strong></p>`;
  if (totalAmount > 0) {
    document.getElementById("payBtn").style.display = "block";
  }
}

function payNow() {
  const options = {
    key: "YOUR_RAZORPAY_KEY",
    amount: totalAmount * 100,
    currency: "INR",
    name: "Supermarket Flash Sale",
    description: "Thanks for shopping with us!",
    image: "https://your-logo-url.com/logo.png",
    handler: function (response) {
      alert("Payment Successful! Razorpay Payment ID: " + response.razorpay_payment_id);
    },
    prefill: {
      name: "",
      email: "",
      contact: ""
    },
    theme: {
      color: "#3399cc"
    }
  };
  const rzp = new Razorpay(options);
  rzp.open();
}
