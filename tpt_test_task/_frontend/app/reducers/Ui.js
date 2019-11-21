//@flow
import type { Action } from 'Types'
import update from 'immutability-helper'
import { createAction } from 'redux-actions'

export const SHOW_SNACKBAR = 'SHOW_SNACKBAR'
export const HIDE_SNACKBAR = 'HIDE_SNACKBAR'

export const showSnackbar = (message: string) => createAction(SHOW_SNACKBAR)({ message })
export const hideSnackbar = () => createAction(HIDE_SNACKBAR)()

const initialState = {
  snackbar: {
    open: false,
    message: '',
  },
}

export default function reducer(state: Object = initialState, action: Action) {
  const p = action.payload
  switch (action.type) {
    case SHOW_SNACKBAR:
      return update(state, {snackbar: {$set: {open: true, message: p.message}}})
    case HIDE_SNACKBAR:
      return update(state, {snackbar: {$set: {open: false, message: ''}}})
    default:
      return state
  }
}
