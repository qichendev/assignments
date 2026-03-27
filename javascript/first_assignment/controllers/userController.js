const mongoose = require("mongoose");

const userRepository = require("../models/userRepository");

const editableFields = [
  "lastName",
  "firstName",
  "dateOfBirth",
  "address1",
  "address2",
  "city",
  "postalCode",
  "country",
  "phoneNumber",
  "email",
  "userNotes"
];

function buildUserPayload(body) {
  const payload = {};

  editableFields.forEach((field) => {
    const value = body[field];

    if (field === "dateOfBirth") {
      payload[field] = value ? new Date(value) : undefined;
      return;
    }

    payload[field] = typeof value === "string" ? value.trim() : "";
  });

  return payload;
}

function formatDateForInput(dateValue) {
  if (!dateValue) {
    return "";
  }

  const date = new Date(dateValue);

  if (Number.isNaN(date.getTime())) {
    return "";
  }

  return date.toISOString().slice(0, 10);
}

function normalizeValidationErrors(error) {
  if (!error || !error.errors) {
    return [];
  }

  return Object.values(error.errors).map((item) => item.message);
}

function createFormData(user = {}, overrides = {}) {
  const formData = {};

  editableFields.forEach((field) => {
    if (field === "dateOfBirth") {
      formData[field] = overrides[field] ?? formatDateForInput(user[field]);
      return;
    }

    formData[field] = overrides[field] ?? user[field] ?? "";
  });

  return formData;
}

function previewNotes(notes) {
  if (!notes) {
    return "";
  }

  return notes.length > 40 ? `${notes.slice(0, 40)}...` : notes;
}

exports.listUsers = async (req, res, next) => {
  try {
    const users = await userRepository.listUsers();

    res.render("users/list", {
      title: "User List",
      users: users.map((user) => ({
        ...user,
        fullName: `${user.firstName || ""} ${user.lastName || ""}`.trim(),
        dateOfBirthFormatted: formatDateForInput(user.dateOfBirth),
        userNotesPreview: previewNotes(user.userNotes)
      })),
      successMessage: req.query.success || ""
    });
  } catch (error) {
    next(error);
  }
};

exports.renderCreateForm = (req, res) => {
  res.render("users/create", {
    title: "Add User",
    formData: createFormData(),
    errors: [],
    successMessage: req.query.success || ""
  });
};

exports.createUser = async (req, res, next) => {
  const payload = buildUserPayload(req.body);

  try {
    await userRepository.createUser(payload);
    res.redirect("/users?success=User%20created%20successfully.");
  } catch (error) {
    if (error.name === "ValidationError") {
      return res.status(400).render("users/create", {
        title: "Add User",
        formData: createFormData({}, req.body),
        errors: normalizeValidationErrors(error),
        successMessage: ""
      });
    }

    next(error);
  }
};

exports.renderEditForm = async (req, res, next) => {
  try {
    if (!mongoose.isValidObjectId(req.params.id)) {
      return res.status(404).render("users/not-found", {
        title: "User Not Found"
      });
    }

    const user = await userRepository.findUserById(req.params.id);

    if (!user) {
      return res.status(404).render("users/not-found", {
        title: "User Not Found"
      });
    }

    res.render("users/edit", {
      title: "Edit User",
      user,
      formData: createFormData(user),
      errors: [],
      successMessage: req.query.success || ""
    });
  } catch (error) {
    next(error);
  }
};

exports.updateUser = async (req, res, next) => {
  const { id } = req.params;
  const payload = buildUserPayload(req.body);

  try {
    if (!mongoose.isValidObjectId(id)) {
      return res.status(404).render("users/not-found", {
        title: "User Not Found"
      });
    }

    const user = await userRepository.findUserById(id);

    if (!user) {
      return res.status(404).render("users/not-found", {
        title: "User Not Found"
      });
    }

    await userRepository.updateUser(id, payload);

    res.redirect(`/users/${id}/edit?success=User%20updated%20successfully.`);
  } catch (error) {
    if (error.name === "ValidationError") {
      return res.status(400).render("users/edit", {
        title: "Edit User",
        user: { _id: id, ...payload },
        formData: createFormData({}, req.body),
        errors: normalizeValidationErrors(error),
        successMessage: ""
      });
    }

    next(error);
  }
};

exports.deleteUser = async (req, res, next) => {
  try {
    if (!mongoose.isValidObjectId(req.params.id)) {
      return res.status(404).render("users/not-found", {
        title: "User Not Found"
      });
    }

    await userRepository.deleteUser(req.params.id);
    res.redirect("/users?success=User%20deleted%20successfully.");
  } catch (error) {
    next(error);
  }
};
