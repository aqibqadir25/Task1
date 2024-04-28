const express = require('express');
const app = express();
const jwt = require('jsonwebtoken');


const users = [
  { id: 1, email: 'user@example.com', password: 'password1' },
  { id: 2, email: 'anotheruser@example.com', password: 'password2' }
];

app.use(express.json());

app.get('/', (req, res) => {
  res.send('Hello! Server is running');
});


app.post('/login', (req, res) => {
  const { email, password } = req.body;
  
  const user = users.find(user => user.email === email);

  if (user && user.password === password) {
//token
    const token = jwt.sign({ id: user.id, email: user.email }, 'MyAppSecretKey', { expiresIn: '2h' });
    res.json({ token });
  } else {
    res.status(401).json({ error: 'Invalid email or password' });
  }
});

app.get('/verifyToken', (req, res) => {
  const token = req.headers.authorization && req.headers.authorization.split(' ')[1];

  if (!token) {
    return res.status(401).json({ error: 'Token not provided' });
  }

  const SK = 'MyAppSecretKey';

  jwt.verify(token, SK, (err, decoded) => {
    if (err) {
      res.status(401).json({ error: 'Invalid token' });
    } else {
      res.json(decoded);
    }
  });
});

app.listen(8080, () => {
  console.log('Server running at port 8080');
});
