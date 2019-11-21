//@flow
import { takeEvery, put, call } from 'redux-saga/effects'
import * as api from 'api'
import { SubmissionError } from 'redux-form'
import { SAGA_CREATE_USER, fetchUsers } from 'reducers/Saga'
import { browserHistory } from 'react-router'
import { clone } from 'lodash'
import { showSnackbar } from 'reducers/Ui'

export const handleWorkingMinutes = (workingMinutes: string) => {
  if (workingMinutes) {
    const [hours, minutes] = workingMinutes.split(':')
    return parseInt(hours, 10) * 60 + parseInt(minutes, 10)
  }
  return workingMinutes
}

function* perform(a) {
  try {
    const { formData, resolve, reject } = a.payload

    const data = clone(formData)
    data.working_minutes = handleWorkingMinutes(data.working_minutes)

    const response = yield api.signup(data)

    if (!response.error) {
      yield call(resolve)
      yield put(fetchUsers())
      yield call(browserHistory.push, '/users')
      yield put(showSnackbar('User created'))
    } else {
      const error = new SubmissionError(response.error)
      yield call(reject, error)
      yield put(showSnackbar('User creation failed'))
    }
  } catch (err) { console.log(err) }
}

function* watch(): Generator<*,*,*> {
  yield takeEvery(SAGA_CREATE_USER, perform)
}

export default watch
