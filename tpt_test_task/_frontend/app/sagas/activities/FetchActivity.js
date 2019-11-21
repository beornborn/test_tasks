//@flow
import { takeEvery, put, call } from 'redux-saga/effects'
import * as api from 'api'
import { SAGA_FETCH_ACTIVITY } from 'reducers/Saga'
import { setSelectedActivity } from 'reducers/App'
import { browserHistory } from 'react-router'
import { showSnackbar } from 'reducers/Ui'

function* perform(a) {
  try {
    const { id } = a.payload
    const response = yield api.fetchActivity(id)

    if (!response.error) {
      yield put(setSelectedActivity(response))
    } else {
      yield call(browserHistory.goBack)
      yield put(showSnackbar('This activity does not exist'))
    }
  } catch (err) { console.log(err) }
}

function* watch(): Generator<*,*,*> {
  yield takeEvery(SAGA_FETCH_ACTIVITY, perform)
}

export default watch
