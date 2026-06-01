import { useState, useEffect } from 'react';

const API_URL = 'http://98.86.163.207:8080';

function App() {
  const [status, setStatus] = useState(null);
  const [tasks, setTasks] = useState([]);
  const [error, setError] = useState(null);

  useEffect(() => {
    fetch(`${API_URL}/api/status`)
      .then(res => res.json())
      .then(data => setStatus(data))
      .catch(() => setError('Cannot connect to API'));

    fetch(`${API_URL}/api/tasks`)
      .then(res => res.json())
      .then(data => setTasks(data))
      .catch(() => setError('Cannot load tasks'));
  }, []);

  return (
    <div style={{ fontFamily: 'Arial', maxWidth: '800px', margin: '40px auto', padding: '20px' }}>
      <h1 style={{ color: '#2196F3' }}>Polyglot Cloud App v1.0</h1>

      {error && <p style={{ color: 'red' }}>{error}</p>}

      {status && (
        <div style={{ background: '#e3f2fd', padding: '15px', borderRadius: '8px', marginBottom: '20px' }}>
          <h2>API Status</h2>
          <p>Status: <strong>{status.status}</strong></p>
          <p>Message: <strong>{status.message}</strong></p>
          <p>Version: <strong>{status.version}</strong></p>
        </div>
      )}

      <div style={{ background: '#f5f5f5', padding: '15px', borderRadius: '8px' }}>
        <h2>Tasks</h2>
        {tasks.map(task => (
          <div key={task.id} style={{ padding: '10px', margin: '5px 0', background: task.done ? '#c8e6c9' : '#fff', borderRadius: '4px', border: '1px solid #ddd' }}>
            <strong>{task.title}</strong> — {task.done ? '✅ Done' : '⏳ Pending'}
          </div>
        ))}
      </div>
    </div>
  );
}

export default App;