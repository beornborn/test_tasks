//@flow
import { takeEvery, put } from 'redux-saga/effects'
import * as api from 'api'
import { SAGA_FETCH_USERS } from 'reducers/Saga'
import { setUsers } from 'reducers/Data'

function* perform(_a) {
  try {
    const response = yield api.fetchUsers()

    if (!response.error) {
      yield put(setUsers(response))
    }
  } catch (err) { console.log(err) }
}

function* watch(): Generator<*,*,*> {
  yield takeEvery(SAGA_FETCH_USERS, perform)
}

export default watch
