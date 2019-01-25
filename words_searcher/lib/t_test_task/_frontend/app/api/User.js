//@flow
import { routes } from 'Config'
import { apiGet, apiDelete, apiPut } from 'api/__helpers'

export function fetchUsers() {
  return apiGet(routes.users.index())
}

export function fetchUser(id: number) {
  return apiGet(routes.users.show(id))
}

export function getMe() {
  return apiGet(routes.users.me())
}

export function deleteUser(id: number) {
  return apiDelete(routes.users.delete(id))
}

export function updateUser(id: number, params: Object) {
  return apiPut(routes.users.update(id), params)
}
