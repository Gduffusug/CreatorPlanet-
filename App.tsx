import { Suspense, lazy } from 'react'
import { BrowserRouter, Routes, Route } from 'react-router-dom'
import { Toaster } from 'react-hot-toast'
import { AnimatePresence, motion } from 'framer-motion'
import { AuthProvider } from './context/AuthContext'
import Navbar from './components/layout/Navbar'
import ProtectedRoute from './components/ProtectedRoute'

const Home = lazy(() => import('./pages/Home'))
const Explore = lazy(() => import('./pages/Explore'))
const AssetDetail = lazy(() => import('./pages/AssetDetail'))
const Dashboard = lazy(() => import('./pages/Dashboard'))
const AdminDashboard = lazy(() => import('./pages/AdminDashboard'))

const PageLoader = () => (
  <div className="min-h-screen flex items-center justify-center">
    <div className="w-8 h-8 border-2 border-accent/30 border-t-accent rounded-full animate-spin" />
  </div>
)

const PageWrapper = ({ children }: { children: React.ReactNode }) => (
  <motion.div
    initial={{ opacity: 0, y: 10 }}
    animate={{ opacity: 1, y: 0 }}
    exit={{ opacity: 0, y: -10 }}
    transition={{ duration: 0.3 }}
  >
    {children}
  </motion.div>
)

export default function App() {
  return (
    <BrowserRouter>
      <AuthProvider>
        <div className="relative">
          <div className="noise-overlay" />
          <Navbar />
          <Suspense fallback={<PageLoader />}>
            <AnimatePresence mode="wait">
              <Routes>
                <Route path="/" element={<PageWrapper><Home /></PageWrapper>} />
                <Route path="/explore" element={<PageWrapper><Explore /></PageWrapper>} />
                <Route path="/asset/:id" element={<PageWrapper><AssetDetail /></PageWrapper>} />
                <Route path="/dashboard" element={
                  <ProtectedRoute>
                    <PageWrapper><Dashboard /></PageWrapper>
                  </ProtectedRoute>
                } />
                <Route path="/admin" element={
                  <ProtectedRoute adminOnly>
                    <PageWrapper><AdminDashboard /></PageWrapper>
                  </ProtectedRoute>
                } />
                <Route path="*" element={
                  <div className="min-h-screen pt-32 flex items-center justify-center text-center px-4">
                    <div>
                      <div className="text-6xl mb-4">🌍</div>
                      <h2 className="text-3xl font-display font-bold text-white mb-2">Page not found</h2>
                      <a href="/" className="btn-primary inline-block mt-4">Go Home</a>
                    </div>
                  </div>
                } />
              </Routes>
            </AnimatePresence>
          </Suspense>
        </div>
        <Toaster
          position="bottom-right"
          toastOptions={{
            style: {
              background: '#111120',
              color: '#e8e6f5',
              border: '1px solid #1e1e35',
              borderRadius: '12px',
              fontFamily: 'Outfit, sans-serif',
              fontSize: '14px',
            },
            success: { iconTheme: { primary: '#10b981', secondary: '#111120' } },
            error: { iconTheme: { primary: '#ef4444', secondary: '#111120' } },
          }}
        />
      </AuthProvider>
    </BrowserRouter>
  )
}
