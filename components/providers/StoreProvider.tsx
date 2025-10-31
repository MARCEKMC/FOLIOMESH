'use client';

import { ReactNode, createContext, useContext, useRef } from 'react';
import { create } from 'zustand';
import { devtools } from 'zustand/middleware';
import type { User, Portfolio, Company } from '@/types/database.types';

interface AppState {
  // User state
  user: User | null;
  setUser: (user: User | null) => void;
  
  // Portfolio state
  currentPortfolio: Portfolio | null;
  setCurrentPortfolio: (portfolio: Portfolio | null) => void;
  
  // Company state
  currentCompany: Company | null;
  setCurrentCompany: (company: Company | null) => void;
  
  // UI state
  sidebarOpen: boolean;
  setSidebarOpen: (open: boolean) => void;
  
  // Loading states
  loading: {
    user: boolean;
    portfolio: boolean;
    company: boolean;
  };
  setLoading: (key: keyof AppState['loading'], value: boolean) => void;
  
  // Notifications
  notifications: any[];
  addNotification: (notification: any) => void;
  removeNotification: (id: string) => void;
  clearNotifications: () => void;
}

type AppStore = ReturnType<typeof createAppStore>;

const createAppStore = () =>
  create<AppState>()(
    devtools(
      (set, get) => ({
        // User state
        user: null,
        setUser: (user) => set({ user }, false, 'setUser'),
        
        // Portfolio state
        currentPortfolio: null,
        setCurrentPortfolio: (portfolio) => 
          set({ currentPortfolio: portfolio }, false, 'setCurrentPortfolio'),
        
        // Company state
        currentCompany: null,
        setCurrentCompany: (company) => 
          set({ currentCompany: company }, false, 'setCurrentCompany'),
        
        // UI state
        sidebarOpen: false,
        setSidebarOpen: (open) => set({ sidebarOpen: open }, false, 'setSidebarOpen'),
        
        // Loading states
        loading: {
          user: false,
          portfolio: false,
          company: false,
        },
        setLoading: (key, value) =>
          set(
            (state) => ({
              loading: { ...state.loading, [key]: value },
            }),
            false,
            `setLoading:${key}`
          ),
        
        // Notifications
        notifications: [],
        addNotification: (notification) =>
          set(
            (state) => ({
              notifications: [...state.notifications, notification],
            }),
            false,
            'addNotification'
          ),
        removeNotification: (id) =>
          set(
            (state) => ({
              notifications: state.notifications.filter((n) => n.id !== id),
            }),
            false,
            'removeNotification'
          ),
        clearNotifications: () =>
          set({ notifications: [] }, false, 'clearNotifications'),
      }),
      {
        name: 'foliomesh-store',
      }
    )
  );

const StoreContext = createContext<AppStore | null>(null);

interface StoreProviderProps {
  children: ReactNode;
}

export function StoreProvider({ children }: StoreProviderProps) {
  const storeRef = useRef<AppStore>();
  
  if (!storeRef.current) {
    storeRef.current = createAppStore();
  }

  return (
    <StoreContext.Provider value={storeRef.current}>
      {children}
    </StoreContext.Provider>
  );
}

export function useAppStore<T>(selector: (state: AppState) => T): T {
  const store = useContext(StoreContext);
  if (!store) {
    throw new Error('useAppStore must be used within StoreProvider');
  }
  return store(selector);
}