-- Show permissions for all users
SELECT *
  grantor,
  privileges_description, -- SELECT, UPDATE, DELETE, etc.
  object_schema,
  object_name, -- table
  grantee
FROM grants;

