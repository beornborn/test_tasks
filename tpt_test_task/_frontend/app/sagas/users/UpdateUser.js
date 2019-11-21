//@flow
import { takeEvery, put, call, select } from 'redux-saga/effects'
import * as api from 'api'
import { SubmissionError } from 'redux-form'
import { SAGA_UPDATE_USER, fetchUsers } from 'reducers/Saga'
import { browserHistory } from 'react-router'
import { clone } from 'lodash'
import { handleWorkingMinutes } from 'sagas/users/CreateUser'
import { getSelectedUser } from 'reducers/selectors/App'
import { getCurrentUser } from 'reducers/selectors/Data'
import { setCurrentUser } from 'reducers/Data'
import { showSnackbar } from 'reducers/Ui'

function* perform(a) {
  try {
    const { formData, resolve, reject } = a.payload

    const selectedUser = yield select(getSelectedUser)
    const currentUser = yield select(getCurrentUser)

    const data = clone(formData)
    data.working_minutes = handleWorkingMinutes(data.working_minutes)

    const response = yield api.updateUser(selectedUser.id, data)

    if (!response.error) {
      yield call(resolve)
      yield put(fetchUsers())
      if (response.id === currentUser.id) {
        yield put(setCurrentUser(response))
      }
      yield call(browserHistory.goBack)
      yield put(showSnackbar('User updated'))
    } else {
      const error = new SubmissionError(response.error)
      yield call(reject, error)
      yield put(showSnackbar('User update failed'))
    }
  } catch (err) { console.log(err) }
}

function* watch(): Generator<*,*,*> {
  yield takeEvery(SAGA_UPDATE_USER, perform)
}

export default watch
