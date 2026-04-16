import { useEffect, useState } from "react";

export const emptyUserForm = {
  lastName: "",
  firstName: "",
  dateOfBirth: "",
  address1: "",
  address2: "",
  city: "",
  postalCode: "",
  country: "",
  phoneNumber: "",
  email: "",
  userNotes: ""
};

export function normalizeUserForForm(user) {
  // HTML date inputs require yyyy-mm-dd, while MongoDB stores dates as ISO values.
  return {
    ...emptyUserForm,
    ...user,
    dateOfBirth: user?.dateOfBirth ? new Date(user.dateOfBirth).toISOString().slice(0, 10) : ""
  };
}

export function UserForm({
  title,
  submitLabel,
  initialValues = emptyUserForm,
  onSubmit,
  onDelete,
  deleteLabel = "Delete User"
}) {
  // The form is reused by the add page and the update/delete page.
  const [formData, setFormData] = useState(initialValues);

  useEffect(() => {
    setFormData(initialValues);
  }, [initialValues]);

  function updateField(event) {
    // Every input is controlled by React state so validation and submission are predictable.
    const { name, value } = event.target;

    setFormData((currentData) => ({
      ...currentData,
      [name]: value
    }));
  }

  function handleSubmit(event) {
    event.preventDefault();
    onSubmit(formData);
  }

  return (
    <section>
      <div className="section-heading">
        <div>
          <p className="eyebrow">User Record</p>
          <h1>{title}</h1>
        </div>
      </div>

      <form className="user-form" onSubmit={handleSubmit}>
        <div className="row g-3">
          <TextInput label="First name" name="firstName" value={formData.firstName} onChange={updateField} required />
          <TextInput label="Last name" name="lastName" value={formData.lastName} onChange={updateField} required />
          <TextInput label="Date of birth" name="dateOfBirth" type="date" value={formData.dateOfBirth} onChange={updateField} />
          <TextInput label="Email" name="email" type="email" value={formData.email} onChange={updateField} required />
          <TextInput label="Phone number" name="phoneNumber" value={formData.phoneNumber} onChange={updateField} />
          <TextInput label="Country" name="country" value={formData.country} onChange={updateField} />
          <TextInput label="City" name="city" value={formData.city} onChange={updateField} />
          <TextInput label="Postal code" name="postalCode" value={formData.postalCode} onChange={updateField} />
          <TextInput label="Address 1" name="address1" value={formData.address1} onChange={updateField} wide />
          <TextInput label="Address 2" name="address2" value={formData.address2} onChange={updateField} wide />
          <div className="col-12">
            <label className="form-label" htmlFor="userNotes">User notes</label>
            <textarea
              className="form-control"
              id="userNotes"
              name="userNotes"
              rows="4"
              value={formData.userNotes}
              onChange={updateField}
            />
          </div>
        </div>

        <div className="form-actions">
          <button className="btn btn-primary" type="submit">{submitLabel}</button>
          {onDelete && (
            <button className="btn btn-outline-danger" type="button" onClick={onDelete}>
              {deleteLabel}
            </button>
          )}
        </div>
      </form>
    </section>
  );
}

function TextInput({ label, name, value, onChange, type = "text", required = false, wide = false }) {
  return (
    <div className={wide ? "col-12 col-lg-6" : "col-12 col-md-6 col-xl-3"}>
      <label className="form-label" htmlFor={name}>{label}</label>
      <input
        className="form-control"
        id={name}
        name={name}
        type={type}
        value={value}
        onChange={onChange}
        required={required}
      />
    </div>
  );
}
