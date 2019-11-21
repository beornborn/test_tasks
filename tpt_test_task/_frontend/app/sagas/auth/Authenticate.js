//@flow
import { call, put, takeEvery } from 'redux-saga/effects'
import * as api from 'api'
import { setCurrentUser } from 'reducers/Data'
import { SAGA_AUTHENTICATE } from 'reducers/Saga'
import Localstorage from 'services/Localstorage'

export function* authenticate(user: Object, token: string = ''): Generator<*,*,*> {
  if (token) Localstorage.setAuthToken(token)
  yield put(setCurrentUser(user))
}

function* perform(a) {
  try {
    if (Localstorage.getAuthToken()) {
      const response = yield api.getMe()
      if (!response.error) yield authenticate(response.user)
    }
    yield call(a.payload.callback)
  } catch (err) { console.log(err) }
}

function* watch(): Generator<*,*,*> {
  yield takeEvery(SAGA_AUTHENTICATE, perform)
}

export default watch
