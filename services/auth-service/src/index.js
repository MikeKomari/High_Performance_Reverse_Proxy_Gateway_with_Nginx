import express from "express";
import cors from "cors";
import authRoutes from "./routes/auth.js";

const app = express();
const PORT = process.env.PORT || 3000;
const VERSION = process.env.SERVICE_VERSION || "blue";

app.use(cors());
app.use(express.json());

app.get("/health", (req, res) => {
	res.json({ status: "ok", service: "auth", version: VERSION });
});

app.get("/", (req, res) => {
	res.send("Hi from: " + PORT);
});

app.use("/api/v1", authRoutes);

app.listen(PORT, "0.0.0.0", () => {
	console.log("Auth service running");
});
