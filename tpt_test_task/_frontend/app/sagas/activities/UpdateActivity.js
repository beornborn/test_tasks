//@flow
import { takeEvery, put, call, select } from 'redux-saga/effects'
import * as api from 'api'
import { SubmissionError } from 'redux-form'
import { SAGA_UPDATE_ACTIVITY, fetchActivities } from 'reducers/Saga'
import { browserHistory } from 'react-router'
import { clone } from 'lodash'
import { handleWorkingMinutes } from 'sagas/users/CreateUser'
import { getSelectedActivity } from 'reducers/selectors/App'
import { setSelectedActivity } from 'reducers/App'
import moment from 'moment'
import { showSnackbar } from 'reducers/Ui'

function* perform(a) {
  try {
    const { formData, resolve, reject } = a.payload

    const selectedActivity = yield select(getSelectedActivity)

    const data = clone(formData)
    data.start = moment(formData.start).format()
    data.duration = handleWorkingMinutes(data.duration)

    const response = yield api.updateActivity(selectedActivity.id, data)

    if (!response.error) {
      yield call(resolve)
      yield put(fetchActivities())
      if (response.id === selectedActivity.id) {
        yield put(setSelectedActivity(response))
      }
      yield call(browserHistory.goBack)
      yield put(showSnackbar('Activity updated'))
    } else {
      const error = new SubmissionError(response.error)
      yield call(reject, error)
      yield put(showSnackbar('Activity update failed'))
    }
  } catch (err) { console.log(err) }
}

function* watch(): Generator<*,*,*> {
  yield takeEvery(SAGA_UPDATE_ACTIVITY, perform)
}

export default watch
