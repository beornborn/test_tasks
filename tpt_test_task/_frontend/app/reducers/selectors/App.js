//@flow
import { getCurrentUser } from 'reducers/selectors/Data'

export const getPermissions = (state: Object): Object => {
  const user = getCurrentUser(state)

  return {
    isRegular: user.role === 'regular',
    isManager: user.role === 'manager',
    isAdmin: user.role === 'admin',
  }
}

export const getSelectedUser = (state: Object) => state.app.selectedUser
export const getSelectedActivity = (state: Object) => state.app.selectedActivity
export const getActivityFilter = (state: Object) => state.app.activityFilter
