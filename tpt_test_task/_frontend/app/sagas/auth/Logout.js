//@flow
import { takeEvery, put } from 'redux-saga/effects'
import { setCurrentUser } from 'reducers/Data'
import { SAGA_LOGOUT } from 'reducers/Saga'
import Localstorage from 'services/Localstorage'

function* perform(_a) {
  try {
    Localstorage.setAuthToken('')
    yield put(setCurrentUser({}))
  } catch (err) { console.log(err) }
}

function* watch(): Generator<*,*,*> {
  yield takeEvery(SAGA_LOGOUT, perform)
}

export default watch
