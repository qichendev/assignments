const mongoose = require("mongoose");

const User = require("./User");

const memoryUsers = [];

function cloneUser(user) {
  return {
    ...user,
    _id: user._id.toString()
  };
}

function sortByCreatedAtDesc(left, right) {
  return new Date(right.createdAt).getTime() - new Date(left.createdAt).getTime();
}

function validateWithMongoose(payload) {
  const candidate = new User(payload);
  const validationError = candidate.validateSync();

  if (validationError) {
    throw validationError;
  }

  return candidate;
}

function usesDatabase() {
  return Boolean(process.env.MONGODB_URI);
}

async function listUsers() {
  if (usesDatabase()) {
    return User.find({}).sort({ createdAt: -1 }).lean();
  }

  return memoryUsers.slice().sort(sortByCreatedAtDesc).map(cloneUser);
}

async function createUser(payload) {
  if (usesDatabase()) {
    return User.create(payload);
  }

  const candidate = validateWithMongoose(payload);
  const now = new Date();
  const record = {
    ...candidate.toObject(),
    _id: new mongoose.Types.ObjectId().toString(),
    createdAt: now,
    updatedAt: now
  };

  memoryUsers.unshift(record);
  return cloneUser(record);
}

async function findUserById(id) {
  if (usesDatabase()) {
    return User.findById(id).lean();
  }

  const user = memoryUsers.find((item) => item._id.toString() === id);
  return user ? cloneUser(user) : null;
}

async function updateUser(id, payload) {
  if (usesDatabase()) {
    const user = await User.findById(id);

    if (!user) {
      return null;
    }

    Object.assign(user, payload);
    await user.save();
    return user.toObject();
  }

  const index = memoryUsers.findIndex((item) => item._id.toString() === id);

  if (index === -1) {
    return null;
  }

  const existing = memoryUsers[index];
  const merged = {
    ...existing,
    ...payload,
    _id: existing._id,
    createdAt: existing.createdAt,
    updatedAt: new Date()
  };

  validateWithMongoose(merged);
  memoryUsers[index] = merged;
  return cloneUser(merged);
}

async function deleteUser(id) {
  if (usesDatabase()) {
    return User.findByIdAndDelete(id);
  }

  const index = memoryUsers.findIndex((item) => item._id.toString() === id);

  if (index === -1) {
    return null;
  }

  const [deleted] = memoryUsers.splice(index, 1);
  return cloneUser(deleted);
}

module.exports = {
  listUsers,
  createUser,
  findUserById,
  updateUser,
  deleteUser,
  usesDatabase
};
