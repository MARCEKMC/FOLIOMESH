export function SimpleLandingPage() {
  return (
    <div style={{ padding: '2rem', fontFamily: 'Arial, sans-serif' }}>
      <h1 style={{ color: '#2563eb', fontSize: '3rem', marginBottom: '1rem' }}>
        FolioMesh
      </h1>
      <p style={{ fontSize: '1.2rem', color: '#6b7280', marginBottom: '2rem' }}>
        Professional Portfolio Platform
      </p>
      <div style={{ marginBottom: '2rem' }}>
        <h2 style={{ color: '#1f2937', fontSize: '2rem', marginBottom: '1rem' }}>
          Build Your Professional Portfolio
        </h2>
        <p style={{ fontSize: '1rem', lineHeight: '1.6', color: '#4b5563' }}>
          Create stunning portfolios, connect with professionals, and discover amazing job opportunities. 
          Join thousands of professionals showcasing their work on FolioMesh.
        </p>
      </div>
      <div style={{ display: 'flex', gap: '1rem', flexWrap: 'wrap' }}>
        <button style={{
          backgroundColor: '#2563eb',
          color: 'white',
          padding: '0.75rem 1.5rem',
          border: 'none',
          borderRadius: '0.5rem',
          fontSize: '1rem',
          cursor: 'pointer'
        }}>
          Get Started Free
        </button>
        <button style={{
          backgroundColor: 'transparent',
          color: '#2563eb',
          padding: '0.75rem 1.5rem',
          border: '2px solid #2563eb',
          borderRadius: '0.5rem',
          fontSize: '1rem',
          cursor: 'pointer'
        }}>
          View Examples
        </button>
      </div>
      <div style={{ marginTop: '3rem' }}>
        <h3 style={{ color: '#1f2937', fontSize: '1.5rem', marginBottom: '1rem' }}>
          Key Features:
        </h3>
        <ul style={{ listStyle: 'none', padding: 0 }}>
          <li style={{ marginBottom: '0.5rem', color: '#4b5563' }}>
            ✓ Customizable Portfolio Templates
          </li>
          <li style={{ marginBottom: '0.5rem', color: '#4b5563' }}>
            ✓ Custom Subdomains (yourname.foliomesh.com)
          </li>
          <li style={{ marginBottom: '0.5rem', color: '#4b5563' }}>
            ✓ Professional Networking
          </li>
          <li style={{ marginBottom: '0.5rem', color: '#4b5563' }}>
            ✓ Job Opportunities
          </li>
          <li style={{ marginBottom: '0.5rem', color: '#4b5563' }}>
            ✓ Analytics and Insights
          </li>
        </ul>
      </div>
    </div>
  );
}