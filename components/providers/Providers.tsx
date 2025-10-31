'use client';

import { ReactNode } from 'react';
import { ThemeProvider } from './ThemeProvider';
import { SupabaseProvider } from './SupabaseProvider';
import { ToasterProvider } from './ToasterProvider';
import { StoreProvider } from './StoreProvider';

interface ProvidersProps {
  children: ReactNode;
}

export function Providers({ children }: ProvidersProps) {
  return (
    <SupabaseProvider>
      <StoreProvider>
        <ThemeProvider>
          <ToasterProvider />
          {children}
        </ThemeProvider>
      </StoreProvider>
    </SupabaseProvider>
  );
}