const express = require('express');
const jwt = require('jsonwebtoken');
const app = express();
const PORT = 3000;

require('dotenv').config();
app.use(express.json());


const users = [
  { username: 'user1', password: 'user1234' },
  { username: 'user2', password: 'user2468' }
];

app.post('/login', (req, res) => {
  const { username, password } = req.body;

  // Validate input
  if (!username || !password) {
    return res.status(400).json({ message: 'Username and password are required' });
  }

  // Validate credentials
  const user = users.find(u => u.username === username && u.password === password);

  if (!user) {
    return res.status(401).json({ message: 'Invalid username or password' });
  }


  const payload = { name: user.username };

  // Generate token
  const accessToken = jwt.sign(payload, process.env.ACCESS_TOKEN_SECRET, { expiresIn: '1h' });

  res.json({ accessToken });
});

app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
