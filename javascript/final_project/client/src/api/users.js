import axios from "axios";

const api = axios.create({
  baseURL: "/api/users"
});

export async function listUsers() {
  const response = await api.get("/");
  return response.data;
}

export async function getUser(id) {
  const response = await api.get(`/${id}`);
  return response.data;
}

export async function createUser(payload) {
  const response = await api.post("/", payload);
  return response.data;
}

export async function updateUser(id, payload) {
  const response = await api.put(`/${id}`, payload);
  return response.data;
}

export async function deleteUser(id) {
  await api.delete(`/${id}`);
}
