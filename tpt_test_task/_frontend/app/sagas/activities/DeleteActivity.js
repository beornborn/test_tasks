//@flow
import { takeEvery, put } from 'redux-saga/effects'
import * as api from 'api'
import { SAGA_DELETE_ACTIVITY, fetchActivities } from 'reducers/Saga'
import { showSnackbar } from 'reducers/Ui'

function* perform(a) {
  try {
    const { id } = a.payload
    const response = yield api.deleteActivity(id)

    if (!response.error) {
      yield put(fetchActivities())
      yield put(showSnackbar('Activity deleted'))
    } else {
      yield put(showSnackbar('Activity deletion failed'))
    }
  } catch (err) { console.log(err) }
}

function* watch(): Generator<*,*,*> {
  yield takeEvery(SAGA_DELETE_ACTIVITY, perform)
}

export default watch
