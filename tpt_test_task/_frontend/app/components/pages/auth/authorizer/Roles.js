//@flow
export const all_allowed = (_user: Object) => true
export const no_one_allowed = (_user: Object) => false
export const authenticated_only = (user: Object) => user.id !== undefined
export const guest_only = (user: Object) => user.id === undefined
export const manager_or_admin = (user: Object, p: Object) => p.isAdmin || p.isManager
export const owner_manager_or_admin = (user: Object, p: Object, params: Object) => user.id === parseInt(params.id, 10) || p.isAdmin || p.isManager
export const regular_or_admin = (user: Object, p: Object) => p.isAdmin || p.isRegular
