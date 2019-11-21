//@flow
import { guest_only, manager_or_admin, regular_or_admin, owner_manager_or_admin } from 'components/pages/auth/authorizer/Roles'

const Acl = {
  Signin: guest_only,
  Signup: guest_only,
  UserList: manager_or_admin,
  NewUser: manager_or_admin,
  EditUser: owner_manager_or_admin,
  ActivityList: regular_or_admin,
  NewActivity: regular_or_admin,
  EditActivity: regular_or_admin,
}

export default Acl
