//@flow
import { createAction } from 'redux-actions'

export const SAGA_AUTHENTICATE = 'SAGA_AUTHENTICATE'
export const SAGA_SIGNIN = 'SAGA_SIGNIN'
export const SAGA_SIGNUP = 'SAGA_SIGNUP'
export const SAGA_LOGOUT = 'SAGA_LOGOUT'

export const SAGA_FETCH_USERS = 'SAGA_FETCH_USERS'
export const SAGA_FETCH_USER = 'SAGA_FETCH_USER'
export const SAGA_DELETE_USER = 'SAGA_DELETE_USER'
export const SAGA_CREATE_USER = 'SAGA_CREATE_USER'
export const SAGA_UPDATE_USER = 'SAGA_UPDATE_USER'

export const SAGA_FETCH_ACTIVITIES = 'SAGA_FETCH_ACTIVITIES'
export const SAGA_FETCH_ACTIVITY = 'SAGA_FETCH_ACTIVITY'
export const SAGA_DELETE_ACTIVITY = 'SAGA_DELETE_ACTIVITY'
export const SAGA_CREATE_ACTIVITY = 'SAGA_CREATE_ACTIVITY'
export const SAGA_UPDATE_ACTIVITY = 'SAGA_UPDATE_ACTIVITY'

export const authenticate = (callback: Function) => createAction(SAGA_AUTHENTICATE)({ callback })
export const signIn = (formData: Object, resolve: Function, reject: Object) =>
  createAction(SAGA_SIGNIN)({ formData, resolve, reject })
export const signUp = (formData: Object, resolve: Function, reject: Object) =>
  createAction(SAGA_SIGNUP)({ formData, resolve, reject })
export const logout = () => createAction(SAGA_LOGOUT)()

export const fetchUsers = () => createAction(SAGA_FETCH_USERS)()
export const fetchUser = (id: string | number) => createAction(SAGA_FETCH_USER)({ id })
export const deleteUser = (id: number) => createAction(SAGA_DELETE_USER)({ id })
export const createUser = (formData: Object, resolve: Function, reject: Object) =>
  createAction(SAGA_CREATE_USER)({ formData, resolve, reject })
export const updateUser = (formData: Object, resolve: Function, reject: Object) =>
  createAction(SAGA_UPDATE_USER)({ formData, resolve, reject })

export const fetchActivities = () => createAction(SAGA_FETCH_ACTIVITIES)()
export const fetchActivity = (id: string | number) => createAction(SAGA_FETCH_ACTIVITY)({ id })
export const deleteActivity = (id: number) => createAction(SAGA_DELETE_ACTIVITY)({ id })
export const createActivity = (formData: Object, resolve: Function, reject: Function) =>
  createAction(SAGA_CREATE_ACTIVITY)({ formData, resolve, reject })
export const updateActivity = (formData: Object, resolve: Function, reject: Function) =>
  createAction(SAGA_UPDATE_ACTIVITY)({ formData, resolve, reject })
