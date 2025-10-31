'use client';

import { useSupabase } from '@/components/providers/SupabaseProvider';

export function MainApp() {
  const { user, loading } = useSupabase();

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-center">
          <div className="animate-spin rounded-full h-32 w-32 border-b-2 border-blue-600 mx-auto"></div>
          <p className="mt-4 text-gray-600 dark:text-gray-400">Loading your workspace...</p>
        </div>
      </div>
    );
  }

  if (!user) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-center">
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white">Welcome to FolioMesh</h1>
          <p className="mt-2 text-gray-600 dark:text-gray-400">Please sign in to access your dashboard</p>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gray-50 dark:bg-gray-900">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div className="mb-8">
          <h1 className="text-3xl font-bold text-gray-900 dark:text-white">
            Welcome back, {user.user_metadata?.first_name || user.email}!
          </h1>
          <p className="text-gray-600 dark:text-gray-400">
            Manage your portfolios and professional presence
          </p>
        </div>
        
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {/* Portfolio Card */}
          <div className="bg-white dark:bg-gray-800 rounded-lg shadow p-6">
            <h3 className="text-lg font-semibold text-gray-900 dark:text-white mb-2">
              Your Portfolio
            </h3>
            <p className="text-gray-600 dark:text-gray-400 mb-4">
              Create and manage your professional portfolio
            </p>
            <button className="w-full bg-blue-600 text-white py-2 px-4 rounded-md hover:bg-blue-700 transition-colors">
              Edit Portfolio
            </button>
          </div>
          
          {/* Connections Card */}
          <div className="bg-white dark:bg-gray-800 rounded-lg shadow p-6">
            <h3 className="text-lg font-semibold text-gray-900 dark:text-white mb-2">
              Connections
            </h3>
            <p className="text-gray-600 dark:text-gray-400 mb-4">
              View and manage your professional network
            </p>
            <button className="w-full bg-green-600 text-white py-2 px-4 rounded-md hover:bg-green-700 transition-colors">
              View Network
            </button>
          </div>
          
          {/* Jobs Card */}
          <div className="bg-white dark:bg-gray-800 rounded-lg shadow p-6">
            <h3 className="text-lg font-semibold text-gray-900 dark:text-white mb-2">
              Job Opportunities
            </h3>
            <p className="text-gray-600 dark:text-gray-400 mb-4">
              Discover jobs that match your skills
            </p>
            <button className="w-full bg-purple-600 text-white py-2 px-4 rounded-md hover:bg-purple-700 transition-colors">
              Browse Jobs
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}