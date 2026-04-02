require("dotenv").config();
const express = require("express");
const cors = require("cors");

const app = express();

// ===== CORS =====
app.use(cors({
    origin: "https://car-parking-theta.vercel.app",
    methods: ["GET", "POST"],
    credentials: true
}));

app.use(express.json());

// ===== TEST ROUTE =====
app.get("/", (req, res) => {
    res.send("Backend is running ✅");
});

// ===== DUMMY ROUTES (TEMP FOR TESTING) =====

// Fake slots
app.get("/slots", (req, res) => {
    res.json([
        { slot_number: "BIKE-1", type: "bike", is_booked: false },
        { slot_number: "CAR-1", type: "car", is_booked: false }
    ]);
});

// Fake create order
app.post("/create-order", (req, res) => {
    res.json({
        order_id: "test_order_123",
        amount: 5000,
        currency: "INR",
        ticket_id: "TKT-TEST123",
        key_id: "rzp_test_dummy"
    });
});

// Fake verify payment
app.post("/verify-payment", (req, res) => {
    res.json({ success: true });
});

// ===== SERVER START =====
const PORT = process.env.PORT || 5000;

app.listen(PORT, () => {
    console.log(`🚀 Server running on port ${PORT}`);
});
