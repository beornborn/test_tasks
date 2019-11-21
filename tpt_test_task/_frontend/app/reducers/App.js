//@flow
import type { Action } from 'Types'
import update from 'immutability-helper'
import { createAction } from 'redux-actions'

export const SET_SELECTED_USER = 'app/SET_SELECTED_USER'
export const SET_SELECTED_ACTIVITY = 'app/SET_SELECTED_ACTIVITY'
export const SET_ACTIVITY_FILTER = 'app/SET_ACTIVITY_FILTER'

export const setSelectedUser = (user: Object) => createAction(SET_SELECTED_USER)({ user })
export const setSelectedActivity = (activity: Object) => createAction(SET_SELECTED_ACTIVITY)({ activity })
export const setActivityFilter = (filter: Object) => createAction(SET_ACTIVITY_FILTER)({ filter })

const initialState = {
  selectedUser: {},
  selectedActivity: {},
  activityFilter: {
    fromDate: null,
    toDate: null,
  },
}

export default function reducer(state: Object = initialState, action: Action) {
  const p = action.payload
  switch (action.type) {
    case SET_SELECTED_USER:
      return update(state, {selectedUser: {$set: p.user}})
    case SET_SELECTED_ACTIVITY:
      return update(state, {selectedActivity: {$set: p.activity}})
    case SET_ACTIVITY_FILTER:
      return update(state, {activityFilter: {$set: p.filter}})
    default:
      return state
  }
}
