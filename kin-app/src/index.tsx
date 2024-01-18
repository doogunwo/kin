// src/index.tsx
import React from 'react';
import ReactDOM from 'react-dom';
import App from './App';

ReactDOM.render(
  <React.StrictMode>
    <App message="Hello TypeScript React!" />
  </React.StrictMode>,
  document.getElementById('root')
);
