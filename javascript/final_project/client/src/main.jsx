import "bootstrap/dist/css/bootstrap.min.css";
import React, { useEffect, useMemo, useState } from "react";
import { createRoot } from "react-dom/client";

import {
  createUser,
  deleteUser,
  getUser,
  listUsers,
  updateUser
} from "./api/users";
import { UserForm, emptyUserForm, normalizeUserForForm } from "./components/UserForm";
import "./styles.css";

const pages = {
  login: "login",
  grid: "grid",
  add: "add",
  edit: "edit"
};

function formatDate(value) {
  if (!value) {
    return "";
  }

  const date = new Date(value);
  return Number.isNaN(date.getTime()) ? "" : date.toLocaleDateString();
}

function readValidationMessage(error) {
  const apiErrors = error?.response?.data?.errors;

  if (Array.isArray(apiErrors) && apiErrors.length > 0) {
    return apiErrors.join(" ");
  }

  return error?.response?.data?.message || "The request could not be completed.";
}

function App() {
  // This top-level component owns the simple login state and page navigation.
  // Keeping the state here lets every page share the same API status messages.
  const [isLoggedIn, setIsLoggedIn] = useState(false);
  const [page, setPage] = useState(pages.login);
  const [users, setUsers] = useState([]);
  const [selectedUserId, setSelectedUserId] = useState("");
  const [editingUser, setEditingUser] = useState(emptyUserForm);
  const [loading, setLoading] = useState(false);
  const [status, setStatus] = useState("");
  const [error, setError] = useState("");

  const selectedUser = useMemo(
    () => users.find((user) => user._id === selectedUserId),
    [selectedUserId, users]
  );

  async function refreshUsers() {
    // The table page always reads from the Express REST API, not hard-coded data.
    setLoading(true);
    setError("");

    try {
      const data = await listUsers();
      setUsers(data);
    } catch (requestError) {
      setError(readValidationMessage(requestError));
    } finally {
      setLoading(false);
    }
  }

  useEffect(() => {
    if (isLoggedIn) {
      refreshUsers();
    }
  }, [isLoggedIn]);

  async function handleLogin(event) {
    event.preventDefault();
    setIsLoggedIn(true);
    setPage(pages.grid);
    setStatus("Signed in successfully.");
  }

  async function handleCreate(payload) {
    // POST creates a MongoDB user through the backend controller.
    setLoading(true);
    setError("");

    try {
      await createUser(payload);
      await refreshUsers();
      setStatus("User created successfully.");
      setPage(pages.grid);
    } catch (requestError) {
      setError(readValidationMessage(requestError));
    } finally {
      setLoading(false);
    }
  }

  async function openEditor(id) {
    // The update page loads one fresh record before filling the React form.
    setLoading(true);
    setError("");
    setSelectedUserId(id);

    try {
      const user = await getUser(id);
      setEditingUser(normalizeUserForForm(user));
      setPage(pages.edit);
    } catch (requestError) {
      setError(readValidationMessage(requestError));
    } finally {
      setLoading(false);
    }
  }

  async function handleUpdate(payload) {
    if (!selectedUserId) {
      setError("Select a user before updating.");
      return;
    }

    // PUT keeps the existing MongoDB document id and replaces editable fields.
    setLoading(true);
    setError("");

    try {
      await updateUser(selectedUserId, payload);
      await refreshUsers();
      setStatus("User updated successfully.");
      setPage(pages.grid);
    } catch (requestError) {
      setError(readValidationMessage(requestError));
    } finally {
      setLoading(false);
    }
  }

  async function handleDelete() {
    if (!selectedUserId) {
      setError("Select a user before deleting.");
      return;
    }

    // DELETE is intentionally located on the update page to match the assignment.
    setLoading(true);
    setError("");

    try {
      await deleteUser(selectedUserId);
      await refreshUsers();
      setSelectedUserId("");
      setEditingUser(emptyUserForm);
      setStatus("User deleted successfully.");
      setPage(pages.grid);
    } catch (requestError) {
      setError(readValidationMessage(requestError));
    } finally {
      setLoading(false);
    }
  }

  function renderPage() {
    if (!isLoggedIn || page === pages.login) {
      return <LoginPage onLogin={handleLogin} />;
    }

    if (page === pages.add) {
      return <UserForm title="Add User" submitLabel="Create User" onSubmit={handleCreate} />;
    }

    if (page === pages.edit) {
      return (
        <UserForm
          title="Update User"
          submitLabel="Save Changes"
          initialValues={editingUser}
          onSubmit={handleUpdate}
          onDelete={handleDelete}
          deleteLabel={`Delete ${selectedUser?.firstName || "User"}`}
        />
      );
    }

    return (
      <UserGrid
        loading={loading}
        users={users}
        onEdit={openEditor}
        onRefresh={refreshUsers}
      />
    );
  }

  return (
    <div className="app-shell">
      <header className="topbar">
        <button className="brand-button" type="button" onClick={() => setPage(pages.grid)}>
          User Manager
        </button>
        <nav className="nav-actions" aria-label="Main navigation">
          {isLoggedIn && (
            <>
              <button className="btn btn-outline-light btn-sm" type="button" onClick={() => setPage(pages.grid)}>
                Table
              </button>
              <button className="btn btn-light btn-sm" type="button" onClick={() => setPage(pages.add)}>
                Add
              </button>
              <button className="btn btn-outline-light btn-sm" type="button" onClick={() => setPage(pages.login)}>
                Sign Out
              </button>
            </>
          )}
        </nav>
      </header>

      <main className="main-panel">
        {status && <div className="alert alert-success">{status}</div>}
        {error && <div className="alert alert-danger">{error}</div>}
        {renderPage()}
      </main>
    </div>
  );
}

function LoginPage({ onLogin }) {
  // This is a simple demonstration login page for the project requirement.
  // Authentication is not persisted because the assignment focuses on CRUD.
  return (
    <section className="login-layout">
      <div>
        <p className="eyebrow">Final MERN Project</p>
        <h1>Qi Chen User Directory</h1>
        <p className="lead">
          A React, Express, Mongoose, and MongoDB CRUD system for managing user records.
        </p>
      </div>
      <form className="login-form" onSubmit={onLogin}>
        <label className="form-label" htmlFor="email">Email</label>
        <input className="form-control" id="email" type="email" defaultValue="student@example.com" required />
        <label className="form-label" htmlFor="password">Password</label>
        <input className="form-control" id="password" type="password" defaultValue="password" required />
        <button className="btn btn-primary w-100" type="submit">Sign In</button>
      </form>
    </section>
  );
}

function UserGrid({ loading, users, onEdit, onRefresh }) {
  // The grid page displays the current database records and links to editing.
  return (
    <section>
      <div className="section-heading">
        <div>
          <p className="eyebrow">User Data</p>
          <h1>Directory Table</h1>
        </div>
        <button className="btn btn-outline-primary" type="button" onClick={onRefresh}>
          Refresh
        </button>
      </div>

      <div className="table-responsive grid-frame">
        <table className="table align-middle table-hover">
          <thead>
            <tr>
              <th>Name</th>
              <th>Date of Birth</th>
              <th>City</th>
              <th>Country</th>
              <th>Phone</th>
              <th>Email</th>
              <th>Notes</th>
              <th>Action</th>
            </tr>
          </thead>
          <tbody>
            {users.map((user) => (
              <tr key={user._id}>
                <td>{user.firstName} {user.lastName}</td>
                <td>{formatDate(user.dateOfBirth)}</td>
                <td>{user.city}</td>
                <td>{user.country}</td>
                <td>{user.phoneNumber}</td>
                <td>{user.email}</td>
                <td className="notes-cell">{user.userNotes}</td>
                <td>
                  <button className="btn btn-sm btn-primary" type="button" onClick={() => onEdit(user._id)}>
                    Edit
                  </button>
                </td>
              </tr>
            ))}
            {!loading && users.length === 0 && (
              <tr>
                <td colSpan="8" className="text-center py-4">No users found.</td>
              </tr>
            )}
          </tbody>
        </table>
      </div>
    </section>
  );
}

createRoot(document.getElementById("root")).render(<App />);
