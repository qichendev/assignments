const express = require("express");

const userController = require("../controllers/userController");

const router = express.Router();

router.get("/users", userController.listUsers);
router.get("/users/new", userController.renderCreateForm);
router.post("/users/create", userController.createUser);
router.get("/users/:id/edit", userController.renderEditForm);
router.post("/users/:id/update", userController.updateUser);
router.post("/users/:id/delete", userController.deleteUser);

module.exports = router;
