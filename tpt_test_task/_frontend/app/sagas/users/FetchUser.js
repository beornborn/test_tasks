//@flow
import { takeEvery, put, call } from 'redux-saga/effects'
import * as api from 'api'
import { SAGA_FETCH_USER } from 'reducers/Saga'
import { setSelectedUser } from 'reducers/App'
import { browserHistory } from 'react-router'
import { showSnackbar } from 'reducers/Ui'

function* perform(a) {
  try {
    const { id } = a.payload
    const response = yield api.fetchUser(id)

    if (!response.error) {
      yield put(setSelectedUser(response))
    } else {
      yield call(browserHistory.goBack)
      yield put(showSnackbar('There is no such user'))
    }
  } catch (err) { console.log(err) }
}

function* watch(): Generator<*,*,*> {
  yield takeEvery(SAGA_FETCH_USER, perform)
}

export default watch
