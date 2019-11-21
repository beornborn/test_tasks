//@flow
import { takeEvery, call, put } from 'redux-saga/effects'
import * as api from 'api'
import { SAGA_SIGNIN } from 'reducers/Saga'
import { SubmissionError } from 'redux-form'
import { authenticate } from 'sagas/auth/Authenticate'
import { isObject } from 'lodash'
import { showSnackbar } from 'reducers/Ui'

function* perform(a) {
  try {
    const { formData, resolve, reject } = a.payload
    const response = yield api.signin(formData)

    if (!response.error) {
      yield call(resolve)
      yield authenticate(response.user, response.token)
      yield put(showSnackbar('Logged in successfully'))
    } else {
      let error
      if (isObject(response.error)) {
        error = new SubmissionError(response.error)
      } else {
        error = new SubmissionError({_error: response.error})
      }
      yield call(reject, error)
    }
  } catch (err) { console.log(err) }
}

function* watch(): Generator<*,*,*> {
  yield takeEvery(SAGA_SIGNIN, perform)
}

export default watch
