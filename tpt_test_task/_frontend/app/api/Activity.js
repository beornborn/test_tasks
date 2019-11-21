//@flow
import { routes } from 'Config'
import { apiGet, apiPost, apiDelete, apiPut } from 'api/__helpers'

export function fetchActivities(params: Object = {}) {
  return apiGet(routes.activities.index(), params)
}

export function fetchActivity(id: number) {
  return apiGet(routes.activities.show(id))
}

export function createActivity(params: Object) {
  return apiPost(routes.activities.create(), params)
}

export function deleteActivity(id: number) {
  return apiDelete(routes.activities.delete(id))
}

export function updateActivity(id: number, params: Object) {
  return apiPut(routes.activities.update(id), params)
}
