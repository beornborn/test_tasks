//@flow
import { takeEvery, put } from 'redux-saga/effects'
import * as api from 'api'
import { SAGA_DELETE_USER, fetchUsers } from 'reducers/Saga'
import { showSnackbar } from 'reducers/Ui'

function* perform(a) {
  try {
    const { id } = a.payload
    const response = yield api.deleteUser(id)

    if (!response.error) {
      yield put(fetchUsers())
      yield put(showSnackbar('User deleted'))
    } else {
      yield put(showSnackbar('User deletion failed'))
    }
  } catch (err) { console.log(err) }
}

function* watch(): Generator<*,*,*> {
  yield takeEvery(SAGA_DELETE_USER, perform)
}

export default watch
