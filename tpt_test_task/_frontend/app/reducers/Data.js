//@flow
import type { Action } from 'Types'
import update from 'immutability-helper'
import { createAction } from 'redux-actions'

export const SET_CURRENT_USER = 'SET_CURRENT_USER'
export const SET_USERS = 'SET_USERS'
export const SET_ACTIVITIES = 'SET_ACTIVITIES'

export const setCurrentUser = (user: Object) => createAction(SET_CURRENT_USER)({ user })
export const setUsers = (users: Array<Object>) => createAction(SET_USERS)({ users })
export const setActivities = (activities: Array<Object>) => createAction(SET_ACTIVITIES)({ activities })

const initialState = {
  currentUser: {},
  users: [],
  activities: [],
}

export default function reducer(state: Object = initialState, action: Action) {
  const p = action.payload
  switch (action.type) {
    case SET_CURRENT_USER:
      return update(state, {currentUser: {$set: p.user}})
    case SET_USERS:
      return update(state, {users: {$set: p.users}})
    case SET_ACTIVITIES:
      return update(state, {activities: {$set: p.activities}})
    default:
      return state
  }
}
