//@flow
import { routes } from 'Config'
import { apiPost } from 'api/__helpers'

export function signin(params: Object) {
  return apiPost(routes.auth.signin(), params)
}
export function signup(params: Object) {
  return apiPost(routes.auth.signup(), params)
}
