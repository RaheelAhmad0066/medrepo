import { useState, useEffect } from 'react';
import { 
  Users, 
  Pill, 
  Map, 
  TrendingUp, 
  Activity, 
  Plus, 
  Edit3, 
  Trash2, 
  CheckCircle, 
  XCircle,
  LogOut,
  MapPin,
  Lock,
  UserCheck
} from 'lucide-react';
import { useUser, useClerk, SignedIn, SignedOut, SignIn } from '@clerk/clerk-react';
import { supabase } from './services/supabase';
import { db } from './services/db';
import type { Profile, Product, Territory, Order, Dcr } from './services/db';

type TabType = 'dashboard' | 'users' | 'products' | 'territories' | 'activity';

export default function App() {
  const { user, isLoaded } = useUser();
  const { signOut } = useClerk();
  const [currentUserProfile, setCurrentUserProfile] = useState<Profile | null>(null);
  const [activeTab, setActiveTab] = useState<TabType>('dashboard');
  
  // State for database records
  const [users, setUsers] = useState<Profile[]>([]);
  const [products, setProducts] = useState<Product[]>([]);
  const [territories, setTerritories] = useState<Territory[]>([]);
  const [orders, setOrders] = useState<Order[]>([]);
  const [dcrs, setDcrs] = useState<Dcr[]>([]);

  // Modals state
  const [userModalOpen, setUserModalOpen] = useState(false);
  const [productModalOpen, setProductModalOpen] = useState(false);
  const [territoryModalOpen, setTerritoryModalOpen] = useState(false);
  const [deleteModalState, setDeleteModalState] = useState<{ isOpen: boolean; type: 'user' | 'product' | 'territory' | null; id: string | number | null; name: string }>({ isOpen: false, type: null, id: null, name: '' });

  // Edit states
  const [editingUser, setEditingUser] = useState<Profile | null>(null);
  const [editingProduct, setEditingProduct] = useState<Product | null>(null);
  const [editingTerritory, setEditingTerritory] = useState<Territory | null>(null);

  // Form Fields State
  const [userForm, setUserForm] = useState({
    email: '',
    full_name: '',
    role: 'medical_rep' as Profile['role'],
    territory_ids: [] as (string | number)[],
    is_active: true
  });

  const [productForm, setProductForm] = useState({
    name: '',
    sku: '',
    category: '',
    price: 0,
    description: '',
    is_active: true
  });

  const [territoryForm, setTerritoryForm] = useState({
    name: '',
    zone: 'North'
  });

  const [activityTab, setActivityTab] = useState<'orders' | 'dcr'>('orders');

  const [isLiveSupabase, setIsLiveSupabase] = useState<boolean>(false);

  // Load Data from Supabase with local fallback
  const fetchAllData = async () => {
    try {
      // 1. Territories
      const { data: dbTerrs, error: errTerrs } = await supabase.from('territories').select('*');
      if (errTerrs) throw errTerrs;

      // 2. Products
      const { data: dbProds, error: errProds } = await supabase.from('products').select('*');
      if (errProds) throw errProds;

      // 3. Profiles
      const { data: dbUsers, error: errUsers } = await supabase.from('profiles').select('*');
      if (errUsers) throw errUsers;

      // 4. Orders
      const { data: dbOrders, error: errOrders } = await supabase.from('orders').select('*, profiles(full_name)');
      if (errOrders) throw errOrders;

      // 5. DCRs
      const { data: dbDcrs, error: errDcrs } = await supabase.from('dcrs').select('*, profiles(full_name)');
      if (errDcrs) throw errDcrs;

      setIsLiveSupabase(true);

      setTerritories(dbTerrs.map((t: any) => ({
        id: t.id,
        name: t.name,
        zone: t.region || 'North'
      })));

      setProducts(dbProds.map((p: any) => ({
        id: p.id,
        name: p.name,
        sku: p.sku || '',
        category: p.category || 'Analgesics',
        price: Number(p.net_price || 0),
        description: p.formulation || '',
        is_active: p.is_active ?? true
      })));

      setUsers(dbUsers.map((u: any) => ({
        id: u.id,
        email: u.email || '',
        full_name: u.full_name || 'Anonymous User',
        role: u.role || 'medical_rep',
        territory_ids: u.territory_id ? [u.territory_id] : [],
        is_active: u.is_active ?? true
      })));

      setOrders(dbOrders.map((o: any) => ({
        id: o.id,
        rep_name: o.profiles?.full_name || 'System Rep',
        chemist_name: 'Chemist Store',
        order_date: o.order_date,
        status: o.status,
        total_amount: Number(o.total_amount || 0),
        region: 'North'
      })));

      setDcrs(dbDcrs.map((d: any) => ({
        id: d.id,
        rep_name: d.profiles?.full_name || 'System Rep',
        visit_date: d.date,
        target_type: 'doctor',
        target_name: 'Visit stop',
        status: d.status,
        notes: d.manager_comment || ''
      })));
    } catch (err) {
      console.warn("Supabase fetch failed, falling back to LocalStorage seed data", err);
      setIsLiveSupabase(false);
      setUsers(db.getUsers());
      setProducts(db.getProducts());
      setTerritories(db.getTerritories());
      setOrders(db.getOrders());
      setDcrs(db.getDcrs());
    }
  };

  // Sync Clerk profile with Supabase
  useEffect(() => {
    if (isLoaded && user) {
      const checkAndSetupUserProfile = async () => {
        try {
          const { data: profile } = await supabase
            .from('profiles')
            .select('*')
            .eq('clerk_user_id', user.id)
            .single();

          if (profile) {
            setCurrentUserProfile({
              id: profile.id,
              email: profile.email || user.primaryEmailAddress?.emailAddress || '',
              full_name: profile.full_name || user.fullName || 'Admin User',
              role: profile.role || 'admin',
              territory_ids: [],
              is_active: profile.is_active ?? true
            });
          } else {
            // Profile doesn't exist, register new admin profile
            const tempProfile: any = {
              clerk_user_id: user.id,
              full_name: user.fullName || 'Admin User',
              email: user.primaryEmailAddress?.emailAddress || '',
              role: 'admin',
              is_active: true
            };
            const { data: inserted } = await supabase
              .from('profiles')
              .insert([tempProfile])
              .select()
              .single();

            if (inserted) {
              setCurrentUserProfile({
                id: inserted.id,
                email: inserted.email,
                full_name: inserted.full_name,
                role: inserted.role,
                territory_ids: [],
                is_active: inserted.is_active
              });
            } else {
              // Fallback local setting if insert failed (e.g. schema not set up yet)
              setCurrentUserProfile({
                id: user.id,
                email: tempProfile.email,
                full_name: tempProfile.full_name,
                role: 'admin',
                territory_ids: [],
                is_active: true
              });
            }
          }
        } catch (e) {
          console.warn("Failed to sync profile with Supabase, using Clerk credentials locally", e);
          setCurrentUserProfile({
            id: user.id,
            email: user.primaryEmailAddress?.emailAddress || '',
            full_name: user.fullName || 'Raheel Ahmad',
            role: 'admin',
            territory_ids: [],
            is_active: true
          });
        }
      };
      checkAndSetupUserProfile();
    }
  }, [user, isLoaded]);

  // Load Database Records
  useEffect(() => {
    if (user) {
      fetchAllData();
    }
  }, [user]);

  // Save when state changes (for local fallback & remote inserts)
  const saveUsersState = async (newUsers: Profile[]) => {
    setUsers(newUsers);
    db.saveUsers(newUsers);
  };

  const saveProductsState = async (newProds: Product[]) => {
    setProducts(newProds);
    db.saveProducts(newProds);
  };

  const saveTerritoriesState = async (newTerrs: Territory[]) => {
    setTerritories(newTerrs);
    db.saveTerritories(newTerrs);
  };

  // Actions - Users
  const handleOpenUserModal = (user: Profile | null = null) => {
    if (user) {
      setEditingUser(user);
      setUserForm({
        email: user.email,
        full_name: user.full_name,
        role: user.role,
        territory_ids: user.territory_ids,
        is_active: user.is_active
      });
    } else {
      setEditingUser(null);
      setUserForm({
        email: '',
        full_name: '',
        role: 'medical_rep',
        territory_ids: [],
        is_active: true
      });
    }
    setUserModalOpen(true);
  };

  const handleSaveUser = async (e: React.FormEvent) => {
    e.preventDefault();
    try {
      const payload: any = {
        full_name: userForm.full_name,
        email: userForm.email,
        role: userForm.role,
        territory_id: userForm.territory_ids.length > 0 ? userForm.territory_ids[0] : null,
        is_active: userForm.is_active
      };
      
      if (!editingUser) {
        payload.clerk_user_id = `clerk_prov_${Date.now()}`;
      }

      if (editingUser) {
        const { error } = await supabase.from('profiles').update(payload).eq('id', editingUser.id);
        if (error) throw error;
        const updated = users.map(u => u.id === editingUser.id ? { ...u, ...userForm } : u);
        saveUsersState(updated);
      } else {
        const { data, error } = await supabase.from('profiles').insert([payload]).select().single();
        if (error) throw error;
        const newUser: Profile = {
          id: data ? data.id : `usr_${Date.now()}`,
          ...userForm
        };
        saveUsersState([...users, newUser]);
      }
    } catch (err) {
      console.warn("Failed to write user to Supabase, updating local state", err);
      if (editingUser) {
        const updated = users.map(u => u.id === editingUser.id ? { ...u, ...userForm } : u);
        saveUsersState(updated);
      } else {
        const newUser: Profile = {
          id: `usr_${Date.now()}`,
          ...userForm
        };
        saveUsersState([...users, newUser]);
      }
    }
    setUserModalOpen(false);
  };

  const handleDeleteUser = (id: string, name: string) => {
    setDeleteModalState({ isOpen: true, type: 'user', id, name });
  };

  // Actions - Products
  const handleOpenProductModal = (prod: Product | null = null) => {
    if (prod) {
      setEditingProduct(prod);
      setProductForm({
        name: prod.name,
        sku: prod.sku,
        category: prod.category,
        price: prod.price,
        description: prod.description,
        is_active: prod.is_active
      });
    } else {
      setEditingProduct(null);
      setProductForm({
        name: '',
        sku: '',
        category: 'Analgesics',
        price: 0,
        description: '',
        is_active: true
      });
    }
    setProductModalOpen(true);
  };

  const handleSaveProduct = async (e: React.FormEvent) => {
    e.preventDefault();
    try {
      const payload = {
        name: productForm.name,
        sku: productForm.sku,
        category: productForm.category,
        net_price: Number(productForm.price),
        is_active: productForm.is_active,
        formulation: productForm.description
      };

      if (editingProduct) {
        const { error } = await supabase.from('products').update(payload).eq('id', editingProduct.id);
        if (error) throw error;
        const updated = products.map(p => p.id === editingProduct.id ? { ...p, ...productForm } : p);
        saveProductsState(updated);
      } else {
        const { data, error } = await supabase.from('products').insert([payload]).select().single();
        if (error) throw error;
        const newProd: Product = {
          id: data ? data.id : `prod_${Date.now()}`,
          ...productForm
        };
        saveProductsState([...products, newProd]);
      }
    } catch (err) {
      console.warn("Failed to save product to Supabase, updating local state", err);
      if (editingProduct) {
        const updated = products.map(p => p.id === editingProduct.id ? { ...p, ...productForm } : p);
        saveProductsState(updated);
      } else {
        const newProd: Product = {
          id: `prod_${Date.now()}`,
          ...productForm
        };
        saveProductsState([...products, newProd]);
      }
    }
    setProductModalOpen(false);
  };

  const handleDeleteProduct = (id: string, name: string) => {
    setDeleteModalState({ isOpen: true, type: 'product', id, name });
  };

  // Actions - Territories
  const handleOpenTerritoryModal = (ter: Territory | null = null) => {
    if (ter) {
      setEditingTerritory(ter);
      setTerritoryForm({
        name: ter.name,
        zone: ter.zone
      });
    } else {
      setEditingTerritory(null);
      setTerritoryForm({
        name: '',
        zone: 'North'
      });
    }
    setTerritoryModalOpen(true);
  };

  const handleSaveTerritory = async (e: React.FormEvent) => {
    e.preventDefault();
    try {
      const payload = {
        name: territoryForm.name,
        region: territoryForm.zone
      };

      if (editingTerritory) {
        const { error } = await supabase.from('territories').update(payload).eq('id', editingTerritory.id);
        if (error) throw error;
        const updated = territories.map(t => t.id === editingTerritory.id ? { ...t, ...territoryForm } : t);
        saveTerritoriesState(updated);
      } else {
        const { data, error } = await supabase.from('territories').insert([payload]).select().single();
        if (error) throw error;
        const newTerr: Territory = {
          id: data ? data.id : Date.now(),
          ...territoryForm
        };
        saveTerritoriesState([...territories, newTerr]);
      }
    } catch (err) {
      console.warn("Failed to save territory to Supabase, updating local state", err);
      if (editingTerritory) {
        const updated = territories.map(t => t.id === editingTerritory.id ? { ...t, ...territoryForm } : t);
        saveTerritoriesState(updated);
      } else {
        const newTerr: Territory = {
          id: Date.now(),
          ...territoryForm
        };
        saveTerritoriesState([...territories, newTerr]);
      }
    }
    setTerritoryModalOpen(false);
  };

  const handleDeleteTerritory = (id: number, name: string) => {
    setDeleteModalState({ isOpen: true, type: 'territory', id, name });
  };

  const confirmDeletion = async () => {
    const { type, id } = deleteModalState;
    if (!type || id === null) return;

    try {
      if (type === 'user') {
        await supabase.from('profiles').delete().eq('id', id);
        const updated = users.filter(u => u.id !== id);
        saveUsersState(updated);
      } else if (type === 'product') {
        await supabase.from('products').delete().eq('id', id);
        const updated = products.filter(p => p.id !== id);
        saveProductsState(updated);
      } else if (type === 'territory') {
        await supabase.from('territories').delete().eq('id', id);
        const updated = territories.filter(t => t.id !== id);
        saveTerritoriesState(updated);
      }
    } catch (err) {
      console.warn("Failed to delete from Supabase, applying local state removal", err);
      if (type === 'user') saveUsersState(users.filter(u => u.id !== id));
      if (type === 'product') saveProductsState(products.filter(p => p.id !== id));
      if (type === 'territory') saveTerritoriesState(territories.filter(t => t.id !== id));
    }

    setDeleteModalState({ isOpen: false, type: null, id: null, name: '' });
  };

  // Calculate Metrics
  const activeRepsCount = users.filter(u => u.role === 'medical_rep' && u.is_active).length;
  const activeProductsCount = products.filter(p => p.is_active).length;
  const totalOrdersAmount = orders.reduce((sum, o) => sum + o.total_amount, 0);

  return (
    <>
      <SignedOut>
        <div className="auth-container" style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', minHeight: '100vh', background: 'radial-gradient(circle, #1e293b 0%, #0f172a 100%)' }}>
          <div className="auth-card" style={{ maxWidth: '400px', width: '100%' }}>
            <div className="auth-header" style={{ marginBottom: '24px' }}>
              <div className="auth-logo" style={{ display: 'flex', justifyContent: 'center', marginBottom: '16px' }}>
                <Lock style={{ color: '#00dc82' }} size={40} />
              </div>
              <h1 className="auth-title" style={{ fontSize: '28px', fontWeight: 800, textAlign: 'center', color: '#fff', margin: '0 0 4px 0' }}>MedRep Pro</h1>
              <p className="auth-subtitle" style={{ fontSize: '14px', color: '#94a3b8', textAlign: 'center', margin: 0 }}>Enterprise Administrative Console</p>
            </div>
            
            <SignIn 
              routing="hash"
              appearance={{
                elements: {
                  card: 'bg-transparent border-0 shadow-none',
                  headerTitle: 'hidden',
                  headerSubtitle: 'hidden',
                  footer: 'hidden'
                }
              }}
            />
          </div>
        </div>
      </SignedOut>

      <SignedIn>
        <div className="app-container">
          {/* Sidebar Navigation */}
          <aside className="sidebar">
            <div className="brand">
              <div className="brand-icon">
                <Users style={{ color: '#000' }} size={22} />
              </div>
              <span className="brand-name">MedRep Pro</span>
            </div>
            
            <nav className="nav-menu">
              <button 
                onClick={() => setActiveTab('dashboard')} 
                className={`nav-item ${activeTab === 'dashboard' ? 'active' : ''}`}
              >
                <TrendingUp size={18} />
                <span>Dashboard</span>
              </button>

              <button 
                onClick={() => setActiveTab('users')} 
                className={`nav-item ${activeTab === 'users' ? 'active' : ''}`}
              >
                <Users size={18} />
                <span>User Provisioning</span>
              </button>

              <button 
                onClick={() => setActiveTab('products')} 
                className={`nav-item ${activeTab === 'products' ? 'active' : ''}`}
              >
                <Pill size={18} />
                <span>Product Catalog</span>
              </button>

              <button 
                onClick={() => setActiveTab('territories')} 
                className={`nav-item ${activeTab === 'territories' ? 'active' : ''}`}
              >
                <Map size={18} />
                <span>Territory Config</span>
              </button>

              <button 
                onClick={() => setActiveTab('activity')} 
                className={`nav-item ${activeTab === 'activity' ? 'active' : ''}`}
              >
                <Activity size={18} />
                <span>Activity Stream</span>
              </button>
            </nav>

            <div className="sidebar-footer">
              <div className="user-profile-tile">
                <div className="user-avatar">
                  {currentUserProfile?.full_name?.[0].toUpperCase() || 'R'}
                </div>
                <div className="user-info">
                  <span className="user-name">{currentUserProfile?.full_name || 'Raheel Ahmad'}</span>
                  <span className="user-role">{currentUserProfile?.role || 'admin'}</span>
                </div>
              </div>
              <button onClick={() => signOut()} className="btn btn-secondary logout-btn" style={{ width: '100%', marginTop: '12px' }}>
                <LogOut size={16} />
                <span>Sign Out</span>
              </button>
            </div>
          </aside>

          {/* Main Content Area */}
          <main className="main-content">
            {/* Top Navbar */}
            <header className="header">
              <div className="header-title">
                <h1>
                  {activeTab === 'dashboard' && 'Executive Metrics Overview'}
                  {activeTab === 'users' && 'User Management & Provisioning'}
                  {activeTab === 'products' && 'Pharmaceutical Catalog'}
                  {activeTab === 'territories' && 'Geographical Territories'}
                  {activeTab === 'activity' && 'Realtime Activities Stream'}
                </h1>
              </div>
            </header>

            <div className="page-container">
              {!isLiveSupabase && (
                <div style={{
                  background: 'rgba(245, 158, 11, 0.1)',
                  border: '1px solid rgba(245, 158, 11, 0.25)',
                  borderRadius: '12px',
                  padding: '16px 20px',
                  marginBottom: '24px',
                  color: '#f59e0b',
                  fontSize: '14px',
                  display: 'flex',
                  alignItems: 'center',
                  gap: '12px',
                  backdropFilter: 'blur(8px)'
                }}>
                  <span style={{ fontSize: '20px' }}>⚠️</span>
                  <div>
                    <strong>Offline Sandbox Mode:</strong> Database schema is not initialized in Supabase. 
                    Please execute the SQL script in <code>supabase_schema.sql</code> in your Supabase SQL editor to link live data.
                  </div>
                </div>
              )}
              {isLiveSupabase && (
                <div style={{
                  background: 'rgba(16, 185, 129, 0.1)',
                  border: '1px solid rgba(16, 185, 129, 0.25)',
                  borderRadius: '12px',
                  padding: '12px 20px',
                  marginBottom: '24px',
                  color: '#10b981',
                  fontSize: '13px',
                  display: 'flex',
                  alignItems: 'center',
                  gap: '8px',
                  backdropFilter: 'blur(8px)'
                }}>
                  <div style={{ width: '8px', height: '8px', borderRadius: '50%', backgroundColor: '#10b981', boxShadow: '0 0 10px #10b981' }} />
                  <span>Live Supabase Connected</span>
                </div>
              )}
              {/* Dashboard View */}
              {activeTab === 'dashboard' && (
                <div className="tab-pane">
                  {/* KPI Cards Grid */}
                  <div className="card-grid">
                    {/* Card 1: Sales */}
                    <div className="glass-card">
                      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', width: '100%' }}>
                        <div style={{ display: 'flex', flexDirection: 'column', gap: '6px' }}>
                          <span className="card-title">Total Sales (MTD)</span>
                          <span className="card-value">${totalOrdersAmount.toLocaleString()}</span>
                          <span className="card-trend trend-up">
                            ↑ +14.2% <span style={{ color: 'var(--text-muted)', fontWeight: 400 }}>from last month</span>
                          </span>
                        </div>
                        <div style={{
                          background: 'rgba(0, 242, 254, 0.1)',
                          border: '1px solid rgba(0, 242, 254, 0.2)',
                          borderRadius: '12px',
                          padding: '10px',
                          color: 'var(--primary)',
                          boxShadow: '0 0 15px rgba(0, 242, 254, 0.1)'
                        }}>
                          <TrendingUp size={20} />
                        </div>
                      </div>
                    </div>

                    {/* Card 2: Field Reps */}
                    <div className="glass-card">
                      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', width: '100%' }}>
                        <div style={{ display: 'flex', flexDirection: 'column', gap: '6px' }}>
                          <span className="card-title">Active Field Reps</span>
                          <span className="card-value">{activeRepsCount}</span>
                          <span className="card-trend trend-up">
                            ↑ 100% <span style={{ color: 'var(--text-muted)', fontWeight: 400 }}>active call status</span>
                          </span>
                        </div>
                        <div style={{
                          background: 'rgba(79, 172, 254, 0.1)',
                          border: '1px solid rgba(79, 172, 254, 0.2)',
                          borderRadius: '12px',
                          padding: '10px',
                          color: 'var(--secondary)',
                          boxShadow: '0 0 15px rgba(79, 172, 254, 0.1)'
                        }}>
                          <Users size={20} />
                        </div>
                      </div>
                    </div>

                    {/* Card 3: Products */}
                    <div className="glass-card">
                      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', width: '100%' }}>
                        <div style={{ display: 'flex', flexDirection: 'column', gap: '6px' }}>
                          <span className="card-title">Catalog Products</span>
                          <span className="card-value">{activeProductsCount}</span>
                          <span className="card-trend trend-up" style={{ color: 'var(--success)' }}>
                            ● Active <span style={{ color: 'var(--text-muted)', fontWeight: 400 }}>SKUs in rotation</span>
                          </span>
                        </div>
                        <div style={{
                          background: 'rgba(16, 185, 129, 0.1)',
                          border: '1px solid rgba(16, 185, 129, 0.2)',
                          borderRadius: '12px',
                          padding: '10px',
                          color: 'var(--success)',
                          boxShadow: '0 0 15px rgba(16, 185, 129, 0.1)'
                        }}>
                          <Pill size={20} />
                        </div>
                      </div>
                    </div>

                    {/* Card 4: Territories */}
                    <div className="glass-card">
                      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', width: '100%' }}>
                        <div style={{ display: 'flex', flexDirection: 'column', gap: '6px' }}>
                          <span className="card-title">Tracked Territories</span>
                          <span className="card-value">{territories.length}</span>
                          <span className="card-trend trend-up" style={{ color: 'var(--warning)' }}>
                            → {territories.length} Zones <span style={{ color: 'var(--text-muted)', fontWeight: 400 }}>operational coverage</span>
                          </span>
                        </div>
                        <div style={{
                          background: 'rgba(245, 158, 11, 0.1)',
                          border: '1px solid rgba(245, 158, 11, 0.2)',
                          borderRadius: '12px',
                          padding: '10px',
                          color: 'var(--warning)',
                          boxShadow: '0 0 15px rgba(245, 158, 11, 0.1)'
                        }}>
                          <Map size={20} />
                        </div>
                      </div>
                    </div>
                  </div>

                  {/* Two-Column Dashboard Content */}
                  <div style={{ display: 'grid', gridTemplateColumns: '2fr 1fr', gap: '24px', marginTop: '24px' }}>
                    {/* Left: Chart Container */}
                    <div className="glass-card" style={{ display: 'flex', flexDirection: 'column', minHeight: '380px' }}>
                      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '32px' }}>
                        <div>
                          <h2 className="table-title" style={{ fontSize: '18px', fontWeight: 700 }}>Weekly Sales Performance</h2>
                          <span style={{ fontSize: '13px', color: 'var(--text-secondary)' }}>Gross order volume submitted by field medical representatives</span>
                        </div>
                        <div style={{ display: 'flex', gap: '8px', background: 'rgba(255,255,255,0.03)', padding: '4px', borderRadius: '8px', border: '1px solid var(--border-color)' }}>
                          <span style={{ fontSize: '12px', padding: '4px 10px', background: 'rgba(0, 242, 254, 0.1)', color: 'var(--primary)', borderRadius: '6px', fontWeight: 600 }}>Active Volume</span>
                        </div>
                      </div>

                      {/* Premium Graphical Line Chart */}
                      <div style={{ position: 'relative', flexGrow: 1, display: 'flex', flexDirection: 'column', height: '240px' }}>
                        {/* Background Dashed Grid Lines */}
                        <div style={{ position: 'absolute', width: '100%', height: '180px', display: 'flex', flexDirection: 'column', justifyContent: 'space-between', zIndex: 0 }}>
                          {[10000, 7500, 5000, 2500, 0].map((val, idx) => (
                            <div key={idx} style={{ display: 'flex', alignItems: 'center', width: '100%', height: '20px' }}>
                              <span style={{ width: '45px', fontSize: '11px', color: 'var(--text-muted)', fontFamily: 'monospace' }}>${val}</span>
                              <div style={{ flexGrow: 1, borderTop: idx === 4 ? '1px solid rgba(255,255,255,0.1)' : '1px dashed rgba(255,255,255,0.06)' }} />
                            </div>
                          ))}
                        </div>

                        {/* SVG Drawing Layer */}
                        <div style={{ position: 'relative', zIndex: 1, flexGrow: 1, paddingLeft: '45px', height: '180px' }}>
                          <svg viewBox="0 0 600 180" width="100%" height="180" style={{ overflow: 'visible' }}>
                            <defs>
                              <linearGradient id="area-gradient" x1="0" y1="0" x2="0" y2="1">
                                <stop offset="0%" stopColor="var(--primary)" stopOpacity="0.25" />
                                <stop offset="100%" stopColor="var(--primary)" stopOpacity="0.0" />
                              </linearGradient>
                              <linearGradient id="line-gradient" x1="0" y1="0" x2="1" y2="0">
                                <stop offset="0%" stopColor="var(--primary)" />
                                <stop offset="100%" stopColor="var(--secondary)" />
                              </linearGradient>
                              <filter id="glow" x="-20%" y="-20%" width="140%" height="140%">
                                <feDropShadow dx="0" dy="4" stdDeviation="6" floodColor="var(--primary)" floodOpacity="0.5" />
                              </filter>
                            </defs>

                            {/* Vertical helper grid lines */}
                            {[50, 133.3, 216.6, 300, 383.3, 466.6, 550].map((x, idx) => (
                              <line key={idx} x1={x} y1="0" x2={x} y2="170" stroke="rgba(255,255,255,0.02)" strokeDasharray="3 3" />
                            ))}

                            {/* Filled Area Under Line */}
                            <path 
                              d="M 50 110 L 133.3 72.5 L 216.6 122 L 300 36.5 L 383.3 89 L 466.6 53 L 550 32 L 550 170 L 50 170 Z" 
                              fill="url(#area-gradient)" 
                            />

                            {/* Neon Curved/Segmented Line */}
                            <path 
                              d="M 50 110 L 133.3 72.5 L 216.6 122 L 300 36.5 L 383.3 89 L 466.6 53 L 550 32" 
                              fill="none" 
                              stroke="url(#line-gradient)" 
                              strokeWidth="3.5" 
                              strokeLinecap="round"
                              strokeLinejoin="round"
                              filter="url(#glow)"
                            />

                            {/* Interactive Data Nodes */}
                            {[
                              { val: 4000, x: 50, y: 110, day: 'Mon' },
                              { val: 6500, x: 133.3, y: 72.5, day: 'Tue' },
                              { val: 3200, x: 216.6, y: 122, day: 'Wed' },
                              { val: 8900, x: 300, y: 36.5, day: 'Thu' },
                              { val: 5400, x: 383.3, y: 89, day: 'Fri' },
                              { val: 7800, x: 466.6, y: 53, day: 'Sat' },
                              { val: 9200, x: 550, y: 32, day: 'Sun' }
                            ].map((pt, idx) => (
                              <g key={idx} className="chart-node" style={{ cursor: 'pointer' }}>
                                {/* Floating Value Tooltip (Background) */}
                                <rect 
                                  x={pt.x - 24} 
                                  y={pt.y - 28} 
                                  width="48" 
                                  height="18" 
                                  rx="4" 
                                  fill="#0f1524" 
                                  stroke="var(--primary)" 
                                  strokeWidth="1" 
                                />
                                <text 
                                  x={pt.x} 
                                  y={pt.y - 16} 
                                  fill="#fff" 
                                  fontSize="9.5" 
                                  fontWeight="700" 
                                  textAnchor="middle"
                                >
                                  ${pt.val}
                                </text>

                                {/* Outer Glowing Ring */}
                                <circle 
                                  cx={pt.x} 
                                  cy={pt.y} 
                                  r="8" 
                                  fill="rgba(0, 242, 254, 0.15)" 
                                  stroke="var(--primary)" 
                                  strokeWidth="1" 
                                />
                                {/* Inner Solid Dot */}
                                <circle 
                                  cx={pt.x} 
                                  cy={pt.y} 
                                  r="4" 
                                  fill="#fff" 
                                />
                              </g>
                            ))}
                          </svg>
                        </div>

                        {/* X-Axis labels */}
                        <div style={{ display: 'flex', justifyContent: 'space-between', paddingLeft: '95px', paddingRight: '50px', marginTop: '10px' }}>
                          {['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'].map((day, idx) => (
                            <span key={idx} style={{ fontSize: '12px', fontWeight: 600, color: 'var(--text-secondary)' }}>{day}</span>
                          ))}
                        </div>
                      </div>
                    </div>

                    {/* Right: Operational Summary Card */}
                    <div className="glass-card" style={{ display: 'flex', flexDirection: 'column' }}>
                      <h3 className="table-title" style={{ fontSize: '16px', fontWeight: 700, marginBottom: '24px' }}>System Performance</h3>
                      
                      <div style={{ display: 'flex', flexDirection: 'column', gap: '16px', flexGrow: 1 }}>
                        <div style={{ background: 'rgba(255,255,255,0.02)', padding: '14px', borderRadius: '12px', border: '1px solid var(--border-color)' }}>
                          <span style={{ fontSize: '12px', color: 'var(--text-secondary)' }}>Avg. Order Size</span>
                          <h4 style={{ fontSize: '20px', fontWeight: 800, color: '#fff', marginTop: '4px' }}>${(totalOrdersAmount / (orders.length || 1)).toLocaleString(undefined, {maximumFractionDigits: 0})}</h4>
                        </div>
                        <div style={{ background: 'rgba(255,255,255,0.02)', padding: '14px', borderRadius: '12px', border: '1px solid var(--border-color)' }}>
                          <span style={{ fontSize: '12px', color: 'var(--text-secondary)' }}>Pending Verifications</span>
                          <h4 style={{ fontSize: '20px', fontWeight: 800, color: 'var(--warning)', marginTop: '4px' }}>{dcrs.filter(d => d.status === 'submitted').length} Reports</h4>
                        </div>
                        <div style={{ background: 'rgba(255,255,255,0.02)', padding: '14px', borderRadius: '12px', border: '1px solid var(--border-color)' }}>
                          <span style={{ fontSize: '12px', color: 'var(--text-secondary)' }}>Top Territory</span>
                          <h4 style={{ fontSize: '16px', fontWeight: 800, color: 'var(--primary)', marginTop: '4px' }}>{territories[0]?.name || 'Lahore Central'}</h4>
                        </div>
                      </div>

                      <button onClick={() => setActiveTab('activity')} className="btn btn-secondary" style={{ width: '100%', marginTop: '20px', justifyContent: 'center' }}>
                        View Activity Stream
                      </button>
                    </div>
                  </div>
                </div>
              )}

              {/* Users Tab */}
              {activeTab === 'users' && (
                <div className="tab-pane">
                  <div className="table-card">
                    <div className="table-header-row">
                      <h2 className="table-title">Authorized System Users</h2>
                      <button onClick={() => handleOpenUserModal()} className="btn btn-primary">
                        <Plus size={16} />
                        <span>Provision User</span>
                      </button>
                    </div>
                    <table className="custom-table">
                      <thead>
                        <tr>
                          <th>Full Name</th>
                          <th>Email Address</th>
                          <th>System Role</th>
                          <th>Status</th>
                          <th style={{ textAlign: 'right' }}>Actions</th>
                        </tr>
                      </thead>
                      <tbody>
                        {users.map(u => (
                          <tr key={u.id}>
                            <td style={{ fontWeight: 600 }}>{u.full_name}</td>
                            <td>{u.email}</td>
                            <td>
                              <span className={`badge badge-${u.role === 'admin' ? 'admin' : u.role === 'manager' ? 'manager' : 'rep'}`}>
                                {u.role}
                              </span>
                            </td>
                            <td>
                              {u.is_active ? (
                                <span style={{ color: 'var(--success)', display: 'flex', alignItems: 'center', gap: '6px', fontSize: '13px' }}>
                                  <CheckCircle size={14} /> Active
                                </span>
                              ) : (
                                <span style={{ color: 'var(--text-muted)', display: 'flex', alignItems: 'center', gap: '6px', fontSize: '13px' }}>
                                  <XCircle size={14} /> Suspended
                                </span>
                              )}
                            </td>
                            <td style={{ textAlign: 'right' }}>
                              <div style={{ display: 'flex', gap: '8px', justifyContent: 'flex-end' }}>
                                <button onClick={() => handleOpenUserModal(u)} className="btn-icon-only">
                                  <Edit3 size={15} />
                                </button>
                                <button onClick={() => handleDeleteUser(u.id, u.full_name)} className="btn-icon-only text-danger">
                                  <Trash2 size={15} style={{ color: 'var(--danger)' }} />
                                </button>
                              </div>
                            </td>
                          </tr>
                        ))}
                      </tbody>
                    </table>
                  </div>
                </div>
              )}

              {/* Products Tab */}
              {activeTab === 'products' && (
                <div className="tab-pane">
                  <div className="table-card">
                    <div className="table-header-row">
                      <h2 className="table-title">Pharmaceutical SKU Catalog</h2>
                      <button onClick={() => handleOpenProductModal()} className="btn btn-primary">
                        <Plus size={16} />
                        <span>Add Product</span>
                      </button>
                    </div>
                    <table className="custom-table">
                      <thead>
                        <tr>
                          <th>SKU</th>
                          <th>Product Name</th>
                          <th>Category</th>
                          <th>Unit Price</th>
                          <th>Status</th>
                          <th style={{ textAlign: 'right' }}>Actions</th>
                        </tr>
                      </thead>
                      <tbody>
                        {products.map(p => (
                          <tr key={p.id}>
                            <td style={{ fontFamily: 'monospace', fontWeight: 600 }}>{p.sku}</td>
                            <td style={{ fontWeight: 600 }}>{p.name}</td>
                            <td>{p.category}</td>
                            <td style={{ fontWeight: 700 }}>${p.price.toFixed(2)}</td>
                            <td>
                              {p.is_active ? (
                                <span className="badge badge-active">Active</span>
                              ) : (
                                <span className="badge badge-inactive">Inactive</span>
                              )}
                            </td>
                            <td style={{ textAlign: 'right' }}>
                              <div style={{ display: 'flex', gap: '8px', justifyContent: 'flex-end' }}>
                                <button onClick={() => handleOpenProductModal(p)} className="btn-icon-only">
                                  <Edit3 size={15} />
                                </button>
                                <button onClick={() => handleDeleteProduct(p.id, p.name)} className="btn-icon-only text-danger">
                                  <Trash2 size={15} style={{ color: 'var(--danger)' }} />
                                </button>
                              </div>
                            </td>
                          </tr>
                        ))}
                      </tbody>
                    </table>
                  </div>
                </div>
              )}

              {/* Territories Tab */}
              {activeTab === 'territories' && (
                <div className="tab-pane">
                  <div className="table-card">
                    <div className="table-header-row">
                      <h2 className="table-title">Geographical Coverage Map</h2>
                      <button onClick={() => handleOpenTerritoryModal()} className="btn btn-primary">
                        <Plus size={16} />
                        <span>Configure Territory</span>
                      </button>
                    </div>
                    <table className="custom-table">
                      <thead>
                        <tr>
                          <th>Territory ID</th>
                          <th>Territory Name</th>
                          <th>Regional Zone</th>
                          <th style={{ textAlign: 'right' }}>Actions</th>
                        </tr>
                      </thead>
                      <tbody>
                        {territories.map(t => (
                          <tr key={t.id}>
                            <td style={{ fontFamily: 'monospace' }}>#{t.id}</td>
                            <td style={{ fontWeight: 600 }}>{t.name}</td>
                            <td>
                              <span style={{ display: 'flex', alignItems: 'center', gap: '6px' }}>
                                <MapPin size={14} color="var(--primary)" /> {t.zone}
                              </span>
                            </td>
                            <td style={{ textAlign: 'right' }}>
                              <div style={{ display: 'flex', gap: '8px', justifyContent: 'flex-end' }}>
                                <button onClick={() => handleOpenTerritoryModal(t)} className="btn-icon-only">
                                  <Edit3 size={15} />
                                </button>
                                <button onClick={() => handleDeleteTerritory(t.id, t.name)} className="btn-icon-only text-danger">
                                  <Trash2 size={15} style={{ color: 'var(--danger)' }} />
                                </button>
                              </div>
                            </td>
                          </tr>
                        ))}
                      </tbody>
                    </table>
                  </div>
                </div>
              )}

              {/* Activities Tab */}
              {activeTab === 'activity' && (
                <div className="tab-pane">
                  <div style={{ display: 'flex', gap: '12px', marginBottom: '20px' }}>
                    <button 
                      onClick={() => setActivityTab('orders')}
                      className={`btn ${activityTab === 'orders' ? 'btn-primary' : 'btn-secondary'}`}
                    >
                      Chemist Order Submissions
                    </button>
                    <button 
                      onClick={() => setActivityTab('dcr')}
                      className={`btn ${activityTab === 'dcr' ? 'btn-primary' : 'btn-secondary'}`}
                    >
                      DCR Daily Call Logs
                    </button>
                  </div>

                  {activityTab === 'orders' ? (
                    <div className="table-card">
                      <table className="custom-table">
                        <thead>
                          <tr>
                            <th>Order ID</th>
                            <th>Field Representative</th>
                            <th>Chemist Shop</th>
                            <th>Order Date</th>
                            <th>Amount</th>
                            <th>Delivery Status</th>
                          </tr>
                        </thead>
                        <tbody>
                          {orders.map(o => (
                            <tr key={o.id}>
                              <td style={{ fontFamily: 'monospace' }}>{o.id}</td>
                              <td style={{ fontWeight: 600 }}>{o.rep_name}</td>
                              <td>{o.chemist_name}</td>
                              <td>{o.order_date}</td>
                              <td style={{ fontWeight: 700 }}>${o.total_amount.toLocaleString()}</td>
                              <td>
                                <span className={`badge badge-${o.status}`}>
                                  {o.status}
                                </span>
                              </td>
                            </tr>
                          ))}
                        </tbody>
                      </table>
                    </div>
                  ) : (
                    <div className="table-card">
                      <table className="custom-table">
                        <thead>
                          <tr>
                            <th>DCR ID</th>
                            <th>Representative</th>
                            <th>Date</th>
                            <th>Visit Target</th>
                            <th>Type</th>
                            <th>Status</th>
                            <th>Outcome Notes</th>
                          </tr>
                        </thead>
                        <tbody>
                          {dcrs.map(d => (
                            <tr key={d.id}>
                              <td style={{ fontFamily: 'monospace' }}>{d.id}</td>
                              <td style={{ fontWeight: 600 }}>{d.rep_name}</td>
                              <td>{d.visit_date}</td>
                              <td style={{ fontWeight: 600 }}>{d.target_name}</td>
                              <td>
                                <span className={`badge badge-${d.target_type === 'doctor' ? 'admin' : 'manager'}`}>
                                  {d.target_type}
                                </span>
                              </td>
                              <td>
                                <span className={`badge badge-${d.status === 'completed' ? 'success' : 'pending'}`}>
                                  {d.status}
                                </span>
                              </td>
                              <td style={{ fontSize: '13px', color: 'var(--text-secondary)' }}>{d.notes}</td>
                            </tr>
                          ))}
                        </tbody>
                      </table>
                    </div>
                  )}
                </div>
              )}
            </div> {/* Closing page-container */}
          </main>

          {/* Custom Delete Confirmation Modal */}
          {deleteModalState.isOpen && (
            <div className="modal-backdrop">
              <div className="modal-content" style={{ maxWidth: '400px', textAlign: 'center' }}>
                <div style={{
                  width: '64px',
                  height: '64px',
                  borderRadius: '50%',
                  background: 'rgba(239, 68, 68, 0.1)',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  margin: '0 auto 24px auto',
                  color: 'var(--danger)',
                  boxShadow: '0 0 20px rgba(239, 68, 68, 0.2)'
                }}>
                  <Trash2 size={32} />
                </div>
                <h3 className="modal-title" style={{ marginBottom: '12px', justifyContent: 'center' }}>Confirm Deletion</h3>
                <p style={{ color: 'var(--text-secondary)', fontSize: '14px', lineHeight: '1.5', marginBottom: '32px' }}>
                  Are you sure you want to delete <strong style={{ color: '#fff' }}>{deleteModalState.name}</strong>? 
                  This action cannot be undone.
                </p>
                <div className="modal-actions" style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '16px', marginTop: 0 }}>
                  <button 
                    onClick={() => setDeleteModalState({ isOpen: false, type: null, id: null, name: '' })} 
                    className="btn btn-secondary" 
                    style={{ justifyContent: 'center' }}
                  >
                    Cancel
                  </button>
                  <button 
                    onClick={confirmDeletion} 
                    className="btn btn-primary" 
                    style={{ background: 'var(--danger)', borderColor: 'var(--danger)', justifyContent: 'center', boxShadow: '0 4px 15px rgba(239, 68, 68, 0.4)' }}
                  >
                    Yes, Delete
                  </button>
                </div>
              </div>
            </div>
          )}

          {/* User Form Modal */}
          {userModalOpen && (
            <div className="modal-backdrop">
              <div className="modal-content">
                <h3 className="modal-title">{editingUser ? 'Update User Provisioning' : 'Provision New System User'}</h3>
                <form onSubmit={handleSaveUser}>
                  <div className="form-group">
                    <label>Full Name</label>
                    <input 
                      type="text" 
                      required 
                      className="form-control" 
                      value={userForm.full_name}
                      onChange={e => setUserForm({ ...userForm, full_name: e.target.value })}
                    />
                  </div>
                  <div className="form-group">
                    <label>Email Address</label>
                    <input 
                      type="email" 
                      required 
                      className="form-control" 
                      value={userForm.email}
                      onChange={e => setUserForm({ ...userForm, email: e.target.value })}
                    />
                  </div>
                  <div className="form-group">
                    <label>System Role Mapping</label>
                    <select 
                      className="form-control"
                      value={userForm.role}
                      onChange={e => setUserForm({ ...userForm, role: e.target.value as Profile['role'] })}
                    >
                      <option value="admin">System Admin</option>
                      <option value="manager">Territory Manager</option>
                      <option value="medical_rep">Medical Representative</option>
                    </select>
                  </div>
                  <div className="form-group">
                    <label>Assigned Territory (Optional)</label>
                    <select 
                      className="form-control"
                      value={userForm.territory_ids[0] || ''}
                      onChange={e => setUserForm({ ...userForm, territory_ids: e.target.value ? [e.target.value] : [] })}
                    >
                      <option value="">None / Floating</option>
                      {territories.map(t => (
                        <option key={t.id} value={t.id}>{t.name} ({t.zone})</option>
                      ))}
                    </select>
                  </div>
                  <div className="form-group" style={{ display: 'flex', alignItems: 'center', gap: '8px', marginTop: '12px' }}>
                    <input 
                      type="checkbox" 
                      id="userActive"
                      checked={userForm.is_active}
                      onChange={e => setUserForm({ ...userForm, is_active: e.target.checked })}
                    />
                    <label htmlFor="userActive" style={{ margin: 0 }}>Authorize Active Access</label>
                  </div>
                  <div className="modal-actions">
                    <button type="button" onClick={() => setUserModalOpen(false)} className="btn btn-secondary">Cancel</button>
                    <button type="submit" className="btn btn-primary">Save Profile</button>
                  </div>
                </form>
              </div>
            </div>
          )}

          {/* Product Form Modal */}
          {productModalOpen && (
            <div className="modal-backdrop">
              <div className="modal-content">
                <h3 className="modal-title">{editingProduct ? 'Modify Catalog SKU' : 'Add Product to Catalog'}</h3>
                <form onSubmit={handleSaveProduct}>
                  <div className="form-group">
                    <label>Product Name</label>
                    <input 
                      type="text" 
                      required 
                      className="form-control" 
                      value={productForm.name}
                      onChange={e => setProductForm({ ...productForm, name: e.target.value })}
                    />
                  </div>
                  <div className="form-group">
                    <label>Stock Keeping Unit (SKU)</label>
                    <input 
                      type="text" 
                      required 
                      className="form-control" 
                      placeholder="e.g. PAN-500"
                      value={productForm.sku}
                      onChange={e => setProductForm({ ...productForm, sku: e.target.value })}
                    />
                  </div>
                  <div className="form-group">
                    <label>Therapeutic Category</label>
                    <select 
                      className="form-control"
                      value={productForm.category}
                      onChange={e => setProductForm({ ...productForm, category: e.target.value })}
                    >
                      <option value="Analgesics">Analgesics</option>
                      <option value="Antibiotics">Antibiotics</option>
                      <option value="Cardiovascular">Cardiovascular</option>
                      <option value="Respiratory">Respiratory</option>
                      <option value="Gastrointestinal">Gastrointestinal</option>
                    </select>
                  </div>
                  <div className="form-group">
                    <label>Net Unit Price ($)</label>
                    <input 
                      type="number" 
                      step="0.01"
                      required 
                      className="form-control" 
                      value={productForm.price}
                      onChange={e => setProductForm({ ...productForm, price: Number(e.target.value) })}
                    />
                  </div>
                  <div className="form-group">
                    <label>Formulation / Pack Size</label>
                    <input 
                      type="text" 
                      className="form-control" 
                      placeholder="e.g. tablet, syrup (10s)"
                      value={productForm.description}
                      onChange={e => setProductForm({ ...productForm, description: e.target.value })}
                    />
                  </div>
                  <div className="form-group" style={{ display: 'flex', alignItems: 'center', gap: '8px', marginTop: '12px' }}>
                    <input 
                      type="checkbox" 
                      id="prodActive"
                      checked={productForm.is_active}
                      onChange={e => setProductForm({ ...productForm, is_active: e.target.checked })}
                    />
                    <label htmlFor="prodActive" style={{ margin: 0 }}>Eligible for active detailing</label>
                  </div>
                  <div className="modal-actions">
                    <button type="button" onClick={() => setProductModalOpen(false)} className="btn btn-secondary">Cancel</button>
                    <button type="submit" className="btn btn-primary">Save Product</button>
                  </div>
                </form>
              </div>
            </div>
          )}

          {/* Territory Form Modal */}
          {territoryModalOpen && (
            <div className="modal-backdrop">
              <div className="modal-content">
                <h3 className="modal-title">{editingTerritory ? 'Modify Territory Definition' : 'Configure New Territory'}</h3>
                <form onSubmit={handleSaveTerritory}>
                  <div className="form-group">
                    <label>Territory Name</label>
                    <input 
                      type="text" 
                      required 
                      className="form-control" 
                      placeholder="e.g. Peshawar Central"
                      value={territoryForm.name}
                      onChange={e => setTerritoryForm({ ...territoryForm, name: e.target.value })}
                    />
                  </div>
                  <div className="form-group">
                    <label>Regional Zone</label>
                    <select 
                      className="form-control"
                      value={territoryForm.zone}
                      onChange={e => setTerritoryForm({ ...territoryForm, zone: e.target.value })}
                    >
                      <option value="North">North Zone</option>
                      <option value="South">South Zone</option>
                      <option value="East">East Zone</option>
                      <option value="West">West Zone</option>
                    </select>
                  </div>
                  <div className="modal-actions">
                    <button type="button" onClick={() => setTerritoryModalOpen(false)} className="btn btn-secondary">Cancel</button>
                    <button type="submit" className="btn btn-primary">Save Territory</button>
                  </div>
                </form>
              </div>
            </div>
          )}
        </div>
      </SignedIn>
    </>
  );
}
