//@flow
import { takeEvery, put, select } from 'redux-saga/effects'
import * as api from 'api'
import { SAGA_FETCH_ACTIVITIES } from 'reducers/Saga'
import { setActivities } from 'reducers/Data'
import { getActivityFilter } from 'reducers/selectors/App'
import { clone } from 'lodash'
import moment from 'moment'

const handleQueryParams = (formData: Object) => {
  if (!formData) return {}

  const data = clone(formData)
  if (data.start) {
    data.start = moment(data.start).format('MM-DD-YYYY')
  }
  if (data.end) {
    data.end = moment(data.end).format('MM-DD-YYYY')
  }
  return data
}

function* perform(_a) {
  try {
    const formData = yield select(getActivityFilter)
    const params = handleQueryParams(formData)
    const response = yield api.fetchActivities(params)

    if (!response.error) {
      yield put(setActivities(response))
    }
  } catch (err) { console.log(err) }
}

function* watch(): Generator<*,*,*> {
  yield takeEvery(SAGA_FETCH_ACTIVITIES, perform)
}

export default watch
