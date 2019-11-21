//@flow
import { takeEvery, call, put } from 'redux-saga/effects'
import * as api from 'api'
import { SAGA_SIGNUP } from 'reducers/Saga'
import { SubmissionError } from 'redux-form'
import { authenticate } from 'sagas/auth/Authenticate'
import { showSnackbar } from 'reducers/Ui'

function* perform(a) {
  try {
    const { formData, resolve, reject } = a.payload
    const response = yield api.signup(formData)

    if (!response.error) {
      yield call(resolve)
      yield authenticate(response.user, response.token)
      yield put(showSnackbar('Signed up successfully'))
    } else {
      const error = new SubmissionError(response.error)
      yield call(reject, error)
    }
  } catch (err) { console.log(err) }
}

function* watch(): Generator<*,*,*> {
  yield takeEvery(SAGA_SIGNUP, perform)
}

export default watch
