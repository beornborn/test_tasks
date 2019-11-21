//@flow
import { takeEvery, put, call } from 'redux-saga/effects'
import * as api from 'api'
import { SubmissionError } from 'redux-form'
import { SAGA_CREATE_ACTIVITY, fetchActivities } from 'reducers/Saga'
import { browserHistory } from 'react-router'
import { clone } from 'lodash'
import moment from 'moment'
import { handleWorkingMinutes } from 'sagas/users/CreateUser'
import { showSnackbar } from 'reducers/Ui'

function* perform(a) {
  try {
    const { formData, resolve, reject } = a.payload

    const data = clone(formData)
    data.start = moment(formData.start).format()
    data.duration = handleWorkingMinutes(data.duration)

    const response = yield api.createActivity(data)

    if (!response.error) {
      yield call(resolve)
      yield put(fetchActivities())
      yield call(browserHistory.goBack)
      yield put(showSnackbar('Activity created'))
    } else {
      const error = new SubmissionError(response.error)
      yield call(reject, error)
      yield put(showSnackbar('Activity creation failed'))
    }
  } catch (err) { console.log(err) }
}

function* watch(): Generator<*,*,*> {
  yield takeEvery(SAGA_CREATE_ACTIVITY, perform)
}

export default watch
