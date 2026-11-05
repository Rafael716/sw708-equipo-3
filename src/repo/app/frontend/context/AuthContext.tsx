"use client";

import { createContext, useContext, useState, useEffect, ReactNode } from "react";
import { useRouter } from "next/navigation";

const API_URL = process.env.NEXT_PUBLIC_API_URL || "http://localhost:3001";

export const MODULE_ROUTES: Record<string, string> = {
  monitoreo: "/monitoreo",
  reservas: "/gestion-reservas",
  maritimo: "/operaciones-maritimas",
  portuario: "/operaciones-portuarias",
};

interface Usuario {
  id_usuario: string;
  correo_electronico: string;
  rol?: string | null;
  empleado: {
    nombre: string;
    apellido: string;
    codigo: string;
  };
  operador: {
    id_operador: string;
    turno: string;
    zona_monitoreo: string;
  } | null;
}

interface AuthContextType {
  usuario: Usuario | null;
  token: string | null;
  modulos: string[];
  login: (correo: string, contrasena: string) => Promise<void>;
  logout: () => void;
  reloadUser: () => Promise<void>;
  setAuthData: (token: string, usuario: Usuario, modulos: string[]) => void;
  hasModule: (modulo: string) => boolean;
  isAuthenticated: boolean;
  loading: boolean;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

function homePath(modulos: string[]): string {
  const rutas = modulos
    .map((m) => MODULE_ROUTES[m])
    .filter((r): r is string => Boolean(r));
  if (rutas.length === 1) {
    return rutas[0];
  }
  return "/"; // Menú de módulos
}

export function AuthProvider({ children }: { children: ReactNode }) {
  const [usuario, setUsuario] = useState<Usuario | null>(null);
  const [token, setToken] = useState<string | null>(null);
  const [modulos, setModulos] = useState<string[]>([]);
  const [loading, setLoading] = useState(true);
  const router = useRouter();

  useEffect(() => {
    // Verificar si hay sesión guardada
    const tokenGuardado = localStorage.getItem("token");
    const usuarioGuardado = localStorage.getItem("usuario");
    const modulosGuardado = localStorage.getItem("modulos");

    if (tokenGuardado && usuarioGuardado) {
      setToken(tokenGuardado);

      try {
        const usuarioData = JSON.parse(usuarioGuardado);
        setUsuario(usuarioData);
        setModulos(modulosGuardado ? JSON.parse(modulosGuardado) : []);
        setLoading(false);
      } catch (error) {
        console.error("Error parsing usuario from localStorage:", error);
        localStorage.removeItem("token");
        localStorage.removeItem("usuario");
        localStorage.removeItem("modulos");
        setToken(null);
        setUsuario(null);
        setModulos([]);
        setLoading(false);
      }
    } else {
      setLoading(false);
    }
  }, []);

  const login = async (correo: string, contrasena: string) => {
    const response = await fetch(`${API_URL}/auth/login`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        correo_electronico: correo,
        contrasena,
      }),
    });

    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.message || "Error al iniciar sesión");
    }

    const data = await response.json();

    // Guardar token
    localStorage.setItem("token", data.access_token);
    setToken(data.access_token);

    // Guardar módulos a los que tiene acceso
    localStorage.setItem("modulos", JSON.stringify(data.modulos || []));
    setModulos(data.modulos || []);

    // Obtener perfil completo desde /auth/profile para asegurar estructura correcta
    const profileResponse = await fetch(`${API_URL}/auth/profile`, {
      headers: {
        Authorization: `Bearer ${data.access_token}`,
      },
    });

    if (profileResponse.ok) {
      const profileData = await profileResponse.json();
      localStorage.setItem("usuario", JSON.stringify(profileData));
      setUsuario(profileData);
    } else {
      localStorage.setItem("usuario", JSON.stringify(data.usuario));
      setUsuario(data.usuario);
    }

    // Redirigir al menú o al único módulo disponible
    router.push(homePath(data.modulos || []));
  };

  const logout = () => {
    // Limpiar localStorage
    localStorage.removeItem("token");
    localStorage.removeItem("usuario");
    localStorage.removeItem("modulos");

    // Limpiar estado
    setToken(null);
    setUsuario(null);
    setModulos([]);

    // Redirigir a login
    router.push("/login");
  };

  const reloadUser = async () => {
    const tokenGuardado = localStorage.getItem("token");
    if (!tokenGuardado) return;

    try {
      const response = await fetch(`${API_URL}/auth/profile`, {
        headers: {
          Authorization: `Bearer ${tokenGuardado}`,
        },
      });

      if (response.ok) {
        const data = await response.json();
        setUsuario(data);
        setModulos(data.modulos || []);
        localStorage.setItem("usuario", JSON.stringify(data));
        localStorage.setItem("modulos", JSON.stringify(data.modulos || []));
      }
    } catch (error) {
      console.error("Error recargando usuario:", error);
    }
  };

  const setAuthData = (newToken: string, newUsuario: Usuario, newModulos: string[] = []) => {
    setToken(newToken);
    setUsuario(newUsuario);
    setModulos(newModulos);
    localStorage.setItem("token", newToken);
    localStorage.setItem("usuario", JSON.stringify(newUsuario));
    localStorage.setItem("modulos", JSON.stringify(newModulos));
  };

  const hasModule = (modulo: string) => modulos.includes(modulo);

  const value: AuthContextType = {
    usuario,
    token,
    modulos,
    login,
    logout,
    reloadUser,
    setAuthData,
    hasModule,
    isAuthenticated: !!token && !!usuario,
    loading,
  };

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
}

export function useAuth() {
  const context = useContext(AuthContext);
  if (context === undefined) {
    throw new Error("useAuth debe ser usado dentro de un AuthProvider");
  }
  return context;
}