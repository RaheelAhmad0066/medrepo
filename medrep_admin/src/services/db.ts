export interface Profile {
  id: string;
  email: string;
  full_name: string;
  role: 'admin' | 'manager' | 'medical_rep';
  territory_ids: number[];
  is_active: boolean;
}

export interface Product {
  id: string;
  name: string;
  sku: string;
  category: string;
  price: number;
  description: string;
  is_active: boolean;
}

export interface Territory {
  id: number;
  name: string;
  zone: string;
}

export interface Order {
  id: string;
  rep_name: string;
  chemist_name: string;
  order_date: string;
  status: 'pending' | 'confirmed' | 'delivered' | 'paid';
  total_amount: number;
  region: string;
}

export interface Dcr {
  id: string;
  rep_name: string;
  visit_date: string;
  target_type: 'doctor' | 'chemist';
  target_name: string;
  status: 'completed' | 'pending';
  notes: string;
}

// Default Seed Data
const initialTerritories: Territory[] = [
  { id: 101, name: 'Lahore Central', zone: 'North' },
  { id: 102, name: 'Karachi South', zone: 'South' },
  { id: 103, name: 'Islamabad Capital', zone: 'North' },
  { id: 104, name: 'Multan City', zone: 'West' },
  { id: 105, name: 'Peshawar Valley', zone: 'North' },
];

const initialUsers: Profile[] = [
  { id: 'usr_01', email: 'ahmad.admin@medrep.pro', full_name: 'Raheel Ahmad', role: 'admin', territory_ids: [], is_active: true },
  { id: 'usr_02', email: 'khalid.manager@medrep.pro', full_name: 'Dr. Khalid Jamil', role: 'manager', territory_ids: [101, 103], is_active: true },
  { id: 'usr_03', email: 'salman.rep@medrep.pro', full_name: 'Salman Khan', role: 'medical_rep', territory_ids: [101], is_active: true },
  { id: 'usr_04', email: 'zainab.rep@medrep.pro', full_name: 'Zainab Bibi', role: 'medical_rep', territory_ids: [102], is_active: true },
  { id: 'usr_05', email: 'tariq.rep@medrep.pro', full_name: 'Tariq Mahmood', role: 'medical_rep', territory_ids: [104], is_active: false },
];

const initialProducts: Product[] = [
  { id: 'prod_01', name: 'Panadol Extra 500mg', sku: 'PAN-EXT-500', category: 'Analgesics', price: 12.50, description: 'Paracetamol with Caffeine for fast pain relief', is_active: true },
  { id: 'prod_02', name: 'Amoxil Syrup 250mg/5ml', sku: 'AMX-SYR-250', category: 'Antibiotics', price: 45.00, description: 'Broad-spectrum penicillin antibiotic for children', is_active: true },
  { id: 'prod_03', name: 'Augmentin Tablets 625mg', sku: 'AUG-TAB-625', category: 'Antibiotics', price: 95.50, description: 'Co-amoxiclav tablets for bacterial infections', is_active: true },
  { id: 'prod_04', name: 'Lipitor Tablets 20mg', sku: 'LIP-TAB-20', category: 'Cardiovascular', price: 120.00, description: 'Atorvastatin calcium tablets to lower cholesterol', is_active: true },
  { id: 'prod_05', name: 'Ventolin Inhaler 100mcg', sku: 'VEN-INH-100', category: 'Respiratory', price: 35.00, description: 'Salbutamol inhaler for asthma quick relief', is_active: true },
];

const initialOrders: Order[] = [
  { id: 'ord_1001', rep_name: 'Salman Khan', chemist_name: 'Time Medicos', order_date: '2026-05-18', status: 'confirmed', total_amount: 12450.00, region: 'North' },
  { id: 'ord_1002', rep_name: 'Zainab Bibi', chemist_name: 'Kausar Medicos', order_date: '2026-05-18', status: 'delivered', total_amount: 32500.00, region: 'South' },
  { id: 'ord_1003', rep_name: 'Salman Khan', chemist_name: 'Green Pharmacy', order_date: '2026-05-19', status: 'pending', total_amount: 8500.00, region: 'North' },
  { id: 'ord_1004', rep_name: 'Zainab Bibi', chemist_name: 'Defence Pharmacy', order_date: '2026-05-19', status: 'paid', total_amount: 19800.00, region: 'South' },
];

const initialDcrs: Dcr[] = [
  { id: 'dcr_2001', rep_name: 'Salman Khan', visit_date: '2026-05-19', target_type: 'doctor', target_name: 'Dr. Asif Mahmood (Cardiologist)', status: 'completed', notes: 'Discussed Lipitor benefits, distributed 5 samples.' },
  { id: 'dcr_2002', rep_name: 'Salman Khan', visit_date: '2026-05-19', target_type: 'chemist', target_name: 'Time Medicos', status: 'completed', notes: 'Logged order for Augmentin and Panadol.' },
  { id: 'dcr_2003', rep_name: 'Zainab Bibi', visit_date: '2026-05-19', target_type: 'doctor', target_name: 'Dr. Fatima Kidwai (Pediatrician)', status: 'completed', notes: 'Introduced Amoxil syrup. Positive interest.' },
  { id: 'dcr_2004', rep_name: 'Tariq Mahmood', visit_date: '2026-05-18', target_type: 'chemist', target_name: 'Multan Pharmacy', status: 'pending', notes: 'Store was closed, will visit again.' },
];

export const getStoredData = <T>(key: string, initialData: T[]): T[] => {
  const data = localStorage.getItem(key);
  if (!data) {
    localStorage.setItem(key, JSON.stringify(initialData));
    return initialData;
  }
  return JSON.parse(data);
};

export const setStoredData = <T>(key: string, data: T[]): void => {
  localStorage.setItem(key, JSON.stringify(data));
};

export const db = {
  getUsers: () => getStoredData<Profile>('medrep_users', initialUsers),
  saveUsers: (users: Profile[]) => setStoredData<Profile>('medrep_users', users),
  
  getProducts: () => getStoredData<Product>('medrep_products', initialProducts),
  saveProducts: (products: Product[]) => setStoredData<Product>('medrep_products', products),
  
  getTerritories: () => getStoredData<Territory>('medrep_territories', initialTerritories),
  saveTerritories: (territories: Territory[]) => setStoredData<Territory>('medrep_territories', territories),

  getOrders: () => getStoredData<Order>('medrep_orders', initialOrders),
  saveOrders: (orders: Order[]) => setStoredData<Order>('medrep_orders', orders),

  getDcrs: () => getStoredData<Dcr>('medrep_dcrs', initialDcrs),
  saveDcrs: (dcrs: Dcr[]) => setStoredData<Dcr>('medrep_dcrs', dcrs),
};
