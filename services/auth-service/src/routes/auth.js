import express from "express";
import { PrismaClient } from "@prisma/client";
import { JWT_SECRET } from "../config.js";
import jwt from "jsonwebtoken";

const prisma = new PrismaClient();
const router = express.Router();

// router.get("/", async (req, res) => {
// 	const users = await prisma.user.findMany();
// 	res.status(200).json(users);
// });

router.post("/auth/login", async (req, res) => {
	const { usn, pass } = req.body;
	try {
		const admin = await prisma.user.findUnique({ where: { username: usn } });
		if (!admin || admin.password !== pass) {
			return res.status(401).json({ error: "Invalid credentials" });
		}

		const delay = process.env.SERVICE_VERSION === "blue" ? 50 : 150;

		const token = jwt.sign({ role: "admin", usn }, JWT_SECRET, {
			expiresIn: "1h",
		});

		setTimeout(() => {
			res.json({ token });
		}, delay);
	} catch (err) {
		if (err instanceof Error) {
			// res.status(400).send("Something Went Wrong!");
			res.status(400).json({ error: err.message });
		} else {
			res.status(400).json({ error: String(err) });
		}
	}
});

export default router;
